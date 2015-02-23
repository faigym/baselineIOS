//
//  ViewController.m
//  SwipeViewExample
//
//  Created by Nick Lockwood on 28/10/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "GKLParallaxPicturesViewController.h"
#import "RESideMenu.h"
#import "AppConstant.h"
#import <Parse/Parse.h>
#import "LNBRippleEffect.h"
@interface ViewController()
@property(nonatomic, strong) UIView *loadingView;
@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Home", @"");
        
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    [self getPosts];
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    CGFloat topOffset = 0;
    if(self.imageCache == nil){
        self.imageCache = [[ImageCache alloc] initWithMaxSize:1024 * 1024 * 30]; // 30MB image cache.
    }


    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage: [UIImage imageNamed: @"menu" ] style:UIBarButtonItemStylePlain target:self action:@selector(presentLeftMenuViewController:)];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    [self.view setTintColor:[UIColor blueColor]];
    
    topOffset = ([[UIApplication sharedApplication] statusBarFrame].size.height
                 + self.navigationController.navigationBar.frame.size.height);
#endif

    //configure swipe view
    _swipeView.alignment = SwipeViewAlignmentCenter;
    _swipeView.pagingEnabled = YES;
    _swipeView.itemsPerPage = 1;
    _swipeView.truncateFinalPage = YES;
    
    //Ripple Effect for loading
    self.loadingView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height)];
    LNBRippleEffect *rippleEffect = [[LNBRippleEffect alloc]initWithImage:[UIImage imageNamed:@"avatar"] Frame:CGRectMake((self.view.frame.size.width/2)-100 ,
                                                                                                              self.view.frame.size.height/2 -50 + topOffset, 100, 100) Color:[UIColor colorWithRed:(28.0/255.0) green:(212.0/255.0) blue:(255.0/255.0) alpha:1] Target:@selector(buttonTapped:) ID:self];
    [rippleEffect setRippleColor:[UIColor colorWithRed:(28.0/255.0) green:(212.0/255.0) blue:(255.0/255.0) alpha:1]];
    [rippleEffect setRippleTrailColor:[UIColor colorWithRed:(28.0/255.0) green:(212.0/255.0) blue:(255.0/255.0) alpha:0.5]];
    [self.loadingView setBackgroundColor:[UIColor blackColor]];
    [self.loadingView addSubview:rippleEffect];
    [self.view addSubview:self.loadingView];
    
    [self.navigationItem setTitle:@"Thriftr"];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
    self.tabBarItem.title = @"Home";
}

- (void)dealloc
{
    _swipeView.delegate = nil;
    _swipeView.dataSource = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    //generate 100 item views
    //normally we'd use a backing array
    //as shown in the basic iOS example
    //but for this example we haven't bothered
    return [self.posts count];
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{

    //load new item view instance from nib
    //control events are bound to view controller in nib file
    //note that it is only safe to use the reusingView if we return the same nib for each
    //item view, if different items have different contents, ignore the reusingView value
    view = [[NSBundle mainBundle] loadNibNamed:@"View" owner:self options:nil][0];
    
    
    //Set round corners
    [self.background.layer setCornerRadius:10.0f];
    self.background.layer.borderColor = [UIColor grayColor].CGColor;
    self.background.layer.borderWidth = 1.0f;
    [self.background.layer setMasksToBounds:YES];
    
    //set avatar image
    UIImage *avatarUser =[ UIImage imageNamed:@"avatar"];
    self.avatar.image = avatarUser;
    self.avatar.layer.cornerRadius = CGRectGetWidth(self.avatar.frame)/2.0f;
    [self.avatar.layer setBorderColor: [[UIColor whiteColor] CGColor]];
    [self.avatar.layer setBorderWidth: 2.0];


    PFObject *post = [self.posts objectAtIndex:index];
    PFFile *imageFile = post[LISTING_IMAGE_1];
    UIImageView *img = self.mainImageView;
    if(imageFile != nil) {
        dispatch_queue_t q = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
        dispatch_async(q, ^{
            NSString *key = [NSString stringWithFormat:@"%d", index];

            UIImage *image =  [self.imageCache get:key];
            if(image == nil){
                NSURL *imageURL = [[NSURL alloc] initWithString:imageFile.url];
                NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
                image = [UIImage imageWithData:imageData];
                [self.imageCache put:key value:image];
            }
            

            dispatch_async(dispatch_get_main_queue(), ^{
                img.image = image;
            });
        });
    }
    self.price.text = post[LISTING_PRICE];
    self.itemTitle.text = post[LISTING_TITLE];
    self.itemDetails.text = [NSString stringWithFormat:@"%@ - 3.4 miles Away", post[LISTING_USER]];
    return view;
}

-(void) swipeView:(SwipeView *)swipeView didSelectItemAtIndex:(NSInteger)index {
    UIView *view = [[NSBundle mainBundle] loadNibNamed:@"ItemDetail" owner:self options:nil][0];
    CGRect screen =  [[UIScreen mainScreen] bounds];
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, screen.size.width, 800.0)];
    parentView.backgroundColor =[UIColor whiteColor];
    [parentView addSubview:view];
    
    
    
    PFObject *post = [self.posts objectAtIndex:index];
    
    NSMutableArray *images = [[NSMutableArray alloc] init];
    //Pass from the cache
    UIImage *image1 = [self.imageCache get: [NSString stringWithFormat:@"%ld", (long)index]];
    [images addObject:image1];
    //All other images pass by url
    for (int i = 2; i < 5; i++){
        NSString *imageKey = [NSString stringWithFormat:@"Image%d",i];
        PFFile *imageFile = post[imageKey];
        if(imageFile != nil) {
            [images addObject:imageFile.url];
        }
    }
 
    
    GKLParallaxPicturesViewController *paralaxViewController = [[GKLParallaxPicturesViewController alloc] initWithImages:images andContentView:parentView];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:paralaxViewController];
    
    [self presentViewController:navigationController animated:YES completion:nil];
    
}

#pragma mark -
#pragma mark Control events
- (void) getPosts {
    [self.loadingView setHidden:false];
    PFQuery *query = [PFQuery queryWithClassName: LISTING_CLASS_NAME];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d scores.", objects.count);
            // Do something with the found objects
            self.posts = objects;
            
            NSInteger index = 0;
            for (PFObject *post in objects){
                
                PFFile *imageFile = post[LISTING_IMAGE_1];
                if(imageFile != nil) {
                    dispatch_queue_t q = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
                    dispatch_async(q, ^{
                        NSString *key = [NSString stringWithFormat:@"%d", index];
                        
                        UIImage *image =  [self.imageCache get:key];
                        if(image == nil){
                            NSURL *imageURL = [[NSURL alloc] initWithString:imageFile.url];
                            NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
                            image = [UIImage imageWithData:imageData];
                            [self.imageCache put:key value:image];
                        }
                        dispatch_async(dispatch_get_main_queue(), ^{
                            if(index == 0) {
                               [self.swipeView reloadData];
                              // [self.loadingView setHidden:true];
                            }
                        });
                    });
                }
                index++;
            }

            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}




@end
