//
//  FBFunctionViewController.m
//  GreadyValley
//
//  Created by Abyss on 11/29/13.
//  Copyright (c) 2013 woomoo. All rights reserved.
//

#import "FBFunctionViewController.h"
#import "FacebookBridge.h"
#import "UIImageView+AFNetworking.h"
#import "GVServerAPI.h"
@interface FBFunctionViewController ()

@end

@implementation FBFunctionViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIButton *btn = (UIButton*)[self.view viewWithTag:1];
    
    if ( [[FacebookBridge getInstance] checkState] ) {
        [btn setTitle:@"Logout" forState:UIControlStateNormal];
        [self loadUserInfo];
    }
    else {
        [btn setTitle:@"Login" forState:UIControlStateNormal];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ------------------ CLASS METHOD ------------------------
- (void)loadUserInfo
{
    [[FacebookBridge getInstance] fetchUserdata:^() {
        UIImageView *imgView = (UIImageView*)[self.view viewWithTag:102];
        UILabel *nameLaebl = (UILabel*)[self.view viewWithTag:101];
        nameLaebl.text = [NSString stringWithFormat:@"%@(%@)", [FacebookBridge getInstance].userName, [FacebookBridge getInstance].udid];
        
        [[FacebookBridge getInstance] setProfilePicture:imgView FBID:[FacebookBridge getInstance].udid imageSize:CGSizeMake(200, 200)];
        
    }];
    
}

- (void)resetUserInfo
{
    UIImageView *imgView = (UIImageView*)[self.view viewWithTag:102];
    [imgView setImage:nil];
    UILabel *nameLaebl = (UILabel*)[self.view viewWithTag:101];
    nameLaebl.text = @"Username";
}
- (void)showMessage:(NSString*)title :(NSString*)content
{
    [[[UIAlertView alloc] initWithTitle:title message:content delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
}

#pragma mark ------------------ CLASS EVENT --------------------------
-(IBAction)buttonHandler:(id)sender
{
    UIButton *btn = (UIButton*)sender;
    if ( btn.tag == -1 ) {
        [self dismissViewControllerAnimated:YES completion:nil];
        return ;
    }
    
    else if ( btn.tag == 2 ) {
        [[FacebookBridge getInstance] logout];
        return ;
    }
    else if ( btn.tag == 3 ) {
        GVServerAPI *api = [[GVServerAPI alloc] init];
        [api fbServerLoginWithfb_id:[FacebookBridge getInstance].udid withfb_token:[[FacebookBridge getInstance] getAccessToken]];
        [self showMessage:@"Facebook Token" :[[FacebookBridge getInstance] getAccessToken]];
        return ;
    }
    
    if ( btn.tag == 1 && [btn.titleLabel.text isEqualToString:@"Login"] ) {
        [[FacebookBridge getInstance] login:^(){
            [self loadUserInfo];
            [btn setTitle:@"Logout" forState:UIControlStateNormal];
        }];
    }
    else {
        [[FacebookBridge getInstance] logout];
        [self resetUserInfo];
        [btn setTitle:@"Login" forState:UIControlStateNormal];
    }
    /*
     // See if the app has a valid token for the current state.
     if ( FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded ) {
     // To-do, show logged in view
     [[FacebookBridge getInstance] fetchUserdata];
     } else {
     // No, display the login page.
     }
     */
}

@end
