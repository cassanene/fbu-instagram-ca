//
//  ProfileViewController.m
//  instagram-fbu-ca
//
//  Created by cassanene on 7/11/19.
//  Copyright © 2019 cassanene. All rights reserved.
//

#import "ProfileViewController.h"
#import "Post.h"
#import "ProfilePostCollectionCell.h"


@interface ProfileViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) NSArray *posts;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self fetchPost];
}

- (void) fetchPost {
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    
    [query orderByDescending:@"createdAt"];
    query.limit = 20;
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            // do something with the array of object returned by the call
            
            self.posts = [NSMutableArray arrayWithArray:posts];
            [self.collectionView reloadData];
            
            
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
    
    
}


//#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}
//*/

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ProfilePostCollectionCell* cell =  [collectionView dequeueReusableCellWithReuseIdentifier:@"ProfilePostCollectionCell" forIndexPath:indexPath];
    Post* post = self.posts[indexPath.row];
    cell.post = post;
    

    PFFileObject *img = post.image;
    [img getDataInBackgroundWithBlock:^(NSData * imageData, NSError * error) {
        UIImage *imageToLoad = [UIImage imageWithData:imageData];
        [cell.postImageView setImage:imageToLoad];
    }];
    
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
        return self.posts.count;
}



@end
