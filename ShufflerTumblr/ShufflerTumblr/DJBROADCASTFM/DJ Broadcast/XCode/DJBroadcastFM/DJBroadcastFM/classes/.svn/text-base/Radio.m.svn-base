//
//  Radio.m
//  DJBroadcastFM
//
//  Created by B Al on 2013-04-03.
//  Copyright (c) 2013 Casper. All rights reserved.
//

#import "Radio.h"

@implementation Radio

static AVAudioPlayer * audioplayer;
static TopbarView *tbvv;

+(void)seek:(NSTimeInterval)position
{
	if(audioplayer)[audioplayer playAtTime:position];
}

+(void)setTopbarView:(id)tbv
{
	tbvv = tbv;
	NSLog(@"set top bar");
}

+(void)playSong:(NSURL *)stream
{
	NSLog(@"redirecting to top bar");
	[tbvv playSong:stream];
	NSLog(@"redirected");
}
@end
