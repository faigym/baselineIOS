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

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //configure swipe view
    _swipeView.alignment = SwipeViewAlignmentCenter;
    _swipeView.pagingEnabled = YES;
    _swipeView.itemsPerPage = 1;
    _swipeView.truncateFinalPage = YES;
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
    return 100;
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    NSLog(@"Loading index %i ", index);

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
        
        //mock sale items
        if(index % 2 == 0){
            self.mainImageView.image = [UIImage imageNamed:@"Google_Bike"];
            self.price.text = @"$200";
        }


        

    

    return view;
}

-(void) swipeView:(SwipeView *)swipeView didSelectItemAtIndex:(NSInteger)index {
    UIView *view = [[NSBundle mainBundle] loadNibNamed:@"ItemDetail" owner:self options:nil][0];
    CGRect screen =  [[UIScreen mainScreen] bounds];
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, screen.size.width, 800.0)];
    parentView.backgroundColor =[UIColor whiteColor];
    [parentView addSubview:view];
    UIImage *testImage = [UIImage imageNamed:@"bmwpic"];
    NSArray *images = @[testImage, testImage, testImage];
    
    GKLParallaxPicturesViewController *paralaxViewController = [[GKLParallaxPicturesViewController alloc] initWithImages:images andContentView:parentView];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:paralaxViewController];
    
    [self presentViewController:navigationController animated:YES completion:nil];
        NSLog(@"Switch %i toggled", [_swipeView currentItemIndex]);
    
}

#pragma mark -
#pragma mark Control events



@end
