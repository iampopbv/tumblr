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
@property (nonatomic, strong) IBOutlet UIWebView* songCaption;
@property (nonatomic, strong) IBOutlet UILabel* durationOutlet;
@property (nonatomic, strong) IBOutlet UISlider* sliderOutlet;
@property (nonatomic, strong) IBOutlet UIView* coverArt;
@end

AVPlayerItem* currentItem;
int currentlyPlaingIndex = -1;
int currentlyPlaingPostLocation = -1;

@implementation PlayerViewController

/**
 */
- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.player = [[AVPlayer alloc] init];
    [self.view addSubview:self.coverArt];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemDidReachEnd)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:nil];
    
    [self configurePlayer];
}

/**
 */
-(void)playerItemDidReachEnd {
    [[AppSession sharedInstance]setCurrentlyPlayingIndex:(currentlyPlaingIndex+1)];
    currentlyPlaingIndex = [[AppSession sharedInstance]currentlyPlayingIndex];
    
    AudioPost* ap = [[AppSession sharedInstance]dashboardPosts][currentlyPlaingIndex];
    
    self.songName.text = [NSString stringWithFormat:@"%@", ap.track_name];
    [self.songCaption loadHTMLString:ap.caption baseURL:nil];
    
    UIGraphicsBeginImageContext(self.coverArt.frame.size);
    [[UIImage imageNamed:ap.album_art] drawInRect:self.coverArt.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.coverArt.backgroundColor = [UIColor colorWithPatternImage:image];
    
    [self.view setNeedsDisplay];
    
    currentItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:ap.audio_url]];
    [self.player replaceCurrentItemWithPlayerItem:currentItem];
    [self.player play];
}

/**
 */
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:NO];
    int location = [[AppSession sharedInstance]currentlyPlayingPostLocation];
    int current = [[AppSession sharedInstance]currentlyPlayingIndex];
    
    if(currentlyPlaingPostLocation != location || currentlyPlaingIndex != current){
        currentlyPlaingPostLocation = location;
        currentlyPlaingIndex = current;
        
        AudioPost* ap = [[AppSession sharedInstance]dashboardPosts][current];
        
        UIGraphicsBeginImageContext(self.coverArt.frame.size);
        [[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:ap.album_art]]] drawInRect:self.coverArt.bounds];
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        self.coverArt.backgroundColor = [UIColor colorWithPatternImage:image];
        [self.songCaption loadHTMLString:ap.caption baseURL:nil];
        NSLog(@"%@", ap.caption);
        
        self.songName.text = [NSString stringWithFormat:@"%@", ap.track_name];
        
        currentItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:ap.audio_url]];
        [self.player replaceCurrentItemWithPlayerItem:currentItem];
        [self.player play];
        [self.togglePlayPause setSelected:YES];
    }
}

/**
 */
-(IBAction)togglePlayPauseTapped:(id)sender{
    if(self.togglePlayPause.selected) {
        [self.player pause];
        [self.togglePlayPause setSelected:NO];
    }else{
        [self.player play];
        [self.togglePlayPause setSelected:YES];
    }
}

/**
 */
-(void)configurePlayer{
    __block PlayerViewController* weakSelf = self;
    
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
                                             
                                             float maxVal = (weakSelf.player.currentItem.duration.value/weakSelf.player.currentItem.duration.timescale);
                                             [weakSelf.sliderOutlet setMaximumValue:maxVal];
                                         }];
}

/**
 */
-(IBAction)sliderDragged:(id)sender {
    [self.player seekToTime:CMTimeMakeWithSeconds((int)(self.sliderOutlet.value) , 1)];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    webView.opaque = NO;
    webView.backgroundColor = [UIColor colorWithRed:26/255.0 green:42/255.0 blue:58/255.0 alpha:1.0];
}

/**
 */
- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

/**
 */
#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{}

@end
