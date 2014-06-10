//
//  PlayerViewController.m
//  ShufflerForTumblr
//
//  Created by Adrian Zborowski on 10/06/14.
//  Copyright (c) 2014 Hogeschoool van Amsterdam. All rights reserved.
//

#import "PlayerViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "AppSession.h"
#import "AudioPost.h"

@interface PlayerViewController ()
@property (nonatomic, strong) AVPlayer* player;
@property (nonatomic, strong) IBOutlet UIButton* togglePlayPause;
@property (nonatomic, strong) IBOutlet UILabel* songName;
@property (nonatomic, strong) IBOutlet UILabel* durationOutlet;
@property (nonatomic, strong) IBOutlet UISlider* sliderOutlet;
@end

AVPlayerItem* currentItem;

@implementation PlayerViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    NSLog(@"%d", [[AppSession sharedInstance]currentlyPlayingIndex]);
    
    self.player = [[AVPlayer alloc] init];
//    MPMediaQuery* everything = [[MPMediaQuery alloc] init];
//    NSArray* itemsFromGenericQuery = [everything items];
    
//    currentItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:@"http://api.soundcloud.com/tracks/36249591/stream?client_id=3cQaPshpEeLqMsNFAUw1Q"]];
//    [self.player replaceCurrentItemWithPlayerItem:currentItem];
//    [self.player play];
    
    self.songName.text = @"Title";
    
//    [self.sliderOutlet setMaximumValue:self.player.currentItem.duration.value/self.player.currentItem.duration.timescale];
    
    [self configurePlayer];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:NO];
    int location = [[AppSession sharedInstance]currentluPlayingPostLocation];
    int current = [[AppSession sharedInstance]currentlyPlayingIndex];
    
    AudioPost* ap = [[AppSession sharedInstance]dashboardPosts][current];
    currentItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:ap.audio_url]];
    [self.player replaceCurrentItemWithPlayerItem:currentItem];
    [self.player play];
}

-(IBAction)togglePlayPauseTapped:(id)sender{
    if(self.togglePlayPause.selected) {
        [self.player pause];
        [self.togglePlayPause setSelected:NO];
    }else{
        [self.player play];
        [self.togglePlayPause setSelected:YES];
    }
}

-(void)configurePlayer{
    __block PlayerViewController * weakSelf = self;
    
    [self.player addPeriodicTimeObserverForInterval:CMTimeMakeWithSeconds(1, 1)
                                              queue:NULL
                                         usingBlock:^(CMTime time) {
                                             if(!time.value) {
                                                 return;
                                             }
                                             int currentTime = (int)((weakSelf.player.currentTime.value)/weakSelf.player.currentTime.timescale);
                                             int currentMins = (int)(currentTime/60);
                                             int currentSec  = (int)(currentTime%60);
                                             
                                             NSString * durationLabel =
                                             [NSString stringWithFormat:@"%02d:%02d",currentMins,currentSec];
                                             weakSelf.durationOutlet.text = durationLabel;
                                             weakSelf.sliderOutlet.value = currentTime;
                                         }];
}

-(IBAction)sliderDragged:(id)sender {
    [self.player seekToTime:CMTimeMakeWithSeconds((int)(self.sliderOutlet.value) , 1)];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}
#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{}

@end
