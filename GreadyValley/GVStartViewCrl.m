//
//  GVStartViewCrl.m
//  GreadyValley
//
//  Created by rick on 11/28/13.
//  Copyright (c) 2013 woomoo. All rights reserved.
//

#import "GVStartViewCrl.h"
#import "GVGameViewCrl.h"
@interface GVStartViewCrl ()

@end

@implementation GVStartViewCrl

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) onStart:(id)sender{
    GVGameViewCrl *gameViewCrl = [[GVGameViewCrl alloc] initWithNibName:@"GVGameViewCrl" bundle:nil];
    [self presentViewController:gameViewCrl animated:NO completion:nil];
    
}
-(void) onCumstmize:(id)sender{

}

@end
