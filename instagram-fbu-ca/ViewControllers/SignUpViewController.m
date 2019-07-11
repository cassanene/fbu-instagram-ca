//
//  SignUpViewController.m
//  instagram-fbu-ca
//
//  Created by cassanene on 7/9/19.
//  Copyright © 2019 cassanene. All rights reserved.
//

#import "SignUpViewController.h"
#import "Parse/Parse.h"

@interface SignUpViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)signupButton:(id)sender {
    PFUser *newUser = [PFUser user];
    
    // set user properties
    newUser.username = self.usernameField.text;
    newUser.email = self.emailField.text;
    newUser.password = self.passwordField.text;
    
    // call sign up function on the object
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        } else {
            NSLog(@"User registered successfully");
            
            // manually segue to logged in view
            [self performSegueWithIdentifier:@"loginSegue" sender:nil];
        }
    }];
    }

- (IBAction)onTap:(id)sender {
     [self.view endEditing:YES];
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
