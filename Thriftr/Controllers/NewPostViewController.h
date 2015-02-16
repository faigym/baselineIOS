//
//  NewPostViewController.h
//  Thriftr
//
//  Created by Matan on 1/24/15.
//  Copyright (c) 2015 Vardi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JVFloatLabeledTextField.h"
#import "JVFloatLabeledTextView.h"
@interface NewPostViewController : UIViewController
@property (nonatomic,assign) NSInteger selectedImage;
@property (strong, atomic) NSMutableArray *selectedImages;
@property (strong, atomic) NSMutableArray *modifyImages;
@property (strong, atomic) JVFloatLabeledTextField *titleField;
@property (strong, atomic) JVFloatLabeledTextField *priceField;
@property (strong, atomic) JVFloatLabeledTextView *descriptionField;
@property (strong, atomic) JVFloatLabeledTextField *categoryField;

@end
