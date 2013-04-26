//
//  TopbarNavigation.h
//  DJBroadcastFM
//
//  Created by Casper Eekhof on 27-03-13.
//  Copyright (c) 2013 Casper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "Release.h"


@interface TopbarView : UIView

// Media player object.
@property AVPlayer *audioPlayer;

// UI Components
@property (weak, nonatomic) IBOutlet UIButton *homeButton;
@property (weak, nonatomic) IBOutlet UIButton *previousButton;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UIButton *favouriteButton;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;

@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImage;

@property (weak, nonatomic) IBOutlet UILabel *playTimeLabel;
@property (strong, nonatomic) IBOutlet UISlider *timeControlSlider;
@property (weak, nonatomic) IBOutlet UISlider *volumeSlider;
@property (weak, nonatomic) IBOutlet UILabel *toGoLabel;

// variables
@property NSArray *tracks;
@property int currenttrack;

// IBActions
- (IBAction)playButtonPressed:(id)sender;
- (IBAction)nextButtonPressed:(id)sender;
- (IBAction)previousButtonPressed:(id)sender;
- (IBAction)homeButtonPressed:(id)sender;
- (IBAction)playSliderValueChanged:(id)sender;
- (IBAction)volumeSliderValueChanged:(id)sender;
- (IBAction)sendButtonPressed:(id)sender;
- (IBAction)favouriteIconPressed:(id)sender;
- (IBAction)searchButtonPressed:(id)sender;


// Methods
- (void)playSong:(id<Release>)release;
@end
