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

@interface TimelineViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *posts;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
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

- (void)getFeed {
    
    fetchPostcompletion:^(NSArray *posts, NSError *error) {
        if (posts){
             NSLog(@"😎😎😎 Successfully loaded home feed");
            for (Post *post in posts) {
                NSString *text = post.caption;
                NSLog(@"%@", text);
                
            }
            [self.tableView reloadData];
        }
        else {
            
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
        
    };
}
- (void) fetchPost {
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            // do something with the array of object returned by the call
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
    Post *newPost = [Post new];
    newPost.caption = [PFUser currentUser];
    newPost.image = [PFUser currentUser];
    
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/




- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"PostCell" forIndexPath:indexPath];
    Post* post = self.posts[indexPath.row];
    cell.post = post;
    
    cell.captionLabel.text = post.caption;
    PFFileObject *img = post.image;
    [img getDataInBackgroundWithBlock:^(NSData * imageData, NSError * error) {
        UIImage *imageToLoad = [UIImage imageWithData:imageData];
        [cell.postimageView setImage:imageToLoad];
    }];
    
    
    return cell;
    
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}



@end
