//
//  playerViewController.m
//  ShufflerTumblr
//
//  Created by B Al on 2013-05-16.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import "PlayerViewController.h"
#import "YoutubeURLGetter.h"

@interface PlayerViewController ()

@end

@implementation PlayerViewController

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


//static inline NSString*timestring(float const seconds)
//{
//	return [NSString stringWithFormat:@"%@%d:%02d",
//            seconds < 3600 ? @"":
//            [NSString stringWithFormat:@"%d:",((int)seconds)/3600],
//            (((int)seconds)%3600)/60,
//            (((int)seconds)%3600)%60];
//}


- (void)viewDidUnload {
    [self.player pause];
    self.player = nil;
    [self setSeekbar:nil];
    [self setPlaypause:nil];
    [self setSeekbar:nil];
    [self setUpTimeCounterLabel:nil];
    [self setDownCounterLabel:nil];
    [super viewDidUnload];
}
- (IBAction)playpause:(id)sender {
}

-(void)pause {
}

@end
