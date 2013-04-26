//
//  TopbarNavigation.m
//  DJBroadcastFM
//
//  Created by Casper Eekhof on 27-03-13.
//  Copyright (c) 2013 Casper. All rights reserved.
//

#import "TopbarView.h"

@interface TopbarView ()


@end

@implementation TopbarView

static TopbarView * topBarNavigation = nil;

-(id)init
{
	if(topBarNavigation == nil)
	{
		if ((topBarNavigation = [super init]))
		{
			topBarNavigation.currenttrack = -1;
		}
		else return nil;
	}
	return topBarNavigation;
}

-(void)playSong:(id<Release>)release
{
     if(!release) return;
     if(topBarNavigation.audioPlayer)
	{
		[topBarNavigation.audioPlayer.currentItem cancelPendingSeeks];
		[topBarNavigation.audioPlayer pause];
		topBarNavigation.audioPlayer = nil;
	}
	
	[_thumbnailImage setImage: [UIImage imageWithData: [NSData dataWithContentsOfURL:[release imageSmallURL]]]];
	
     [topBarNavigation loadSong:release];
     
	if(topBarNavigation.audioPlayer)
	{
		NSLog(@"Playing release %@",release.tracklist);
	}
	
     
     [topBarNavigation.audioPlayer play];
}

-(void)loadSong:(id<Release>)release
{
	if( !release) return;
	NSLog(@"Loading %@",release.tracklist);
	
	if( _audioPlayer )
	{
		[_audioPlayer.currentItem cancelPendingSeeks];
		[_audioPlayer pause];
		_audioPlayer = nil;
	}
	_audioPlayer = [[AVPlayer alloc] initWithURL:[release.tracklist objectAtIndex:0]];
}

- (IBAction)playSliderValueChanged:(id)sender
{
	NSLog(@"seeking to %f / %f", topBarNavigation.timeControlSlider.value, topBarNavigation.timeControlSlider.maximumValue);
	[topBarNavigation.audioPlayer pause];
	//[topBarNavigation.audioPlayer seekToTime: CMTimeMakeWithSeconds(topBarNavigation.timeControlSlider.value, NSEC_PER_SEC)];
	[topBarNavigation.audioPlayer play];
	
}

- (IBAction)volumeSliderValueChanged:(id)sender
{
}

- (IBAction)sendButtonPressed:(id)sender {
}

- (IBAction)favouriteIconPressed:(id)sender {
}

- (IBAction)searchButtonPressed:(id)sender {
}

- (IBAction)playButtonPressed:(id)sender
{
	if( !topBarNavigation.audioPlayer ) return;
	
	if(topBarNavigation.audioPlayer.rate)
	{
		[topBarNavigation.audioPlayer pause];
	}
	else
	{
		[topBarNavigation.audioPlayer play];
	}
}

- (IBAction)nextButtonPressed:(id)sender
{
	if(!topBarNavigation.tracks) return;
}



- (IBAction)previousButtonPressed:(id)sender {
}

- (IBAction)homeButtonPressed:(id)sender {
}

 
//-(void) updateTime {
//	NSTimeInterval timeLeft = self.audioPlayer.duration - self.audioPlayer.currentTime;
//	
//	int min=timeLeft/60;
//	
//	int sec=(int)timeLeft%60;
//	
//	// update your UI with timeLeft
//	_playTimeLabel.text = [NSString stringWithFormat:@"%d minutes %d seconds", min,sec];
//}
//- (void)drawRect:(CGRect)rect
//{
//	[self updateTime];
//}
@end
