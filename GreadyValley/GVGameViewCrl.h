//
//  GVGameViewCrl.h
//  GreadyValley
//
//  Created by rick on 11/29/13.
//  Copyright (c) 2013 woomoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GVGameProfile.h"
#import "GVEventViewCrl.h"
@interface GVGameViewCrl : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSMutableArray *dataarray;
@property (nonatomic,weak) IBOutlet UITableView *tableview;
@end
