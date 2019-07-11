//
//  DetailsViewController.h
//  instagram-fbu-ca
//
//  Created by cassanene on 7/11/19.
//  Copyright © 2019 cassanene. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *detailscaptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailstimestampLabel;
@property (weak, nonatomic) IBOutlet UIImageView *detailspostImageView;
@property (weak, nonatomic) Post *post;

@end

NS_ASSUME_NONNULL_END
