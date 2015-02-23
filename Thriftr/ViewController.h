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

@interface ViewController : UIViewController <SwipeViewDelegate, SwipeViewDataSource>



@property (weak, nonatomic) IBOutlet SwipeView *swipeView;

@property (strong ,nonatomic) NSMutableArray *posts;


@property (weak, nonatomic) IBOutlet UIView *background;



@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *itemTitle;

@property (weak, nonatomic) IBOutlet UILabel *itemDetails;

@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;

@property (strong, atomic) ImageCache *imageCache;
@end
