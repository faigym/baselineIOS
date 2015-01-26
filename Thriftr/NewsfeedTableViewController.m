//
//  TableViewController.m
//  Thriftr
//
//  Created by Matan on 1/11/15.
//  Copyright (c) 2015 Vardi. All rights reserved.
//

#import "NewsfeedTableViewController.h"
#import <Parse/Parse.h>
#import "WelcomeViewController.h"
#import "NavigationController.h"
#import "GKLParallaxPicturesViewController.h"


@interface NewsfeedTableViewController ()

@end

@implementation NewsfeedTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tableView.estimatedRowHeight = 0.0;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    
    [self.tableView reloadData];
}
-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if ([PFUser currentUser] == nil) {
        LoginUser(self);
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView
estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 318;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 318;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    // Configure the cell
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [self transitionToDetail];
    
}


-(void) transitionToDetail {
    

    UIView *view = [[NSBundle mainBundle] loadNibNamed:@"ItemDetail" owner:self options:nil][0];
    CGRect screen =  [[UIScreen mainScreen] bounds];
    UIView *parentView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, screen.size.width, 800.0)];
    parentView.backgroundColor =[UIColor whiteColor];
    [parentView addSubview:view];
    UIImage *testImage = [UIImage imageNamed:@"bmwpic"];
    NSArray *images = @[testImage, testImage, testImage];

    GKLParallaxPicturesViewController *paralaxViewController = [[GKLParallaxPicturesViewController alloc] initWithImages:images
                                                                                                       andContentView:parentView];
    NavigationController *navigationController = [[NavigationController alloc] initWithRootViewController:paralaxViewController];
    
    [self presentViewController:navigationController animated:YES completion:nil];
    
    
    
}

#pragma Parse

void LoginUser(id target)
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:
                                @"Main" bundle:[NSBundle mainBundle]];
    UIViewController *welcomeView= [storyboard instantiateViewControllerWithIdentifier:@"welcomeview"];
    NavigationController *navigationController = [[NavigationController alloc] initWithRootViewController:welcomeView];
    navigationController.navigationBar.hidden = YES;
    [target presentViewController:navigationController animated:YES completion:nil];
}

@end
