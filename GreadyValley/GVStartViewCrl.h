//
//  GVStartViewCrl.h
//  GreadyValley
//
//  Created by rick on 11/28/13.
//  Copyright (c) 2013 woomoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GVStartViewCrl : UIViewController
@property(nonatomic,weak) IBOutlet UITextField *companyText;
@property(nonatomic,weak) IBOutlet UIImageView *profileImageView;
-(IBAction) onStart:(id)sender;
-(IBAction) onCumstmize:(id)sender;
@end
