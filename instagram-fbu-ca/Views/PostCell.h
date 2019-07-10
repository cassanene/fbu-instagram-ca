//
//  PostCell.h
//  instagram-fbu-ca
//
//  Created by cassanene on 7/10/19.
//  Copyright © 2019 cassanene. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PostCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *postimageView;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;

@end

NS_ASSUME_NONNULL_END
