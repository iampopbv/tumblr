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
		[_imageView setImage: [audioObject albumArt]];


		
		[[[[playerViewController alloc] init] delegate] getPost:self.post];
	} else if(self.post.type == VIDEO){
		[_playerContainer setHidden: YES];
		[_imageView setHidden: YES];
		[self embedYouTube: @"http://www.youtube.com/embed/l3Iwh5hqbyE"];
	}
	
	self.titleLabel.text = nil;
	self.descriptionLabel.text = nil;
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
	[super viewDidUnload];
}
@end
