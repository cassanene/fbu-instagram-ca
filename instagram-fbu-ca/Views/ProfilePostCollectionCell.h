//
//  ProfilePostCollectionCell.h
//  instagram-fbu-ca
//
//  Created by cassanene on 7/11/19.
//  Copyright © 2019 cassanene. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
NS_ASSUME_NONNULL_BEGIN

@interface ProfilePostCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *postImageView;
@property (strong, nonatomic) Post *post;
@end

NS_ASSUME_NONNULL_END
