//
//  GVGameProfile.m
//  GreadyValley
//
//  Created by rick on 11/29/13.
//  Copyright (c) 2013 woomoo. All rights reserved.
//

#import "GVGameProfile.h"

@implementation GVGameProfile

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) bulidViewWithPlays:(int) plays{
    CGFloat startX = 80;
    for (int i = 1; plays >= i ; i++) {
        UIImageView *mainProfile = [[UIImageView alloc] initWithFrame:CGRectMake(startX + (i -1)  * 60, 10, 60, 30)];
        mainProfile.image = [UIImage imageNamed:@"profile.jpg"];
        UILabel *score = [[UILabel alloc] initWithFrame:CGRectMake(startX + (i - 1) * 60 , 40, 60, 10)];
        score.text = @"buzz/100";
        [self addSubview:mainProfile];
        [self addSubview:score];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
