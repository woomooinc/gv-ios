//
//  FBFunctionViewController.m
//  GreadyValley
//
//  Created by Abyss on 11/29/13.
//  Copyright (c) 2013 woomoo. All rights reserved.
//

#import "FBFunctionViewController.h"
#import "FacebookBridge.h"
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
    [[FacebookBridge getInstance] activeSession];
    
    UILabel *nameLaebl = (UILabel*)[self.view viewWithTag:101];
    nameLaebl.text = [NSString stringWithFormat:@"%@(%@)", [FacebookBridge getInstance].userName, [FacebookBridge getInstance].udid];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ------------------ CLASS METHOD ------------------------

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
    
    // See if the app has a valid token for the current state.
    if ( FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded ) {
        // To-do, show logged in view
        [[FacebookBridge getInstance] fetchUserdata];
    } else {
        // No, display the login page.
        [[FacebookBridge getInstance] login];
    }
}

@end
