//
//  playerViewController.m
//  ShufflerTumblr
//
//  Created by B Al on 2013-05-16.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import "playerViewController.h"
#import "YoutubeURLGetter.h"

@interface playerViewController ()

@end

@implementation playerViewController

static inline NSString*timestring(float const seconds)
{
	return [NSString stringWithFormat:@"%@%d:%02d",
            seconds < 3600 ? @"":
            [NSString stringWithFormat:@"%d:",((int)seconds)/3600],
            (((int)seconds)%3600)/60,
            (((int)seconds)%3600)%60];
}

id sharedplayer;
-(AVPlayer *)player{return sharedplayer;}
-(void)setPlayer:(AVPlayer *)player{sharedplayer = player;}

-(void)getPost:(id<Post>)post
{
    self.post = post;
    
    if([post type] == VIDEO) {
        if([[post playURL] hasPrefix:@"http://www.youtube.com"] || [[post playURL] hasPrefix:@"https://www.youtube.com"]){
			[[YoutubeURLGetter sharedInstance] getYoutubeLinkWithURL: [post playURL] withBlock:^(NSString *youtubeDirectURL) {
				[post setPlayURL: youtubeDirectURL];
                self.player = [AVPlayer playerWithURL: [NSURL URLWithString: self.post.playURL]];
                NSLog(@"playing %@, from %@", self.post.playURL, self.post);
			}];
		}
    } else {
        
        self.player = [AVPlayer playerWithURL: [NSURL URLWithString: self.post.playURL]];
        NSLog(@"playing %@, from %@", self.post.playURL, self.post);
    }
    
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)viewDidUnload {
    [self.player pause];
    self.player = nil;
    [self setSeekbar:nil];
    [self setPlaypause:nil];
    [self setPlayTimeLabel:nil];
    [super viewDidUnload];
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

@end
