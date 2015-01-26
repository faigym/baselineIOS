//
//  SignupViewController.h
//  Ribbit
//
//  Created by Matan on 11/8/14.
//  Copyright (c) 2014 Vardi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignupViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *usernameField;

@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@property (weak, nonatomic) IBOutlet UITextField *emailField;

- (IBAction)signup:(id)sender;

- (IBAction)dismiss:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@end
