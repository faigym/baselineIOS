//
//  LoginViewController.h
//  Ribbit
//
//  Created by Matan on 11/8/14.
//  Copyright (c) 2014 Vardi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController


- (IBAction)login:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;


@end
