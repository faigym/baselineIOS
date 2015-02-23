//
//  ViewController.h
//  SwipeViewExample
//
//  Created by Nick Lockwood on 28/10/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwipeView.h"
#import "ImageCache.h"

@interface HomeViewController : UIViewController <SwipeViewDelegate, SwipeViewDataSource>



//@property (weak, nonatomic) IBOutlet SwipeView *swipeView;
@property (weak ,nonatomic) SwipeView *swipeView;
@property (strong ,nonatomic) NSMutableArray *posts;


@property (strong, atomic) ImageCache *imageCache;
@end