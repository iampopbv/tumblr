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
			self.playerHeight.constant = 0;
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
			[_imageheight setConstant:0];
			[self showPost];
		}
		else
		{
			NSLog(@"album");
			[self.videoView setHidden:YES];
			[_imageView setImage: [audioObject albumArt]];
			[self showPost];
		}
		
		
		self.titleLabel.attributedText = [audioObject trackName];
		if(!audioObject.trackName)
		{
			[self.textView setHidden:YES];
			self.titleHeight.constant = 0;
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	NSString *segueName = [segue identifier];
	if([segueName isEqualToString: @"embedplayer"]){
		delegate = segue.destinationViewController;
		[segue.destinationViewController getPost:self.post];
	}
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

-(void)getPost:(id<Post>)post from:(NSArray*)posts
{
	self.post = post;
	
	self.player = [AVQueuePlayer playerWithURL: [NSURL URLWithString: [NSString stringWithFormat:@"http://a.tumblr.com/%@o1.mp3", [self.post.playURL lastPathComponent]]]];
		NSLog(@"playing %@, from %@", self.post.playURL, self.post);
}

-(void)showPost
{
	if(self.post && self.player)
		[self.player play];
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
	[self setImageheight:nil];
	[self setPlayerHeight:nil];
	[self setTitleHeight:nil];
	[self setFavouriteButton:nil];
	[self setLoadingIndicator:nil];
	[super viewDidUnload];
	self.player = nil;
	[self setSeekbar:nil];
	[self setPlaypause:nil];
	[self setPlayTimeLabel:nil];
	[super viewDidUnload];
}
@end
