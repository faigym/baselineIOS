//
//  FirstController.h
//  Thriftr
//
//  Created by Matan Vardi on 2/22/15.
//  Copyright (c) 2015 Vardi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwipeView.h"
#import "ImageCache.h"
@interface FirstController :  UIViewController <SwipeViewDelegate, SwipeViewDataSource>
@property (strong, nonatomic) SwipeView *swipeView;

@property (strong ,nonatomic) NSMutableArray *posts;

@property (strong, atomic) ImageCache *imageCache;


@property (weak, nonatomic) IBOutlet UIView *background;



@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *itemTitle;

@property (weak, nonatomic) IBOutlet UILabel *itemDetails;

@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@end


