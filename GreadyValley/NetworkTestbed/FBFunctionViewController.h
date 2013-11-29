//
//  FBFunctionViewController.h
//  GreadyValley
//
//  Created by Abyss on 11/29/13.
//  Copyright (c) 2013 woomoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
@interface FBFunctionViewController : UIViewController
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


-(IBAction)buttonHandler:(id)sender;
@end
