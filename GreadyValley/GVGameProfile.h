//
//  GVGameProfile.h
//  GreadyValley
//
//  Created by rick on 11/29/13.
//  Copyright (c) 2013 woomoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GVGameProfile : UIView
@property(nonatomic,assign) CGFloat startX;
@property(nonatomic,assign) CGFloat startY;
- (void) bulidViewWithPlays:(int) plays isShowBuzz:(BOOL) isShow;
@end
