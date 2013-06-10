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
#import "Post.h"
#import "YoutubeURLGetter.h"

@interface DataViewController ()

@end

@implementation DataViewController

id<postgetter> delegate;

// do this once on init
- (id)initWithCoder:(NSCoder *)coder
{
	self = [super initWithCoder:coder];
	if (self) {}
	return self;
}

- (IBAction)favouriteButtonTouchUpInside:(id)sender {
	[[Favourites sharedManager] addFavourite: _post];
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	[self fillUI];
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self showPost];
}

- (void) embedVideo: (NSString*) url {
	NSString *html = [[NSString alloc] initWithFormat:@"%@%@%@%@", @"<video controls autoplay webkit-playsinline width=\"320\" height=\"225\">", @"<source src=\"", url, @"\" ></video>"];
	[_videoView loadHTMLString: html baseURL:nil];
}

-(void)viewWillDisappear:(BOOL)animated
{
	if(self.post.type == AUDIO && delegate)
	{
		[delegate hidePost];
	}
}

- (void) fillUI {
	if(self.post.type  == AUDIO){
		Audio *audioObject = (Audio*)self.post;
		
		if([audioObject.playerEmbed rangeOfString:@"shockwave"].length &&
		   NO )
		{
			[_playerContainer setHidden:YES];
		
			[_imageView setHidden:YES];
			NSString*html = [NSString stringWithFormat:@"%@%@%@%@%@",
						  @"<!DOCTYPE html><html><head><title>",audioObject.trackName,@"</title><meta content-encoding='utf-8' /></head><body>",audioObject.embed,@"</body></html>" ];
			
			[self.videoView loadHTMLString:html
							   baseURL:[NSURL URLWithString:@"tumblr.com"]];
		}
		else if(!audioObject.albumArt)
		{
			NSLog(@"noalbumart");
			[_imageView setHidden:YES];
			[_videoView setHidden:YES];
			[self.videoView setHidden:YES];
			//[_imageheight setConstant:0];
		
			[delegate showPost];
		}
		else
		{
			NSLog(@"album");
			[self.videoView setHidden:YES];
			[_imageView setImage: [audioObject albumArt]];
		}
		
		
		self.titleLabel.attributedText = [audioObject trackName];
		if(!audioObject.trackName)
		{
			[self.textView setHidden:YES];
			
		}
	} else if(self.post.type == VIDEO){
		Video * video = (Video*)_post;
		[_playerContainer setHidden: YES];
		[_imageView setHidden: YES];
		[_titleLabel setText: [video sourceTitle]];
		
		_videoView.allowsInlineMediaPlayback = YES;
		if([[video playURL] hasPrefix:@"http://www.youtube.com"] || [[video playURL] hasPrefix:@"https://www.youtube.com"]){
			[YoutubeURLGetter getYoutubeLinkWithURL: [video playURL] withBlock:^(NSString *youtubeDirectURL) {
				[video setPlayURL: youtubeDirectURL];
				[self embedVideo: [video playURL]];
			}];
		} else {
			[self embedVideo: [video playURL]];
		}
		[[_videoView scrollView] setScrollEnabled: NO];
	}
	[self.captionView loadHTMLString:[_post caption] baseURL:[NSURL URLWithString:@"//tumblr.com" ]];
}

- (void) setLoading {
	_loadingIndicator.hidden = NO;
}

- (void) setDoneLoading {
	_loadingIndicator.hidden = YES;
}

// player
static inline NSString*timestring(float const seconds)
{
	return [NSString stringWithFormat:@"%@%d:%02d",
		   seconds < 3600 ? @"":
		   [NSString stringWithFormat:@"%d:",((int)seconds)/3600],
		   (((int)seconds)%3600)/60,
		   (((int)seconds)%3600)%60];
}

id sharedplayer;
-(AVQueuePlayer *)player{return sharedplayer;}
-(void)setPlayer:(AVQueuePlayer *)player{sharedplayer = player;}

-(void)buildandplayqueue
{
	if(self.player)
	{
		[self.player pause];
		self.player = nil;
	}
	
	NSMutableArray*queue = [[NSMutableArray alloc]init];
	bool skip = YES;
	for(id<Post>nextpost in self.posts)
	{
		if(nextpost == self.post)skip=NO;
		if(skip)continue;
		AVPlayerItem*item = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"http://a.tumblr.com/%@o1.mp3", [nextpost.playURL lastPathComponent]]]];
		NSLog(@"+:%@",item);
		[queue addObject:item];
	}
	self.player = [AVQueuePlayer queuePlayerWithItems:queue];
	self.seekbar.maximumValue = CMTimeGetSeconds(self.player.currentItem.duration);
	[self.player addPeriodicTimeObserverForInterval:CMTimeMakeWithSeconds(1, 1) queue:nil usingBlock:^(CMTime time) {
		float secs = CMTimeGetSeconds(time),max=CMTimeGetSeconds(self.player.currentItem.duration);
		self.seekbar.maximumValue = max;
		self.seekbar.value = secs;
		[self.playTimeLabel setText:timestring(secs)];
		[self.toGoLabel setText:timestring(max-secs)];
	}];
	NSLog(@"playing %@, from %@", self.post.playURL, self.post);
	[self.player play];
	NSLog(@"ppp:%@",queue);

}

-(void)showPost
{
	[self buildandplayqueue];
}

-(void)hidePost
{
	if(self.player && self.player.rate)
		[self.player pause];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		// Custom initialization
	}
	return self;
}



- (IBAction)playpause:(id)sender {
	if(self.player.rate)
		[self pause];
	else
		[self continue];
}

- (IBAction)seek:(UISlider *)sender
{
	[self.player pause];
	[self.player seekToTime: CMTimeMakeWithSeconds(sender.value,1)];
	[self.player play];
}

-(void)continue
{
	[self.player play];
}

-(void)pause
{
	[self.player pause];
}



- (void)viewDidUnload {
	[delegate hidePost];
	[self setScrollView:nil];
	[self setCaptionView:nil];

	[self setFavouriteButton:nil];
	[self setLoadingIndicator:nil];
	[self setPlayerContainer:nil];
	[self setPlayTimeLabel:nil];
	[self setToGoLabel:nil];
	[self setPlaypause:nil];
	[self setSeekbar:nil];
	[super viewDidUnload];
	self.player = nil;
	[self setSeekbar:nil];
	[self setPlaypause:nil];
	[self setPlayTimeLabel:nil];
	[super viewDidUnload];
}
@end
