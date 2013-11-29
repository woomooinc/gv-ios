//
//  FBFunctionViewController.m
//  GreadyValley
//
//  Created by Abyss on 11/29/13.
//  Copyright (c) 2013 woomoo. All rights reserved.
//

#import "FBFunctionViewController.h"
#import <FacebookSDK/FacebookSDK.h>

@interface FBFunctionViewController ()

@end

@implementation FBFunctionViewController

@synthesize udid;
@synthesize userData;
@synthesize userName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        permissions = [[NSArray alloc] initWithObjects:
                       @"publish_stream",
                       @"publish_actions",
                       @"user_games_activity",
                       @"friends_games_activity", nil];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ------------------ CLASS METHOD ------------------------
void FB_RequestWritePermissions()
{
    static bool bHaveRequestedPublishPermissions = false;
    
    if (!bHaveRequestedPublishPermissions)
    {
        /*
         NSArray *permissions = [[NSArray alloc] initWithObjects:
         @"publish_stream",
         @"publish_actions",
         @"user_games_activity",
         @"friends_games_activity", nil];
         */
        NSArray *permissions = [[NSArray alloc] initWithObjects:@"publish_actions", nil];
        
        
        [[FBSession activeSession] reauthorizeWithPublishPermissions:permissions defaultAudience:FBSessionDefaultAudienceFriends completionHandler:^(FBSession *session, NSError* error) {
            
            //            NSLog(@"Reauthorized with publish permissions.");
            
        }];
        
        bHaveRequestedPublishPermissions = true;
    }
}

- (void)FBLogin
{
    
    [FBSession openActiveSessionWithReadPermissions:nil
                    allowLoginUI:YES
                    completionHandler:^(FBSession *session,
                    FBSessionState state,
                    NSError *error) {
                    if ( !error ) {
                        FB_RequestWritePermissions();
                    }
                    [self sessionStateChanged:session state:state error:error];
    }];

}

- (void)sessionStateChanged:(FBSession *)session
                      state:(FBSessionState) state
                      error:(NSError *)error
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    switch (state) {
        case FBSessionStateOpen: {
            // Handle the logged in scenario
            
            // You may wish to show a logged in view
            NSLog(@"FBSessionStateOpen.");
            [self fetchUserdata];
            break;
        }
        case FBSessionStateClosed: {
            NSLog(@"FBSessionStateClosed.");
        }
            
        case FBSessionStateClosedLoginFailed: {
            //NSLog(@"FBSessionStateClosedLoginFailed.");
            // Handle the logged out scenario
            // Close the active session
            [FBSession.activeSession closeAndClearTokenInformation];
            
            [def synchronize];
            // You may wish to show a logged out view
            break;
        }
        default:
            break;
    }
    
    if (error) {
        // Handle authentication errors
    }
}

- (void)fetchUserdata
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    self.userData = [def objectForKey:@"FBUserInfo"];
    
    
    
    if ( userData == nil ) {
        [FBRequestConnection
         startForMeWithCompletionHandler:^(FBRequestConnection *connection,
                                           id<FBGraphUser> user,
                                           NSError *error) {
             // Code block here.
             self.userData = [NSMutableDictionary dictionaryWithDictionary:(NSDictionary*)user];
             self.udid = [self.userData objectForKey:@"id"];
             self.userName = [self.userData objectForKey:@"username"];
             [def setObject:self.userData forKey:@"FBUserInfo"];
             [def setObject:self.userName forKey:@"FBName"];
             [def synchronize];
             [self showMessage:@"Facebook FetchUserData" :self.userName];
             //             NSLog(@"Cache Facebook UserInfomation.");
         }];
        return ;
    }
    
    self.udid = [self.userData objectForKey:@"id"];
    self.userName = [self.userData objectForKey:@"username"];
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
        [FBSession.activeSession closeAndClearTokenInformation];
        return ;
    }
    
    // See if the app has a valid token for the current state.
    if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {
        // To-do, show logged in view
        [self showMessage:@"FB Login Status" :@"You Already Logged"];
        [self fetchUserdata];
    } else {
        // No, display the login page.
        [self FBLogin];
    }
}

@end
