//
//  PostCell.h
//  instagram-fbu-ca
//
//  Created by cassanene on 7/10/19.
//  Copyright © 2019 cassanene. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
#import "Parse/PFImageView.h"




NS_ASSUME_NONNULL_BEGIN

@interface PostCell : UITableViewCell
@property (weak, nonatomic) IBOutlet PFImageView *postimageView;

@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (strong, nonatomic) Post *post;

@end

NS_ASSUME_NONNULL_END
