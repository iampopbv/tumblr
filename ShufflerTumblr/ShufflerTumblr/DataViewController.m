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

@interface DataViewController ()

@end

@implementation DataViewController

id<postgetter> delegate;

static inline NSString*timestring(float const seconds)
{
	return [NSString stringWithFormat:@"%@%02d:%02d",
		   seconds < 3600 ? @"":
		   [NSString stringWithFormat:@"%02d:",((int)seconds)/3600],
		   (((int)seconds)%3600)/60,
		   (((int)seconds)%3600)%60];
}

// do this once on init
- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
	    _queuePlayer = [[AVQueuePlayer alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

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
		[_webView setHidden: YES];
		
		Audio *audioObject = (Audio*)self.post;
		
		if([audioObject.playerEmbed rangeOfString:@"shockwave"].length ||
		  NO )
		{
			[_playerContainer setHidden:YES];
			[_imageView setHidden:YES];
			NSString*html = [NSString stringWithFormat:@"%@%@%@%@%@",
			 @"<!DOCTYPE html><html><head><title>",audioObject.trackName,@"</title><meta content-encoding='utf-8' /></head><body>",audioObject.embed,@"</body></html>" ];

			[self.tempembedplayerview loadHTMLString:html
									   baseURL:[NSURL URLWithString:@"tumblr.com"]];
		}
		else if(!audioObject.albumArt)
		{
			NSLog(@"noalbumart");
			[_imageView setHidden:YES];
			[_videoView setHidden:YES];
			[_webView setHidden:YES];
			[self.tempembedplayerview setHidden:YES];
			[_imageheight setConstant:0];
		}
		else
		{
			NSLog(@"album");
			[self.tempembedplayerview setHidden:YES];
			[_imageView setImage: [audioObject albumArt]];
		}
		[delegate showPost];
		
		self.titleLabel.attributedText = [audioObject trackName];
		[self.captionView loadHTMLString:[audioObject caption] baseURL:[NSURL URLWithString:@"//tumblr.com" ]];
	} else if(self.post.type == VIDEO){
		[_playerContainer setHidden: YES];
		[_imageView setHidden: YES];
		[self embedYouTube: @"http://www.youtube.com/embed/l3Iwh5hqbyE"];
	}
}

-(void)viewWillDisappear:(BOOL)animated
{
	if(self.post.type == AUDIO && delegate)
	{
		[delegate hidePost];
	}
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	NSString *segueName = [segue identifier];
	if([segueName isEqualToString: @"embedplayer"]){
		delegate = segue.destinationViewController;
		[segue.destinationViewController getPost:self.post];
	}
}

- (void)embedYouTube:(NSString *)urlString {
	NSString *embedHTML = @"\
	<html><head>\
	<style type=\"text/css\">\
	body {\
	background-color: transparent;\
	color: white;\
	}\
	</style>\
	</head><body style=\"margin:0\">\
	<embed id=\"yt\" src=\"%@\" type=\"application/x-shockwave-flash\" \
	width=\"%0.0f\" height=\"%0.0f\"></embed>\
	</body></html>";
	NSString *html = [NSString stringWithFormat:embedHTML, urlString, _webView.frame.size.width, _webView.frame.size.height];
	UIWebView *videoView = [[UIWebView alloc] initWithFrame: _webView.frame];
	[videoView loadHTMLString:html baseURL:nil];
	[_webView setAllowsInlineMediaPlayback: YES];
	[_webView loadHTMLString:html baseURL:nil];
}

- (void)viewDidUnload {
	[self setScrollView:nil];
	[self setCaptionView:nil];
	[self setImageheight:nil];
	[self setTempembedplayerview:nil];
	[super viewDidUnload];
}
@end
