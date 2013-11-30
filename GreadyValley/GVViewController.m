//
//  GVViewController.m
//  GreadyValley
//
//  Created by rick on 11/28/13.
//  Copyright (c) 2013 woomoo. All rights reserved.
//

#import "GVViewController.h"
#import "GVStartViewCrl.h"
#import "FacebookBridge.h"
#import "FBFunctionViewController.h"

@interface GVViewController ()
@property (nonatomic,strong) UIImageView *logoImageView;
@property (nonatomic,strong) UIButton *loginbutton;
-(void) login:(id)sender;
@end

@implementation GVViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    UIImageView *image0 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
    UIImageView *image1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 568, 320, 568)];
    UIImageView *image2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 1136, 320, 568)];
    UIImageView *image3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 1704, 320, 568)];
    UIImageView *image4 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 2272, 320, 568)];
    UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake((320-258)/2,50, 258, 196)];

    UIView *loginView = [[UIView alloc] initWithFrame:CGRectMake(0, 2840, 320, 568)];
    
    UIImage *loginImage = [UIImage imageNamed:@"facebook_login.png"];
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.frame = CGRectMake(0, 308, 320, loginImage.size.height);
    [loginButton setImage:loginImage forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    
    
    image0.image = [UIImage imageNamed:@"0.jpg"];
    image1.image = [UIImage imageNamed:@"1.jpg"];
    image2.image = [UIImage imageNamed:@"2.jpg"];
    image3.image = [UIImage imageNamed:@"3.jpg"];
    image4.image = [UIImage imageNamed:@"4.jpg"];
    logo.image =[UIImage imageNamed:@"Logo.jpeg"];
    
    [self.IntroScrollView addSubview:image0];
    [self.IntroScrollView addSubview:image1];
    [self.IntroScrollView addSubview:image2];
    [self.IntroScrollView addSubview:image3];
    [self.IntroScrollView addSubview:image4];
    [loginView addSubview:loginButton];
    [loginView addSubview:logo];
    [self.IntroScrollView addSubview:loginView];
    self.IntroScrollView.contentSize = CGSizeMake(0,3408);
    self.IntroScrollView.delegate = self;
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    [btn setTitle:@"FB Test" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor colorWithWhite:0.5 alpha:1];
    [btn addTarget:self action:@selector(showFBTestUnit) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}
-(void) login:(id)sender
{
    if ( ![[FacebookBridge getInstance] checkState] )
        [[FacebookBridge getInstance] login:^(){
            GVStartViewCrl *startViewCrl = [[GVStartViewCrl alloc] initWithNibName:@"GVStartViewCrl" bundle:nil];
            [self presentViewController:startViewCrl animated:NO completion:nil];

        }];
    else {
        GVStartViewCrl *startViewCrl = [[GVStartViewCrl alloc] initWithNibName:@"GVStartViewCrl" bundle:nil];
        [self presentViewController:startViewCrl animated:NO completion:nil];
    }
}

-(void) showFBTestUnit
{
    FBFunctionViewController *fbVC = [[FBFunctionViewController alloc] init];
    [self presentViewController:fbVC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ------------------ CLASS EVENT --------------------------

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
}
@end
