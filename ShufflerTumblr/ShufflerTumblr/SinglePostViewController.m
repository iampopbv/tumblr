//
//  SinglePostViewController.m
//  ShufflerTumblr
//
//  Created by Casper Eekhof on 13-06-13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import "SinglePostViewController.h"
#import "Audio.h"
#import "Video.h"
#import "YoutubeURLGetter.h"
#import "postgetter.h"
#import "TMAPIClient.h"

@interface SinglePostViewController ()

@end

@implementation SinglePostViewController

id<postgetter> delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)favouriteButtonTouchedUpInside:(id)sender {
    [[Favourites sharedManager] addFavourite: _post];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSLog(@"post: %@", _post);
    if([_post type]  == AUDIO){
		Audio *audioObject = (Audio*)self.post;
		
		if([audioObject.playerEmbed rangeOfString:@"shockwave"].length || NO )
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
		if([[video playURL] hasPrefix:@"http://www.youtube.com"] || [[video playURL] hasPrefix:@"https://www.youtube.com"]){
			[[YoutubeURLGetter sharedInstance] getYoutubeLinkWithURL: [video playURL] withBlock:^(NSString *youtubeDirectURL) {
				[video setPlayURL: youtubeDirectURL];
				[self embedVideo: [video playURL]];
			}];
		} else {
			[self embedVideo: [video playURL]];
		}
		[[_videoView scrollView] setScrollEnabled: NO];
	}
    //	[self.captionView loadHTMLString:[_post caption] baseURL:[NSURL URLWithString:@"//tumblr.com" ]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) embedVideo: (NSString*) url {
	NSString *html = [[NSString alloc] initWithFormat:@"%@%@%@%@", @"<video controls autoplay webkit-playsinline width=\"320\" height=\"225\">", @"<source src=\"", url, @"\" ></video>"];
	[_videoView loadHTMLString: html baseURL:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSString *segueName = [segue identifier];
	if([segueName isEqualToString: @"embedplayer"]){
		delegate = segue.destinationViewController;
		[segue.destinationViewController getPost:self.post];
	}
}

- (IBAction)sharebuttonpressed:(id)sender {
	NSString * extraText = @"I've listened to this song!";
	NSString *initalText = [[NSString alloc] initWithFormat:@"%@\n%@", extraText, [_post postURL]];
	UIActivityViewController *objvc = [[UIActivityViewController alloc]initWithActivityItems:[NSArray arrayWithObjects: initalText, [UIImage imageNamed:@"shuffler logo"], nil] applicationActivities:nil];
    objvc.excludedActivityTypes = @[UIActivityTypeMessage, UIActivityTypeAssignToContact, UIActivityTypePostToWeibo , UIActivityTypeCopyToPasteboard, UIActivityTypePrint, UIActivityTypeSaveToCameraRoll];
	
	[self presentViewController:objvc animated:YES completion:nil];
}

- (IBAction)shareButtonPressed:(id)sender {
    NSString *blogURL = [[NSString alloc] initWithFormat:@"%@.tumblr.com", [_post blogName]];
    NSLog(@"blog url: %@", blogURL);
    [[TMAPIClient sharedInstance] follow: blogURL callback:^(id response, NSError *error) {
        if(!error){
            NSLog(@"%@", response);
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Follow" message:@"Je bent nog niet ingelogd dus je kan nog geen blogs volgen!"  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil, nil];
                [alert show];
            });
        }
    }];
}

-(void)viewDidUnload {
    [self setFavouriteButton:nil];
	[delegate hidePost];
}

@end
