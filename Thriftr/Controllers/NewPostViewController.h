//
//  NewPostViewController.h
//  Thriftr
//
//  Created by Matan on 1/24/15.
//  Copyright (c) 2015 Vardi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <NBUImagePicker/NBUCameraViewController.h>
#import "ObjectSlideView.h"
#import "UIImage+NBUAdditions.h"
@interface NewPostViewController : NBUCameraViewController

@property (weak, nonatomic) IBOutlet ObjectSlideView *slideView;

@property (weak, nonatomic) IBOutlet UIButton *shootButton;

- (IBAction)customToggleFlash:(id)sender;
@end
