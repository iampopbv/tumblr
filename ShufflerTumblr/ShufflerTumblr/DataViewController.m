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
#import <Social/Social.h>
#import "TMAPIClient.h"
#import "User.h"

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
	[self fillUI];
	
	
	_titleLabel.font = [UIFont fontWithName:@"BrandonGrotesque-Bold" size:22];
	
	UIBarButtonItem *barButtonAppearance = [UIBarButtonItem appearance];
	[barButtonAppearance setTintColor:[UIColor blackColor]]; // Change to your colour
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

// Fills the UI based on what post needs to be displayed
- (void) fillUI {
	[self.descriptionView setEditable: NO];
	[self.descriptionView setScrollEnabled: YES];
	
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
		/*NSString*title: [title uppercaseString];
		 NSMutableAttributedString*titleatt = [[NSMutableAttributedString alloc] initWithString:title];
		 //
		 //style your  attributedstring
		 //
		 self.attributedtext = [audioObject trackName];*/
		
		self.titleLabel.attributedText = [audioObject trackName];
	} else if(self.post.type == VIDEO){
		Video * video = (Video*)_post;
		[_playerContainer setHidden: YES];
		[_imageView setHidden: YES];
		[_titleLabel setText: [video sourceTitle]];
		
		_videoView.allowsInlineMediaPlayback = YES;
		
		// if it is a youtube video, convert it to a direct link for displaying the video
		if([[video playURL] hasPrefix:@"http://www.youtube.com"] || [[video playURL] hasPrefix:@"https://www.youtube.com"]){
			[[YoutubeURLGetter sharedInstance]getYoutubeLinkWithURL: [video playURL] withBlock:^(NSString *youtubeDirectURL) {
				[video setPlayURL: youtubeDirectURL];
				[self embedVideo: [video playURL]];
			}];
		} else {
			[self embedVideo: [video playURL]];
		}
		[[_videoView scrollView] setScrollEnabled: NO];
	}
	// Set the description
	[self.descriptionView setText:[self.post caption]];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	NSString *segueName = [segue identifier];
	
	// Pass on the post to the embed player
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
	[self setSharebutton:nil];
	[self setFavouriteButton:nil];
	[self setLoadingIndicator:nil];
	[self setFollowBlogButton:nil];
    [self setDescriptionView:nil];
	[super viewDidUnload];
}

// Show the share options
- (IBAction)sharebuttonpressed:(id)sender {
	NSString * extraText = @"I've listened to this song!";
	NSString *initalText = [[NSString alloc] initWithFormat:@"%@\n%@", extraText, [_post postURL]];
	UIActivityViewController *objvc = [[UIActivityViewController alloc]initWithActivityItems:[NSArray arrayWithObjects: initalText, [UIImage imageNamed:@"shuffler logo"], nil] applicationActivities:nil];
	objvc.excludedActivityTypes = @[UIActivityTypeMessage, UIActivityTypeAssignToContact, UIActivityTypePostToWeibo , UIActivityTypeCopyToPasteboard, UIActivityTypePrint, UIActivityTypeSaveToCameraRoll];
	
	[self presentViewController:objvc animated:YES completion:nil];
}

// Let the user be able to follow this blog.
- (IBAction)followButtonPressed:(id)sender {
	if([[User sharedInstance] loggedIn]) {
		NSString *blogURL = [[NSString alloc] initWithFormat:@"%@.tumblr.com", [_post blogName]];
		NSLog(@"blog url: %@", blogURL);
		[[TMAPIClient sharedInstance] follow: blogURL callback:^(id response, NSError *error) {
			if(!error){
				dispatch_async(dispatch_get_main_queue(), ^{
					NSString *message = [[NSString alloc] initWithFormat: @"Je volgt nu %@", [_post blogName]];
					UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Follow" message: message  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil, nil];
					[alert show];
				});
			} else {
				dispatch_async(dispatch_get_main_queue(), ^{
					UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Follow" message:@"Je bent nog niet ingelogd dus je kan nog geen blogs volgen!"  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil, nil];
					[alert show];
				});
			}
		}];
	} else {
		dispatch_async(dispatch_get_main_queue(), ^{
			
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Follow" message:@"Je bent nog niet ingelogd dus je kan nog geen blogs volgen!"  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil, nil];
			[alert show];
			
		});
	}
}
@end
