//
//  GVViewController.h
//  GreadyValley
//
//  Created by rick on 11/28/13.
//  Copyright (c) 2013 woomoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
@interface GVViewController : UIViewController <UIScrollViewDelegate,FBLoginViewDelegate, FBRequestDelegate >
{
    NSArray *permissions;
    NSString *userName;
    NSString *udid;
    NSMutableDictionary *userData;
}
    
@property (nonatomic, retain)   NSString *udid;
@property (nonatomic, retain)   NSString *userName;
@property (nonatomic, retain)   NSMutableDictionary *userData;
@property (nonatomic, strong) IBOutlet UIScrollView *IntroScrollView;
@end
