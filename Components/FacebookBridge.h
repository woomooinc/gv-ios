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
@property (nonatomic, assign)   id  callbackDelegate;
@property (nonatomic, retain)   NSString *udid;
@property (nonatomic, retain)   NSString *userName;
@property (nonatomic, retain)   NSMutableDictionary *userData;


+ (FacebookBridge*)getInstance;
+ (void)destroyInstance;
- (BOOL)checkState;
- (void)activeSession;
- (void)login:(void(^)())blockCode;
- (void)logout;
- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error;

- (BOOL)isLogon;

- (void)uploadPhoto:(NSDictionary*)params;
- (void)updateScore:(int)score;
- (void)fetchUserdata:(void(^)())blockCode;
- (NSString*)getAccessToken;

- (void)setProfilePicture:(UIImageView*)imgView FBID:(NSString*)fbid imageSize:(CGSize)size;
- (void)setProfilePicture:(UIImageView*)imgView FBID:(NSString*)fbid imageSize:(CGSize)size withBlock:(void(^)())block;

@end
