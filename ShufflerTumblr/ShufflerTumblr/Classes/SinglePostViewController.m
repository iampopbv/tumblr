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
#import "TMAPIClient.h"
#import "User.h"

@interface SinglePostViewController ()

@end

@implementation SinglePostViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self setupView];
    
    
    
    
}

- (void) setupView {
    // make the backbutton black
    UIBarButtonItem *barButtonAppearance = [UIBarButtonItem appearance];
	[barButtonAppearance setTintColor:[UIColor blackColor]];
    
    
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipedLeft:)];
    swipeGesture.numberOfTouchesRequired = 1;
    swipeGesture.direction = (UISwipeGestureRecognizerDirectionLeft);
    [self.view addGestureRecognizer:swipeGesture];
    swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipedRight:)];
    swipeGesture.numberOfTouchesRequired = 1;
    swipeGesture.direction = (UISwipeGestureRecognizerDirectionRight);
    [self.view addGestureRecognizer:swipeGesture];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// Embeds a video
- (void) embedVideo: (NSString*) url {
	NSString *html = [[NSString alloc] initWithFormat:@"%@%@%@%@", @"<video controls autoplay webkit-playsinline width=\"320\" height=\"225\">", @"<source src=\"", url, @"\" ></video>"];
    [_videoView loadHTMLString: html baseURL:nil];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSString *segueName = [segue identifier];
    
    // Pass the post
	if([segueName isEqualToString: @"embedplayer"]){
	}
}

// Create a share pop-up
- (IBAction)sharebuttonpressed:(id)sender {
	NSString * extraText = @"I've listened to this song!";
	NSString *initalText = [[NSString alloc] initWithFormat:@"%@\n%@", extraText, [_post postURL]];
	UIActivityViewController *objvc = [[UIActivityViewController alloc]initWithActivityItems:[NSArray arrayWithObjects: initalText, [UIImage imageNamed:@"shuffler logo"], nil] applicationActivities:nil];
    objvc.excludedActivityTypes = @[UIActivityTypeMessage, UIActivityTypeAssignToContact, UIActivityTypePostToWeibo , UIActivityTypeCopyToPasteboard, UIActivityTypePrint, UIActivityTypeSaveToCameraRoll];
	
	[self presentViewController:objvc animated:YES completion:nil];
}



- (void)swipedRight:(id)sender {
    NSLog(@"Swiped right");
    UIView *newPostView = [[[NSBundle mainBundle] loadNibNamed:@"PostView" owner:self options:nil] objectAtIndex: 0];
    CGRect newFrame = [newPostView frame];
    newFrame.origin.x -= newFrame.size.width;
    [newPostView setFrame: newFrame];
    
    [self.view addSubview: newPostView];
    
    [UIView animateWithDuration:0.4f animations:^{
        _postView.center = CGPointMake(_postView.center.x + _postView.frame.size.width, _postView.center.y);
        newPostView.center = CGPointMake(newPostView.center.x + newPostView.frame.size.width, newPostView.center.y);
    } completion:^(BOOL finished) {
        [_postView removeFromSuperview];
        _postView = newPostView;
    }];
}


- (void)swipedLeft:(id)sender {
    // Load new post
    UIView *newPostView = [[[NSBundle mainBundle] loadNibNamed:@"PostView" owner:self options:nil] objectAtIndex: 0];
    CGRect newFrame = [newPostView frame];
    newFrame.origin.x += newFrame.size.width;
    [newPostView setFrame: newFrame];
    
    [self.view addSubview: newPostView];
    
    [UIView animateWithDuration:0.4f animations:^{
        _postView.center = CGPointMake(_postView.center.x - _postView.frame.size.width, _postView.center.y);
        newPostView.center = CGPointMake(newPostView.center.x - newPostView.frame.size.width, newPostView.center.y);
    } completion:^(BOOL finished) {
        [_postView removeFromSuperview];
        _postView = newPostView;
    }];
}

- (void) setPost: (id<Post>) post {
    _post = post;
    
    // Is this an audio or a video post?
    // Show the post in an appropiate manner
    if([_post type]  == AUDIO){
        Audio *audioObject = (Audio*)self.post;
        
        if([audioObject.playerEmbed rangeOfString:@"shockwave"].length || NO )
        {
            //            [_playerContainer setHidden:YES];
            
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
            
        }
        else
        {
            NSLog(@"album");
            [self.videoView setHidden:YES];
            [_imageView setImage: [audioObject albumArt]];
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
        //        [_playerContainer setHidden: YES];
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

- (IBAction)favoriteButtonPressed:(id)sender {
    if([[User sharedInstance] loggedIn]) {
        [[Favourites sharedManager] addFavourite: _post];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Inloggen" message:@"Je bent nog niet ingelogd!"  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil, nil];
        [alert show];
    }
}


// Create a share pop-up
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
    [self setPostView:nil];
    [self setPostView:nil];
}

@end
