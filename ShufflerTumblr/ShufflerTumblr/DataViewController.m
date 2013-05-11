//
//  DataViewController.m
//  PageBasedAppTest
//
//  Created by Casper Eekhof on 05-05-13.
//  Copyright (c) 2013 Casper. All rights reserved.
//

#import "DataViewController.h"
#import "Audio.h"
#import "Video.h"

@interface DataViewController ()

@end

@implementation DataViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	
	
	
	
	
	
	
	// Dummy data
	//		self.post = [[Audio alloc] initWithDictionary:@{ @"audio_url" : @"http://sogreatandpowerful.com/SoGreatandPowerful%20-%20Untitled.mp3"}];
	//
	//		self.player = [AVPlayer playerWithURL: [NSURL URLWithString: self.post.]];
	//		[self.player play];
	//	NSLog(@"playing %@", self.post.playURL);
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	if(self.post.type  == AUDIO){
		Audio *audioObject = (Audio*)self.post;
		[_imageView setImage: [audioObject albumArt]];
	} else if(self.post.type == VIDEO){
		//		[self embedYouTube: @"http://www.youtube.com/embed/IHRnjBarI9I" frame: _videoView.frame];
		//		[self playMovie:@"http://www.youtube.com/embed/IHRnjBarI9I"];
		[self playMovie:@"https://s3.amazonaws.com/adplayer/colgate.mp4"];
		
		[_playerContainer setHidden: YES];
	}
	
	self.titleLabel.text = nil;
	self.descriptionLabel.text = nil;
}

-(void)playMovie: (NSString*) urlS
{
	MPMoviePlayerController *moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL: [NSURL URLWithString: urlS]];
	
	moviePlayer.controlStyle = MPMovieControlStyleNone;
	moviePlayer.scalingMode = MPMovieScalingModeFill;
	
	[[NSNotificationCenter defaultCenter]
	 addObserver:self
	 selector:@selector(myMovieFinishedCallback:)
	 name:MPMoviePlayerPlaybackDidFinishNotification
	 object: moviePlayer];
	
	moviePlayer.view.frame = CGRectMake(0, 0, 320, 210);
	[self.scrollView addSubview: moviePlayer.view];
	[moviePlayer play];
}

- (void)embedYouTube:(NSString *)urlString frame:(CGRect)frame {
	NSURL *videoURL = [NSURL URLWithString: urlString];
	NSURLRequest *videoRequest = [NSURLRequest requestWithURL:videoURL];
	[_webView loadRequest: videoRequest];
}

- (void)viewDidUnload {
	[self setScrollView:nil];
	[super viewDidUnload];
}
@end
