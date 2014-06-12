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
#import "Regex.h"

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
    
    /**
     Set the player object
     */
    self.player = [[AVPlayer alloc] init];
    
    /**
     Add a subview to the view controller.
     Subview contains the cover art of the song as background.
     */
    [self.view addSubview:self.coverArt];
    
    /**
     Configure the player
     */
    [self configurePlayer];
}

/**
 */
-(void)playerItemDidReachEnd {
    [[AppSession sharedInstance]setCurrentlyPlayingIndex:(currentlyPlaingIndex+1)];
    
    currentlyPlaingIndex = [[AppSession sharedInstance]currentlyPlayingIndex];
    
    [self playItem];
    
    [self.view setNeedsDisplay];
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
        
        [self playItem];
        
        [self.togglePlayPause setSelected:YES];
    }
}

/**
 All the settings to be able for playing a item.
 */
-(void)playItem{
    /**
     Set song object
     */
    AudioPost* ap = [[AppSession sharedInstance]dashboardPosts][currentlyPlaingIndex];
    ap.caption = [Regex hyperlinkRegex:ap.caption];
    ap.caption = [Regex imageSizeRegex:ap.caption];
    
    /**
     Set cover art
     */
    UIGraphicsBeginImageContext(self.coverArt.frame.size);
    [[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:ap.album_art]]] drawInRect:self.coverArt.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.coverArt.backgroundColor = [UIColor colorWithPatternImage:image];
    
    /**
     Set song name
     */
    self.songName.text = [[NSString stringWithFormat:@"%@", ap.track_name] uppercaseString];
    
    /**
     Set song caption
     */
    [self.songCaption loadHTMLString:[NSString stringWithFormat:@"\
                                      <html>\
                                      <body text=\"#FFFFFF\" face=\"BrandonGrotesqueRegularRg\" size=\"5\">\
                                      %@\
                                      </body>\
                                      </html>", ap.caption] baseURL:nil];
    
    /**
     Play the item
     */
    currentItem = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:ap.audio_url]];
    [self.player replaceCurrentItemWithPlayerItem:currentItem];
    [self.player play];
}

/**
 Control the state of the play pause button.
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
 Configure the player specific options.
 */
-(void)configurePlayer{
    /**
     weakSelf makes it possible to make use of the view controller
     */
    __block PlayerViewController* weakSelf = self;
    
    /**
     Set the behavior of the player after song has finished.
     */
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(playerItemDidReachEnd)
     name:AVPlayerItemDidPlayToEndTimeNotification
     object:nil];
    
    /**
     Each second that the player works all the calculations are made for time control.
     Get current song time, calculate it to minutes and seconds, set time labels.
     */
    [self.player addPeriodicTimeObserverForInterval:CMTimeMakeWithSeconds(1, 1)queue:NULL
                                         usingBlock:^(CMTime time) {
                                             if(!time.value) {
                                                 return;
                                             }
                                             
                                             int currentTime = (int)((weakSelf.player.currentTime.value)/weakSelf.player.currentTime.timescale);
                                             int currentMins = (int)(currentTime/60);
                                             int currentSec  = (int)(currentTime%60);
                                             
                                             NSString* durationLabel = [NSString stringWithFormat:@"%02d:%02d",currentMins,currentSec];
                                             
                                             weakSelf.durationOutlet.text = durationLabel;
                                             weakSelf.sliderOutlet.value = currentTime;
                                             
                                             float maxVal = (weakSelf.player.currentItem.duration.value/weakSelf.player.currentItem.duration.timescale);
                                             [weakSelf.sliderOutlet setMaximumValue:maxVal];
                                         }];
}

/**
 Drag the slider component each second that the player plays.
 */
-(IBAction)sliderDragged:(id)sender {
    [self.player seekToTime:CMTimeMakeWithSeconds((int)(self.sliderOutlet.value), 1)];
}

/**
 Set the background of the webview that is used for the song caption.
 */
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
