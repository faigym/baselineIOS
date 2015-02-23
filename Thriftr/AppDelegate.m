//
//  AppDelegate.m
//  Thriftr
//
//  Created by Matan on 1/11/15.
//  Copyright (c) 2015 Vardi. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import "DEMOLeftMenuViewController.h"
#import "FirstController.h"
#import "AppConstant.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Parse setApplicationId:@"ieGYHifNmIi0B1xHSFbhTr4bIIk9Dl7gysrYXjI3" clientKey:@"6skcdSV7gYaYmxS5wabcKtOzSXoMpwI2GzWsnonR"];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
   // [self setupViewControllers];
    
    UIViewController *homeViewController = [FirstController new];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:homeViewController];
    DEMOLeftMenuViewController *leftMenuViewController = [[DEMOLeftMenuViewController alloc] init];

    
    RESideMenu *sideMenuViewController = [[RESideMenu alloc] initWithContentViewController:navigationController
                                                                    leftMenuViewController:leftMenuViewController
                                                                   rightMenuViewController:nil];
    sideMenuViewController.backgroundImage = [UIImage imageNamed:@"Stars"];
    sideMenuViewController.menuPreferredStatusBarStyle = 1; // UIStatusBarStyleLightContent
    sideMenuViewController.delegate = self;
    sideMenuViewController.contentViewShadowColor = [UIColor blackColor];
    sideMenuViewController.contentViewShadowOffset = CGSizeMake(0, 0);
    sideMenuViewController.contentViewShadowOpacity = 0.6;
    sideMenuViewController.contentViewShadowRadius = 12;
    sideMenuViewController.contentViewShadowEnabled = YES;
    self.window.rootViewController = sideMenuViewController;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
    
    
    [self.window setRootViewController:self.viewController];
    [self.window makeKeyAndVisible];
    
    //[self customizeInterface];
    //[self customizeTitle];
    return YES;
}

#pragma mark - Methods
/*
- (void)setupViewControllers {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
                                @"Main" bundle:[NSBundle mainBundle]];
    
    UIViewController *secondViewController =  [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    UIViewController *secondNavigationController = [[UINavigationController alloc]
                                                    initWithRootViewController:secondViewController];
    
    NewPostViewController *thirdViewController = [NewPostViewController new];
    UIViewController *thirdNavigationController = [[UINavigationController alloc]
                                                   initWithRootViewController:thirdViewController];
    
    RDVTabBarController *tabBarController = [[RDVTabBarController alloc] init];
    [tabBarController setViewControllers:@[firstNavigationController, secondNavigationController, thirdNavigationController]];
    self.viewController = tabBarController;
    
    [self customizeTabBarForController:tabBarController];
    self.tabBarController = [[UITabBarController alloc] init];
    [self.tabBarController setViewControllers:[NSArray arrayWithObjects:secondNavigationController,
                                             thirdNavigationController,nil]];
    self.tabBarController.tabBar.translucent = NO;

    self.tabBarController.selectedIndex = DEFAULT_TAB;
    
    self.viewController = self.tabBarController;

    
  }*/
/*
- (void)customizeTabBarForController:(RDVTabBarController *)tabBarController {
    UIImage *finishedImage = [UIImage imageNamed:@"tabbar_selected_background"];
    UIImage *unfinishedImage = [UIImage imageNamed:@"tabbar_normal_background"];
    NSArray *tabBarItemImages = @[@"first", @"second", @"third"];
    
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[tabBarController tabBar] items]) {
        [item setBackgroundSelectedImage:unfinishedImage withUnselectedImage:unfinishedImage];
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",
                                                        [tabBarItemImages objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        
        index++;
    }
}

- (void)customizeInterface {
    UINavigationBar *navigationBarAppearance = [UINavigationBar appearance];
    
    UIImage *backgroundImage = nil;
    NSDictionary *textAttributes = nil;
    
    if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1) {
        backgroundImage = [UIImage imageNamed:@"navigationbar_background_tall"];
        
        textAttributes = @{
                           NSFontAttributeName: [UIFont boldSystemFontOfSize:18],
                           NSForegroundColorAttributeName: [UIColor blackColor],
                           };
    } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
        backgroundImage = [UIImage imageNamed:@"navigationbar_background"];
        
        textAttributes = @{
                           UITextAttributeFont: [UIFont boldSystemFontOfSize:18],
                           UITextAttributeTextColor: [UIColor blackColor],
                           UITextAttributeTextShadowColor: [UIColor clearColor],
                           UITextAttributeTextShadowOffset: [NSValue valueWithUIOffset:UIOffsetZero],
                           };
#endif
    }
    
    [navigationBarAppearance setBackgroundImage:backgroundImage
                                  forBarMetrics:UIBarMetricsDefault];
    [navigationBarAppearance setTitleTextAttributes:textAttributes];
}*/

-(void) customizeTitle {
    // set the title text property, color, font, size and so on
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    shadow.shadowOffset = CGSizeMake(0, 1);
    //  RGB(240,87,96),NSForegroundColorAttributeName,
    /*[[UINavigationBar appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIFont fontWithName:@"HelveticaNeue-Light" size:28.0], NSFontAttributeName, nil]];*/

}
@end



