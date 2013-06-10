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
	if (self) {
		_queuePlayer = [[AVQueuePlayer alloc] init];
	}
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
		
		if([audioObject.playerEmbed rangeOfString:@"shockwave"].length ||
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
		
			[delegate showPost];
		}
		else
		{
			NSLog(@"album");
			[self.videoView setHidden:YES];
			[_imageView setImage: [audioObject albumArt]];
			[delegate showPost];
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

- (void)viewDidUnload {
	[delegate hidePost];
	[self setScrollView:nil];
	[self setCaptionView:nil];

	[self setFavouriteButton:nil];
	[self setLoadingIndicator:nil];
	[super viewDidUnload];
}
@end
