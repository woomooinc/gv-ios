//
//  FacebookBridge.m
//  GreadyValley
//
//  Created by Abyss on 11/29/13.
//  Copyright (c) 2013 woomoo. All rights reserved.
//

#import "FacebookBridge.h"
#import "UIImageView+AFNetworking.h"
static FacebookBridge *instance = nil;
@implementation FacebookBridge
@synthesize userName;
@synthesize udid;
@synthesize userData;
@synthesize callbackDelegate;
+ (FacebookBridge*)getInstance
{
    if ( instance == nil ) {
        instance = [[FacebookBridge alloc] init];
    }
    return instance;
}

+ (void)destroyInstance
{
    instance = nil;
}

- (id)init
{
    self = [super init];
    if ( self ) {
        permissions = [[NSArray alloc] initWithObjects:
                       @"publish_stream",
                       @"publish_actions",
                       @"user_games_activity",
                       @"friends_games_activity", nil];
        [self activeSession];
    }
    return self;
}

#pragma mark --------------------- Class Methods --------------------------------
- (void)showMessage:(NSString*)title :(NSString*)content
{
    [[[UIAlertView alloc] initWithTitle:title message:content delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
}


- (void)fetchUserdata:(void(^)())blockCode
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    self.userData = [def objectForKey:@"FBUserInfo"];
    
    
    
    if ( userData == nil ) {
        [FBRequestConnection
         startForMeWithCompletionHandler:^(FBRequestConnection *connection,
                                           id<FBGraphUser> user,
                                           NSError *error) {
             // Code block here.
             // Issue Part not longer for SDK newest version
             
             NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
             [dict setObject:[user id] forKey:@"id"];
             [dict setObject:[user username] forKey:@"username" ];
             self.userData = dict;
             self.udid = [self.userData objectForKey:@"id"];
             self.userName = [self.userData objectForKey:@"username"];
             [def setObject:self.userData forKey:@"FBUserInfo"];
             [def setObject:self.userName forKey:@"FBName"];
             [def synchronize];
             NSLog(@"FBID:%@", self.udid);
             
             //[self showMessage:@"Fetch Userdata" :[NSString stringWithFormat:@"ID=%@ Username=%@",self.udid, self.userName] ];
             //517348050
             if ( blockCode != nil )
                 blockCode();
             
         }];
        return ;
    }
    
    self.udid = [self.userData objectForKey:@"id"];
    self.userName = [self.userData objectForKey:@"username"];
    if ( blockCode != nil )
        blockCode();
    
}

- (NSString*)getAccessToken
{
    return [[FBSession activeSession] accessTokenData].accessToken;
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
            //NSLog(@"FBSessionStateOpen.");
            [self fetchUserdata:nil];
            break;
        }
        case FBSessionStateClosed: {
            //NSLog(@"FBSessionStateClosed.");
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

- (BOOL)checkState
{
    if ( !FBSession.activeSession.isOpen ) {
        [self activeSession];
        return NO;
    }
    return YES;
}

- (void)activeSession
{
    
    [FBSession openActiveSessionWithReadPermissions:nil
                                       allowLoginUI:NO
                                  completionHandler:^(FBSession *session,
                                                      FBSessionState state,
                                                      NSError *error) {
                                      [self sessionStateChanged:session
                                                          state:state
                                                          error:error];
                                  }];
    
    
}

- (void)login:(void(^)())blockCode
{
    
    [FBSession openActiveSessionWithReadPermissions:nil
                                       allowLoginUI:YES
                                  completionHandler:^(FBSession *session,
                                                      FBSessionState state,
                                                      NSError *error) {
                                      if ( !error ) {
                                          [self showMessage:@"Login Status" :@"Logined!"];
                                      }
                                      [self sessionStateChanged:session
                                                          state:state
                                                          error:error];
                                      if ( blockCode != nil )
                                          blockCode();
                                  }];
}

- (void)logout
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    // Close the active session
    [def removeObjectForKey:@"FBUserInfo"];
    [def synchronize];
    
    [FBSession.activeSession closeAndClearTokenInformation];
    [self showMessage:@"Facebook Status" :@"Logout!"];
}

- (void)uploadPhoto:(NSDictionary*)params
{
    [self showMessage:@"Facebook Upload" :@"photo was uploading"];
    [FBRequestConnection startWithGraphPath:@"me/photos"
                                 parameters:params
                                 HTTPMethod:@"POST"
                          completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                              //NSLog(@"Photo was uploaded.");
                              [self showMessage:@"Facebook Upload" :@"photo was uploaded"];
                              if ( error ) {
                                  NSLog(@"FBRequestConnection Error:%@", [error localizedDescription] );
                              }
                          }];
    
}

- (void)updateScore:(int)score
{
    NSMutableDictionary *params =
    [NSMutableDictionary dictionaryWithObjectsAndKeys:
     [NSString stringWithFormat:@"%d",score], @"score",
     //     @"341848255839326|cLc7C5pvfc7J2h_xNxKFSU3nidg",@"access_token",
     nil];
    
    [FBRequestConnection startWithGraphPath:@"me/scores"
                                 parameters:params
                                 HTTPMethod:@"POST"
                          completionHandler:
     ^(FBRequestConnection *connection, id result, NSError *error) {
         if ( error ) {
             //                        NSLog(@"FB-UpdateScore Failed Result:%@", [error localizedDescription] );
         }
         else {
             //                        NSLog(@"FB-UpdateScore Successed:%d", score);
         }
     }
     ];
    
}

- (void)setProfilePicture:(UIImageView*)imgView FBID:(NSString*)fbid imageSize:(CGSize)size
{
    [self setProfilePicture:imgView FBID:fbid imageSize:size withBlock:nil];
}

- (void)setProfilePicture:(UIImageView*)imgView FBID:(NSString*)fbid imageSize:(CGSize)size withBlock:(void(^)())block
{
    NSString *photoSize = nil;
    if ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] &&
        ([UIScreen mainScreen].scale == 2.0)) {
        photoSize = [NSString stringWithFormat:@"?width=%d&height=%d", (int)size.width*2, (int)size.height*2];
    } else {
        photoSize = [NSString stringWithFormat:@"?width=%d&height=%d", (int)size.width, (int)size.height];
    }
    
    NSString *urlString =
    [NSString stringWithFormat:@"http://graph.facebook.com/%@/picture%@",
     fbid,photoSize];
    
    //[imgView setImageWithURL:[NSURL URLWithString:urlString]];
    __weak UIImageView *weakImgView = imgView;
    [imgView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] placeholderImage:nil success:
     ^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
         weakImgView.image = image;
         if ( block != nil )
             block();
         
     }
                            failure:nil];

}


#pragma mark ---------------- Facebook Delegates ---------------------



@end
