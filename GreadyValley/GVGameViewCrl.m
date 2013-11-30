//
//  GVGameViewCrl.m
//  GreadyValley
//
//  Created by rick on 11/29/13.
//  Copyright (c) 2013 woomoo. All rights reserved.
//

#import "GVGameViewCrl.h"
#import "FacebookBridge.h"
@interface GVGameViewCrl ()

@end
#define FONT_SIZE 14.0f
#define CELL_CONTENT_WIDTH 250.0f
#define CELL_CONTENT_MARGIN 10.0f
@implementation GVGameViewCrl 

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        NSString *myfbid = [FacebookBridge getInstance].udid;
        NSDictionary *dictionary = @{@"_id":@"517348050",
                                     @"player_id":@"4fe9fa8d2aef4710b9000001",
                                     @"desc":@"Happiness is having a large, loving, caring, close-knit family in another city.\n\n\t\t-George Burns (1896 - 1996)",
                                     @"point":@"-10",
                                     @"url":@"//greedyvalley.com/img/20120312/4e836c8ab7293cce08000002_o.jpg"
                                     };
        NSDictionary *dictionary2 = @{@"_id":@"517348050",
                                     @"player_id":@"4fe9fa8d2aef4710b9000001",
                                     @"desc":@"what ever this event is\nwhat ever this event is\nwhat ever this event is",
                                     @"point":@"-10",
                                     @"url":@"//greedyvalley.com/img/20120312/4e836c8ab7293cce08000002_o.jpg"

                                      };
        
        NSArray *temp_dataarray = @[dictionary,dictionary2,dictionary,dictionary2,dictionary];
        self.dataarray = [NSMutableArray arrayWithArray:temp_dataarray];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIView *bigProfileView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, 70, 70)];
    UILabel *score = [[UILabel alloc] initWithFrame:CGRectMake(5,70,70,10)];
    score.textColor = [UIColor whiteColor];
    score.font = [UIFont fontWithName:@"Arial" size:10];
    score.textAlignment = UITextAlignmentCenter;
    score.text = @"buzz/100";
    imageView.image = [self ellipseImage:[UIImage imageNamed:@"profile.jpg"] withInset:5 withBorderWidth:2 withBorderColor:[UIColor whiteColor]];
    [bigProfileView addSubview:imageView];
    [bigProfileView addSubview:score];
    GVGameProfile *gameProfile = [[GVGameProfile alloc] initWithFrame:CGRectMake(0, 483, 320, 85)];
    gameProfile.startX = 90;
    gameProfile.startY = 20;
    [gameProfile bulidViewWithPlays:4 isShowBuzz:YES];
    [gameProfile addSubview:bigProfileView];
    [self.view addSubview:gameProfile];
    self.tableview.backgroundView = nil;
    self.tableview.backgroundColor = [UIColor clearColor];
    self.tableview.opaque = NO;
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    [btn setTitle:@"insert Test" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor colorWithWhite:0.5 alpha:1];
    [btn addTarget:self action:@selector(bigdeal) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

}

-(void) viewDidAppear:(BOOL)animated{
    
//    GVEventViewCrl *eventCrl = [[GVEventViewCrl alloc] initWithNibName:@"GVEventViewCrl" bundle:nil];
//    eventCrl.eventImage = [UIImage imageNamed:@"profile.jpg"];
//    eventCrl.descString = @"what ever this event is\nwhat ever this event is\nwhat ever this event is";
//    [self presentViewController:eventCrl animated:YES completion:nil];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSString *text = [[self.dataarray objectAtIndex:indexPath.row] objectForKey:@"desc"];
    
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    
    NSDictionary * attributes = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:FONT_SIZE] forKey:NSFontAttributeName];
    NSAttributedString *attributedText =
    [[NSAttributedString alloc]
     initWithString:text
     attributes:attributes];
    CGRect rect = [attributedText boundingRectWithSize:constraint
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    CGSize size = rect.size;
    
    
    CGFloat height = MAX(size.height, 44.0f);
    
    return height + (CELL_CONTENT_MARGIN * 2);
}


#pragma mark - datatable deleage
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UILabel *label = nil;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
        label = [[UILabel alloc] initWithFrame:CGRectZero];
        [label setLineBreakMode:NSLineBreakByWordWrapping];
        [label setMinimumScaleFactor:FONT_SIZE];
        [label setNumberOfLines:0];
        [label setFont:[UIFont systemFontOfSize:FONT_SIZE]];
        [label setTag:1];
        label.textColor = [UIColor whiteColor];
        [[label layer] setBorderWidth:1.0f];
        [[label layer] setBorderColor:[UIColor whiteColor].CGColor];
        [[cell contentView] addSubview:label];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        UIView *backView = [[UIView alloc] initWithFrame:CGRectZero];
        backView.backgroundColor = [UIColor clearColor];
        cell.backgroundView = backView;
    }
    
    // Set up the cell...
    NSString *text =[[self.dataarray objectAtIndex:indexPath.row] objectForKey:@"desc"];
    
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    
    NSAttributedString *attributedText = [[NSAttributedString alloc]initWithString:text attributes:@{
                                                                                                     NSFontAttributeName:[UIFont systemFontOfSize:FONT_SIZE]
                                                                                                     }];
    CGRect rect = [attributedText boundingRectWithSize:constraint
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                               context:nil];
    CGSize size = rect.size;
    
    if (!label)
        label = (UILabel*)[cell viewWithTag:1];
    
    [label setText:text];
    [label setFrame:CGRectMake(80, CELL_CONTENT_MARGIN, CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), MAX(size.height, 44.0f))];
    
    GVGameProfile *gameProfile = [[GVGameProfile alloc] initWithFrame:CGRectMake(CELL_CONTENT_MARGIN, CELL_CONTENT_MARGIN, 80, 80)];
    gameProfile.startX = 10;
    gameProfile.startY = 0;
//    [gameProfile bulidViewWithPlays:1 isShowBuzz:NO];
    [gameProfile displayAvatar:[[self.dataarray objectAtIndex:indexPath.row] objectForKey:@"_id"] ];
    
    [cell.contentView addSubview:gameProfile];
    return cell;
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

-(void)bigdeal{

//    NSDictionary *dictionary2 = @{@"_id":@"4fe9fa8d2aef4710b9000001",
//                                  @"player_id":@"4fe9fa8d2aef4710b9000001",
//                                  @"desc":@"what ever this event is\nwhat ever this event is\nwhat ever this event is",
//                                  @"point":@"-10",
//                                  @"url":@"//greedyvalley.com/img/20120312/4e836c8ab7293cce08000002_o.jpg"};
//    [self.dataarray addObject:dictionary2];
//    
////    NSIndexPath *path = [NSIndexPath indexPathForRow:([self.dataarray count] - 1) inSection:0];
////    [self.tableview scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionBottom animated:YES];
////    [self.tableview reloadData];
//    [self.tableview beginUpdates];
//    NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:[self.dataarray count] - 1 inSection:0];
//    [self.tableview insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
//    [self.tableview endUpdates];
//    NSIndexPath *path = [NSIndexPath indexPathForRow:([self.dataarray count] - 1) inSection:0];
//    [self.tableview scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
     GVEventViewCrl *eventCrl = [[GVEventViewCrl alloc] initWithNibName:@"GVEventViewCrl" bundle:nil];
     eventCrl.eventImage = [UIImage imageNamed:@"profile.jpg"];
     eventCrl.descString = @"what ever this event is\nwhat ever this event is\nwhat ever this event is";
     [self presentViewController:eventCrl animated:YES completion:nil];
}

@end
