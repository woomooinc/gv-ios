//
//  GVGameViewCrl.m
//  GreadyValley
//
//  Created by rick on 11/29/13.
//  Copyright (c) 2013 woomoo. All rights reserved.
//

#import "GVGameViewCrl.h"

@interface GVGameViewCrl ()

@end

@implementation GVGameViewCrl 

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
    UIView *bigProfileView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 50)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    UILabel *score = [[UILabel alloc] initWithFrame:CGRectMake(0 , 40, 60, 10)];
    score.text = @"buzz/100";
    imageView.image = [UIImage imageNamed:@"profile.jpg"];
    [bigProfileView addSubview:imageView];
    GVGameProfile *gameProfile = [[GVGameProfile alloc] initWithFrame:CGRectMake(0, 518, 320, 50)];
    [gameProfile bulidViewWithPlays:4];
    [gameProfile addSubview:bigProfileView];
    [self.view addSubview:gameProfile];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
