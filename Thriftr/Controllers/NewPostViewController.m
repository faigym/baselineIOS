//
//  NewPostViewController.m
//  Thriftr
//
//  Created by Matan on 1/24/15.
//  Copyright (c) 2015 Vardi. All rights reserved.
//

#import "NewPostViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "AppConstant.h"
#import "ViewController.h"
#import <Parse/Parse.h>
#import <SVProgressHUD/SVProgressHUD.h>

const static CGFloat kJVFieldHeight = 44.0f;
const static CGFloat kJVFieldHMargin = 10.0f;

const static CGFloat kJVFieldFontSize = 16.0f;

const static CGFloat kJVFieldFloatingLabelFontSize = 11.0f;
@interface NewPostViewController ()

@end

@implementation NewPostViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"New Listing", @"");
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // Navigation Bar Buttons
    [self.navigationItem setTitle:@"New Listing"];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonSystemItemDone target:self action:@selector(exitNewPost)];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Post" style:UIBarButtonSystemItemDone target:self action:@selector(createListing)];
  
    
    self.isImagePresent = [[NSMutableSet alloc] init];
    
    
    
    CGFloat topOffset = 0;
    CGFloat imageMargin = 10.0f;
    CGFloat imageSize = (self.view.frame.size.width - imageMargin*5)/4.0f;
    CGFloat buttonSize = 20.0f;
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    [self.view setTintColor:[UIColor blueColor]];
    
    topOffset = ([[UIApplication sharedApplication] statusBarFrame].size.height
                 + self.navigationController.navigationBar.frame.size.height);
