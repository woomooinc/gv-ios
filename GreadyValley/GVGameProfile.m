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



- (void) bulidViewWithPlays:(int) plays isShowBuzz:(BOOL) isShow{
    for (int i = 1; plays >= i ; i++) {
        UIImageView *mainProfile = [[UIImageView alloc] initWithFrame:CGRectMake(self.startX + (i -1)  * 55, self.startY, 50, 50)];
        mainProfile.image = [self ellipseImage:[UIImage imageNamed:@"profile.jpg"] withInset:3 withBorderWidth:2 withBorderColor:[UIColor whiteColor]];
        if(isShow){
            UILabel *score = [[UILabel alloc] initWithFrame:CGRectMake(self.startX + (i - 1) * 55 , 70, 60, 10)];
            score.textColor = [UIColor whiteColor];
            score.font = [UIFont fontWithName:@"Arial" size:10];
            score.textAlignment = UITextAlignmentCenter;
            score.text = @"buzz/100";
            [self addSubview:score];
        }
        [self addSubview:mainProfile];
        
    }
}


- (UIImage *) ellipseImage: (UIImage *) image withInset: (CGFloat) inset withBorderWidth:(CGFloat)width withBorderColor:(UIColor*)color
{
    UIGraphicsBeginImageContext(image.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(inset, inset, image.size.width - inset * 2.0f , image.size.height - inset * 2.0f);
    
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    [image drawInRect:rect];
    
    if (width > 0) {
        CGContextSetStrokeColorWithColor(context, color.CGColor);
        CGContextSetLineCap(context,kCGLineCapButt);
        CGContextSetLineWidth(context, width);
        CGContextAddEllipseInRect(context, CGRectMake(inset + width/2, inset +  width/2, image.size.width - width- inset * 2.0f, image.size.height - width - inset * 2.0f));//在这个框中画圆
        
        CGContextStrokePath(context);
    }
    
    
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;
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
