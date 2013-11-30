//
//  FacebookBridge.h
//  GreadyValley
//
//  Created by Abyss on 11/29/13.
//  Copyright (c) 2013 woomoo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FacebookSDK/FacebookSDK.h>

@interface FacebookBridge : NSObject
< FBLoginViewDelegate, FBRequestDelegate >
{
    NSArray *permissions;
    NSString *userName;
    NSString *udid;
    NSMutableDictionary *userData;
}

@property (nonatomic, retain)   NSString *udid;
@property (nonatomic, retain)   NSString *userName;
@property (nonatomic, retain)   NSMutableDictionary *userData;


+ (FacebookBridge*)getInstance;
+ (void)destroyInstance;
- (BOOL)checkState;
- (void)activeSession;
- (void)login;
- (void)logout;
- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error;

- (BOOL)isLogon;

- (void)uploadPhoto:(NSDictionary*)params;
- (void)updateScore:(int)score;
- (void)fetchUserdata;
- (NSString*)getAccessToken;

@end
