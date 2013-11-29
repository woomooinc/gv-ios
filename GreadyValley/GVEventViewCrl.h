//
//  GVEventViewCrl.h
//  GreadyValley
//
//  Created by rick on 11/29/13.
//  Copyright (c) 2013 woomoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GVEventViewCrl : UIViewController
@property(nonatomic,strong) UIImage *eventImage;
@property(nonatomic,strong) NSString *descString;
@property(nonatomic,weak)IBOutlet UIImageView *photo;
@property(nonatomic,weak)IBOutlet UITextView *desc;
-(IBAction)closeMySelf:(id)sender;
@end
