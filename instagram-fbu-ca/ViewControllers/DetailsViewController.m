//
//  DetailsViewController.m
//  instagram-fbu-ca
//
//  Created by cassanene on 7/11/19.
//  Copyright © 2019 cassanene. All rights reserved.
//

#import "DetailsViewController.h"
#import "Post.h"
#import "PostCell.h"
#import "TimelineViewController.h"
#import "DateTools.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.detailstimestampLabel.text = self.post.timestamp.timeAgoSinceNow;
    self.detailscaptionLabel.text = self.post.caption;
    PFFileObject *img = self.post.image;
    [img getDataInBackgroundWithBlock:^(NSData * imageData, NSError * error) {
        UIImage *imageToLoad = [UIImage imageWithData:imageData];
        [self.detailspostImageView setImage:imageToLoad];
    }];
    

}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
