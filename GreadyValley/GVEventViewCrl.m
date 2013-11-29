//
//  GVEventViewCrl.m
//  GreadyValley
//
//  Created by rick on 11/29/13.
//  Copyright (c) 2013 woomoo. All rights reserved.
//

#import "GVEventViewCrl.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
@interface GVEventViewCrl (){
    int i;
}

@property (nonatomic,strong) AVAudioPlayer *player;
@end

@implementation GVEventViewCrl

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
    
    [self prepAudio];
    [self.player play];
    AudioServicesPlaySystemSound (kSystemSoundID_Vibrate);
    self.photo.image = self.eventImage;
    self.desc.text = self.descString;
    i = 0;
    [self flashScreenWithColor:[UIColor redColor]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)closeMySelf:(id)sender{
    
    [self dismissViewControllerAnimated:YES completion:^{
        [self.player stop];
    }];
}
- (BOOL) prepAudio
{
	NSError *error;
	NSString *path = [[NSBundle mainBundle] pathForResource:@"loop" ofType:@"mp3"];
	if (![[NSFileManager defaultManager] fileExistsAtPath:path]) return NO;
	self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:&error];
	if (!self.player)
	{
		NSLog(@"Error: %@", [error localizedDescription]);
		return NO;
	}
	[self.player prepareToPlay];
	[self.player setNumberOfLoops:1];
	return YES;
}

-(void) flashScreenWithColor:(UIColor *) color{
    UIView *flashView = [[UIView alloc] initWithFrame:[self.view frame]];
    [flashView setBackgroundColor:color];
    [self.view addSubview:flashView];
    [UIView animateWithDuration:.4f
                     animations:^{
                         [flashView setAlpha:0.f];
                     }
                     completion:^(BOOL finished){
                         i++;
                         [flashView removeFromSuperview];
                         if(i < 3){
                             [self flashScreenWithColor:[UIColor redColor]];
                         }
                     }
     ];
}

@end
