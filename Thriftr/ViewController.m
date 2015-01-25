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
#import "DetailedNavigationController.h"
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
    if (!view)
    {
    	//load new item view instance from nib
        //control events are bound to view controller in nib file
        //note that it is only safe to use the reusingView if we return the same nib for each
        //item view, if different items have different contents, ignore the reusingView value
    	view = [[NSBundle mainBundle] loadNibNamed:@"View" owner:self options:nil][0];
        NSLog(@"%ld",index);
        
        [self.background.layer setCornerRadius:10.0f];
        self.background.layer.borderColor = [UIColor blackColor].CGColor;
        self.background.layer.borderWidth = 1.0f;
        [self.background.layer setMasksToBounds:YES];

        

    }
    NSLog(@"%ld",index);
    return view;
}

-(void) swipeView:(SwipeView *)swipeView didSelectItemAtIndex:(NSInteger)index {
    UIWebView *testWebView = [[UIWebView alloc] init];
    [testWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://nshipster.com/"]]];
    
    UIImage *testImage = [UIImage imageNamed:@"bmwpic"];
    NSArray *images = @[testImage, testImage, testImage];
    
    GKLParallaxPicturesViewController *paralaxViewController = [[GKLParallaxPicturesViewController alloc] initWithImages:images
                                                                                                       andContentWebView:testWebView];
    DetailedNavigationController *navigationController = [[DetailedNavigationController alloc] initWithRootViewController:paralaxViewController];
    
    [self presentViewController:navigationController animated:YES completion:nil];
    
}

#pragma mark -
#pragma mark Control events



@end
