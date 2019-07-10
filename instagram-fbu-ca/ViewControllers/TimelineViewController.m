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

@interface TimelineViewController ()

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/




@end
