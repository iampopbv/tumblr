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
#import "DirectURLGetter.h"
#import "TMAPIClient.h"
#import "User.h"
#import "Player.h"


@interface SinglePostViewController ()

@property NSTimer *timer;

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setupView {
    // make the backbutton black
    UIBarButtonItem *barButtonAppearance = [UIBarButtonItem appearance];
	[barButtonAppearance setTintColor:[UIColor blackColor]];
    
    
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(loadNewPost:)];
    swipeGesture.numberOfTouchesRequired = 1;
    swipeGesture.direction = (UISwipeGestureRecognizerDirectionLeft);
    [self.view addGestureRecognizer:swipeGesture];
    swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(loadPreviousPost:)];
    swipeGesture.numberOfTouchesRequired = 1;
    swipeGesture.direction = (UISwipeGestureRecognizerDirectionRight);
    [self.view addGestureRecognizer:swipeGesture];
    
    
    [_playPauseButton setImage:[UIImage imageNamed:@"playbutton"] forState: UIControlStateNormal];
    [_playPauseButton setImage:[UIImage imageNamed:@"pausebutton"] forState: UIControlStateSelected];
    [[Player sharedInstance] setViewController: self];
    
}



// Embeds a video
- (void) embedVideo {
    [_videoView setPlayer: [[Player sharedInstance] avQPlayer]];
}

// Create a share pop-up
- (IBAction)sharebuttonpressed:(id)sender {
	NSString * extraText = @"I've listened to this song!";
	NSString *initalText = [[NSString alloc] initWithFormat:@"%@\n%@", extraText, [_post postURL]];
	UIActivityViewController *objvc = [[UIActivityViewController alloc]initWithActivityItems:[NSArray arrayWithObjects: initalText, [UIImage imageNamed:@"shuffler logo"], nil] applicationActivities:nil];
    objvc.excludedActivityTypes = @[UIActivityTypeMessage, UIActivityTypeAssignToContact, UIActivityTypePostToWeibo , UIActivityTypeCopyToPasteboard, UIActivityTypePrint, UIActivityTypeSaveToCameraRoll];
	
	[self presentViewController:objvc animated:YES completion:nil];
}



- (void)loadPreviousPost:(id)sender {

    id<Post> previousPost = [[Player sharedInstance] playPreviousPost];
    if(previousPost == nil)
        return;
    
    UIView *previousPostView = [[[NSBundle mainBundle] loadNibNamed:@"PostView" owner:self options:nil] objectAtIndex: 0];
    CGRect newFrame = [previousPostView frame];
    newFrame.origin.x -= newFrame.size.width;
    [previousPostView setFrame: newFrame];
    
    [self.view addSubview: previousPostView];
    
    [UIView animateWithDuration:0.4f animations:^{
        _postView.center = CGPointMake(_postView.center.x + _postView.frame.size.width, _postView.center.y);
        previousPostView.center = CGPointMake(previousPostView.center.x + previousPostView.frame.size.width, previousPostView.center.y);
    } completion:^(BOOL finished) {
        [_postView removeFromSuperview];
        _postView = previousPostView;
    }];
    
    [self setPost: previousPost];
}


- (void)loadNewPost:(id)sender {
    // Load new post
    
    
    id<Post> nextPost = [[Player sharedInstance] playNextPost];
    if (nextPost == nil) {
        // Make the [Root]ViewController lazyload the next page and set it in the player's playlist
    }
    
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
    
    [self setPost: nextPost];
}

- (void) setPost: (id<Post>) post {
    _post = post;
    
    // Is this an audio or a video post?
    // Show the post in an appropiate manner
    [self hideControls];
    if([_post type]  == AUDIO){
        Audio *audioObject = (Audio*)self.post;
        
        [_imageView setHidden: NO];
        [_videoView setHidden: YES];
        
        if(!audioObject.albumArt)
            [_imageView setImage:[UIImage imageNamed:@"audio_ico"]];
        else
            
            [_imageView setImage: [audioObject albumArt]];
        
        self.titleLabel.attributedText = [audioObject trackName];
    } else if(self.post.type == VIDEO){
        Video * video = (Video*)_post;
        //        [_playerContainer setHidden: YES];
        [_imageView setHidden: YES];
        [_videoView setHidden: NO];
        [_titleLabel setHidden: NO];
        [_titleLabel setText: [video sourceTitle]];
        [self embedVideo];
    }
    [_captionView setText: [post caption]];
    [[Player sharedInstance] playAV] ;
}


- (IBAction)followButtonPressed:(id)sender {
    if([[User sharedInstance] loggedIn]) {
		NSString *blogURL = [[NSString alloc] initWithFormat:@"%@.tumblr.com", [_post blogName]];
		NSLog(@"blog url: %@", blogURL);
		[[TMAPIClient sharedInstance] follow: blogURL callback:^(id response, NSError *error) {
			if(!error){
				dispatch_async(dispatch_get_main_queue(), ^{
					NSString *message = [[NSString alloc] initWithFormat: @"You are now following %@", [_post blogName]];
					UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Follow" message: message  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil, nil];
					[alert show];
				});
			} else {
				dispatch_async(dispatch_get_main_queue(), ^{
					UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Follow" message:@"You have not logged in yet and therefor can't follow any blogs!"  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil, nil];
					[alert show];
				});
			}
		}];
	} else {
		dispatch_async(dispatch_get_main_queue(), ^{
            
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Follow" message:@"JYou have not logged in yet and therefor can't follow any blogs!"  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil, nil];
			[alert show];
            
		});
	}
}

- (IBAction)favoriteButtonPressed:(id)sender {
    if([[User sharedInstance] loggedIn]) {
        [[Favourites sharedManager] addFavourite: _post];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Login" message:@"You are not logged in yet!"  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil, nil];
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
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Follow" message:@"JYou have not logged in yet and therefor can't follow any blogs!"  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil, nil];
                [alert show];
            });
        }
    }];
}

- (void) showControls {
    _playerView.alpha = 0.0f;
    _playerView.hidden = NO;
	// Then fades it away after 2 seconds (the cross-fade animation will take 0.5s)
	[UIView animateWithDuration:0.5 delay: 0 options:0 animations:^{
		// Animate the alpha value of your imageView from 1.0 to 0.0 here
		_playerView.alpha = 1.0f;
    } completion:^(BOOL finished) {
		// Once the animation is completed and the alpha has gone to 0.0, hide the view for good
		
    }];
}

- (void) hideControls {
    _playerView.alpha = 1.0f;
	// Then fades it away after 2 seconds (the cross-fade animation will take 0.5s)
	[UIView animateWithDuration:0.5 delay: 0 options:0 animations:^{
		// Animate the alpha value of your imageView from 1.0 to 0.0 here
		_playerView.alpha = 0.0f;
    } completion:^(BOOL finished) {
		// Once the animation is completed and the alpha has gone to 0.0, hide the view for good
		_playerView.hidden = YES;
    }];
}

- (IBAction)pauseButtonPressed:(id)sender {
    _playPauseButton.selected = !_playPauseButton.selected;
    if([[Player sharedInstance] playing]) {
        [[Player sharedInstance] pauseAV];
        [self showControls];
    } else {
        [[Player sharedInstance] playAV];
        [self hideControls];
    }
}

-(void)viewDidUnload {
    [self setTimeSlider:nil];
    [self setPlayerView:nil];
    [self setPlayPauseButton:nil];
    
    [self setPostView:nil];
    [self setPostView:nil];
    [[[Player sharedInstance] playerLayer] removeFromSuperlayer];
}


@end
