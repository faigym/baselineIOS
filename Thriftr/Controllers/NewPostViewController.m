//
//  NewPostViewController.m
//  Thriftr
//
//  Created by Matan on 1/24/15.
//  Copyright (c) 2015 Vardi. All rights reserved.
//

#import "NewPostViewController.h"

@interface NewPostViewController ()

@end

@implementation NewPostViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Configure the slide view
    _slideView.targetObjectViewSize = CGSizeMake(46.0, 46.0);
    _slideView.margin = CGSizeMake(2.0, 2.0);
    
    // Configure the camera view
    //self.cameraView.shouldAutoRotateView = YES;
    //self.cameraView.savePicturesToLibrary = YES;
    self.cameraView.targetResolution = CGSizeMake(640.0, 640.0); // The minimum resolution we want
    self.cameraView.keepFrontCameraPicturesMirrored = YES;
    self.cameraView.captureResultBlock = ^(UIImage * image,
                                           NSError * error)
    {
        if (!error)
        {
            // *** Only used to update the slide view ***
            UIImage * thumbnail = [image thumbnailWithSize:_slideView.targetObjectViewSize];
            NSMutableArray * tmp = [NSMutableArray arrayWithArray:_slideView.objectArray];
            [tmp insertObject:thumbnail atIndex:0];
            _slideView.objectArray = tmp;
        }
    };
    self.cameraView.flashButtonConfigurationBlock = [self.cameraView buttonConfigurationBlockWithTitleFrom:
                                                     @[@"Flash Off", @"Flash On", @"Flash Auto"]];
    self.cameraView.focusButtonConfigurationBlock = [self.cameraView buttonConfigurationBlockWithTitleFrom:
                                                     @[@"Fcs Lckd", @"Fcs Auto", @"Fcs Cont"]];
    self.cameraView.exposureButtonConfigurationBlock = [self.cameraView buttonConfigurationBlockWithTitleFrom:
                                                        @[@"Exp Lckd", @"Exp Auto", @"Exp Cont"]];
    self.cameraView.whiteBalanceButtonConfigurationBlock = [self.cameraView buttonConfigurationBlockWithTitleFrom:
                                                            @[@"WB Lckd", @"WB Auto", @"WB Cont"]];
    
    
    // Optionally auto-save pictures to the library
    self.cameraView.saveResultBlock = ^(UIImage * image,
                                        NSDictionary * metadata,
                                        NSURL * url,
                                        NSError * error)
    {
        // *** Do something with the image and its URL ***
    };
    
    // Connect the shoot button
    self.cameraView.shootButton = _shootButton;
    [_shootButton addTarget:self.cameraView
                     action:@selector(takePicture:)
           forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    // Disconnect shoot button
    [_shootButton removeTarget:nil
                        action:@selector(takePicture:)
              forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Enable shootButton
    _shootButton.userInteractionEnabled = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // Disable shootButton
    _shootButton.userInteractionEnabled = NO;
}

- (IBAction)shootButton:(id)sender {
}

- (IBAction)customToggleFlash:(id)sender
{
    // We intentionally skip AVCaptureFlashModeAuto
    if (self.cameraView.currentFlashMode == AVCaptureFlashModeOff)
    {
        self.cameraView.currentFlashMode = AVCaptureFlashModeOn;
    }
    else
    {
        self.cameraView.currentFlashMode = AVCaptureFlashModeOff;
    }
}



@end