#endif
    
    
    //Image buttons
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.selectedImages = [[NSMutableArray alloc] init];
    self.modifyImages = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < 4; i++){
        UIImageView *img1 = [[UIImageView alloc] initWithFrame:CGRectMake((imageMargin*(i+1) + imageSize*i), topOffset + imageMargin, imageSize, imageSize)];
        [img1 setBackgroundColor:RGB(228,228,222)];

        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(singleTapGestureCaptured:)];
        [img1 setTag:i];
        [img1 addGestureRecognizer:singleTap];
        [img1 setMultipleTouchEnabled:YES];
        [img1 setUserInteractionEnabled:YES];
        [self.selectedImages addObject:img1];
        [self.view addSubview:img1];
        
        UIImageView *img1Button = [[UIImageView alloc]
                                initWithFrame:CGRectMake(img1.frame.origin.x + imageSize - buttonSize,
                               img1.frame.origin.y + imageSize - buttonSize, buttonSize, buttonSize)];
        [img1Button setImage:[UIImage imageNamed:@"add-image"] ];
        [img1Button setBackgroundColor:[UIColor whiteColor]];
        img1Button.layer.cornerRadius = 10;
        img1Button.layer.masksToBounds = YES;
        [self.modifyImages addObject:img1Button];
        [self.view addSubview:img1Button];


    }
    
   
    UITextField *detailsTitle = [[UITextField alloc] initWithFrame:CGRectMake(kJVFieldHMargin, topOffset + imageSize+ imageMargin, self.view.frame.size.width-2*kJVFieldHMargin, kJVFieldHeight)];
    detailsTitle.text = @"DETAILS";
    detailsTitle.font =  [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
    detailsTitle.textColor = [UIColor blackColor];
    detailsTitle.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:detailsTitle];
    
    UIView *detailDiv = [[UIView alloc] init];
    detailDiv.frame = CGRectMake(kJVFieldHMargin, detailsTitle.frame.origin.y + detailsTitle.frame.size.height, self.view.frame.size.width - 2*kJVFieldHMargin, 1.0f);
    detailDiv.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.3f];
    
    [self.view addSubview:detailDiv];
    
    
    
    UIColor *floatingLabelColor = [UIColor blackColor];
    
    self.titleField = [[JVFloatLabeledTextField alloc] initWithFrame:
                                           CGRectMake(kJVFieldHMargin,
                                                      detailDiv.frame.origin.y+detailDiv.frame.size.height,
                                                      self.view.frame.size.width - 2 * kJVFieldHMargin,
                                                      kJVFieldHeight)];
    self.titleField.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Title", @"")
                                    attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
    self.titleField.font = [UIFont systemFontOfSize:kJVFieldFontSize];
    self.titleField.floatingLabel.font = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
    self.titleField.floatingLabelTextColor = floatingLabelColor;
    self.titleField.clearButtonMode = UITextFieldViewModeWhileEditing;
    //    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 30.0f, 30.0f)];
    //    titleField.leftView = leftView;
    //    titleField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:self.titleField];
    
    UIView *div1 = [UIView new];
    div1.frame = CGRectMake(kJVFieldHMargin, self.titleField.frame.origin.y + self.titleField.frame.size.height,
                            self.view.frame.size.width - 2 * kJVFieldHMargin, 1.0f);
    div1.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3f];
    [self.view addSubview:div1];
    
    self.priceField = [[JVFloatLabeledTextField alloc] initWithFrame:
                                           CGRectMake(kJVFieldHMargin,
                                                      div1.frame.origin.y + div1.frame.size.height,
                                                      80.0f,
                                                      kJVFieldHeight)];
    self.priceField.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Price", @"")
                                    attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
    self.priceField.font = [UIFont systemFontOfSize:kJVFieldFontSize];
    self.priceField.floatingLabel.font = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
    self.priceField.floatingLabelTextColor = floatingLabelColor;
    [self.view addSubview:self.priceField];
    
    UIView *div2 = [UIView new];
    div2.frame = CGRectMake(kJVFieldHMargin + self.priceField.frame.size.width,
                            self.titleField.frame.origin.y + self.titleField.frame.size.height,
                            1.0f, kJVFieldHeight);
    div2.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3f];
    [self.view addSubview:div2];
    
    self.categoryField =
    [[JVFloatLabeledTextField alloc] initWithFrame:
     CGRectMake(kJVFieldHMargin + kJVFieldHMargin + self.priceField.frame.size.width + 1.0f,
                div1.frame.origin.y + div1.frame.size.height,
                self.view.frame.size.width - 3*kJVFieldHMargin - self.priceField.frame.size.width - 1.0f,
                kJVFieldHeight)];
    
    self.categoryField.attributedPlaceholder =
    [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Category", @"")
                                    attributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
    self.categoryField.font = [UIFont systemFontOfSize:kJVFieldFontSize];
    self.categoryField.floatingLabel.font = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
    self.categoryField.floatingLabelTextColor = floatingLabelColor;
    [self.view addSubview:self.categoryField];
    
    UIView *div3 = [UIView new];
    div3.frame = CGRectMake(kJVFieldHMargin, self.priceField.frame.origin.y + self.priceField.frame.size.height,
                            self.view.frame.size.width - 2*kJVFieldHMargin, 1.0f);
    div3.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3f];
    [self.view addSubview:div3];
    
    self.descriptionField =
    [[JVFloatLabeledTextView alloc] initWithFrame:CGRectMake(kJVFieldHMargin,
                                                             div3.frame.origin.y + div3.frame.size.height,
                                                             self.view.frame.size.width - 2*kJVFieldHMargin,
                                                             kJVFieldHeight*3)];
    self.descriptionField.placeholder = NSLocalizedString(@"Description", @"");
    self.descriptionField.placeholderTextColor = [UIColor darkGrayColor];
    self.descriptionField.font = [UIFont systemFontOfSize:kJVFieldFontSize];
    self.descriptionField.floatingLabel.font = [UIFont boldSystemFontOfSize:kJVFieldFloatingLabelFontSize];
    self.descriptionField.floatingLabelTextColor = floatingLabelColor;
    [self.view addSubview:self.descriptionField];
    
    [self.titleField becomeFirstResponder];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) singleTapGestureCaptured: (UIGestureRecognizer *)sender{
    self.selectedImage = [sender.view tag];
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:nil
                                  message:nil
                                  preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction* viewImage = [UIAlertAction
                         actionWithTitle:@"View Photo"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    UIAlertAction* camera = [UIAlertAction
                                actionWithTitle:@"Take a Photo"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    
                                    [alert dismissViewControllerAnimated:YES completion:nil];
                                    [self promptForCamera];
                                    
                                }];
    UIAlertAction* library = [UIAlertAction
                             actionWithTitle:@"Choose from Library"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 [self promptForPhotoRoll];
                                 
                             }];
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"Cancel"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    
    [alert addAction:viewImage];
    [alert addAction:camera];
    [alert addAction:library];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)promptForCamera {
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.sourceType = UIImagePickerControllerSourceTypeCamera;
    controller.delegate = self;
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)promptForPhotoRoll {
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    controller.delegate = self;
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    UIImageView *currentImage = [self.selectedImages objectAtIndex:self.selectedImage];
    [self.isImagePresent addObject: [NSString stringWithFormat:@"%d",self.selectedImage]];
    UIImageView *modifyImage = [self.modifyImages objectAtIndex:self.selectedImage];
    [modifyImage setHidden:true];
    currentImage.image = image;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) createListing {

    if([self.descriptionField.text length] == 0 ||
       [self.priceField.text length] == 0 ||
       [self.titleField.text length] == 0 ||
       [self.categoryField.text length] == 0 ){
        //handle them errors
        [self displayAlertView:@"Please provide a complete item description." withTitle: @"Error"];
        return;
    }
    PFObject *listing = [PFObject objectWithClassName:LISTING_CLASS_NAME];
    PFUser *user = [PFUser currentUser];
    listing[LISTING_TITLE] = self.titleField.text;
    listing[LISTING_PRICE] = self.priceField.text;
    listing[LISTING_DESCRIPTION] = self.descriptionField.text;
    listing[LISTING_CATEGORY] = self.categoryField.text;
    listing[LISTING_USER] = [user username];
    listing[LISTING_USER_ID] = [user objectId];
    
    int index = 0;
    for (UIImageView *imageView in self.selectedImages){
        if([self.isImagePresent containsObject:[NSString stringWithFormat:@"%d",index]]) {
            NSString *imageKey = [@"Image" stringByAppendingString:[@(index+1) stringValue]];
            NSString *imageName = [@"image" stringByAppendingString:[@(index+1) stringValue]];
            imageName = [imageName stringByAppendingString:@".png"];
            UIImage *resizedImage = [self resizeImage:imageView.image toWidth:self.view.frame.size.width andHeight:390.0f];
            NSData *imageData = UIImagePNGRepresentation(resizedImage);

            PFFile *imageFile = [PFFile fileWithName:imageName data:imageData];
            listing[imageKey]= imageFile;
            
            index++;
        }
        
    }
    //save pictures
    [SVProgressHUD show];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // time-consuming task
        
        [listing saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            if(succeeded){
                [self exitNewPost];
            }
            else{
                [self displayAlertView:[error localizedDescription] withTitle: @"Something went wrong."];
            }
        }];

    });

    
}

-(void) displayAlertView: (NSString *) message withTitle: (NSString *)title {
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:title andMessage:message];
    [alertView addButtonWithTitle:@"OK"
                             type:SIAlertViewButtonTypeDefault
                          handler:^(SIAlertView *alertView) {
                          }];
    alertView.titleColor = [UIColor redColor];
    alertView.cornerRadius = 10;
    alertView.buttonFont = [UIFont boldSystemFontOfSize:15];
    alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
    [alertView show];
}

- (UIImage *)resizeImage:(UIImage *)image toWidth:(float)width andHeight:(float)height {
    CGSize newSize = CGSizeMake(width, height);
    CGRect newRect = CGRectMake(0, 0, width, height);
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:newRect];
    UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resizedImage;
}

-(void) exitNewPost {
    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[ [ViewController alloc] initWithNibName:@"ViewController" bundle:nil]] animated:YES];
}


@end
