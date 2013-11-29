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
        NSDictionary *dictionary = @{@"_id":@"4fe9fa8d2aef4710b9000001",
                                     @"player_id":@"4fe9fa8d2aef4710b9000001",
                                     @"desc":@"what ever this event is",
                                     @"point":@"-10",
                                     @"url":@"//greedyvalley.com/img/20120312/4e836c8ab7293cce08000002_o.jpg"};
        
        self.dataarray = @[dictionary,dictionary,dictionary];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIView *bigProfileView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 90)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    UILabel *score = [[UILabel alloc] initWithFrame:CGRectMake(0 , 80, 80, 10)];
    score.text = @"buzz/100";
    imageView.image = [UIImage imageNamed:@"profile.jpg"];
    [bigProfileView addSubview:imageView];
    GVGameProfile *gameProfile = [[GVGameProfile alloc] initWithFrame:CGRectMake(0, 478, 320, 90)];
    [gameProfile bulidViewWithPlays:4];
    [gameProfile addSubview:bigProfileView];
    [self.view addSubview:gameProfile];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - datatable datasouce

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataarray  count];
}

#pragma mark - datatable deleage
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    }
    
    // Set up the cell...
    cell.textLabel.text = (NSString*)[[self.dataarray objectAtIndex:indexPath.row] objectForKey:@"desc"];
    return cell;
}
@end
