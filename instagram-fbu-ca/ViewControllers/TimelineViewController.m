//
//  TimelineViewController.m
//  instagram-fbu-ca
//
//  Created by cassanene on 7/9/19.
//  Copyright © 2019 cassanene. All rights reserved.
//

#import "TimelineViewController.h"
#import "Parse/Parse.h"
#import "AppDelegate.h"
#import "Login2ViewController.h"
#import "PostCell.h"
#import "Post.h"
#import "DetailsViewController.h"
#import "DateTools.h"
#import "CameraViewController.h"

@interface TimelineViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 400;
    
    [self fetchPost];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchPost) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
    [self.tableView addSubview:self.refreshControl];
    [self.activityIndicator startAnimating];
}
- (IBAction)logoutButton:(id)sender {
    NSLog(@" CLicked User Logged out");
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        NSLog(@"User Logged out");
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        Login2ViewController *login2ViewController = [storyboard instantiateViewControllerWithIdentifier:@"Login2ViewController"];
        [self presentViewController:login2ViewController animated:YES completion:nil];
        appDelegate.window.rootViewController = login2ViewController;
    }];
}
- (IBAction)composeButton:(id)sender {
    [self performSegueWithIdentifier:@"composepostSegue" sender:nil];
}

- (void) fetchPost {
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"author"];
    query.limit = 20;
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            // do something with the array of object returned by the call
            
            self.posts = [NSMutableArray arrayWithArray:posts];
            [self.tableView reloadData];

            
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
        // Stop the activity indicator
        [self.activityIndicator stopAnimating];
        // Hides automatically if "Hides When Stopped" is enabled
        [self.refreshControl endRefreshing];
    }];
    
    
}


//#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"detailsSegue"]){
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
        Post* post = self.posts[indexPath.row];
        DetailsViewController *detailsViewController = [segue destinationViewController];
        detailsViewController.post = post;
        
    }
    else if ([segue.identifier isEqualToString:@"composepostSegue"]){
        CameraViewController *cameraViewController = [segue destinationViewController];
    }
    
}





- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"PostCell" forIndexPath:indexPath];
    Post* post = self.posts[indexPath.row];
    cell.post = post;
    NSDate *time =post.createdAt;
    
    cell.timestamp.text = time.shortTimeAgoSinceNow;
    
    cell.captionLabel.text = post.caption;
    cell.usernameLabel.text = post.author.username;
    PFFileObject *img = post.image;
    [img getDataInBackgroundWithBlock:^(NSData * imageData, NSError * error) {
        UIImage *imageToLoad = [UIImage imageWithData:imageData];
        [cell.postimageView setImage:imageToLoad];
    }];
    
    
    return cell;
}


@end
