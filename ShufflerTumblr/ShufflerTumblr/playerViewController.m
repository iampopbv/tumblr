//
//  playerViewController.m
//  ShufflerTumblr
//
//  Created by B Al on 2013-05-16.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import "playerViewController.h"

@interface playerViewController ()

@end

@implementation playerViewController

@synthesize post;

-(void)getPost:(id<Post>)post
{
    self.post = post;

    self.player = [AVPlayer playerWithURL: [NSURL URLWithString: self.post.playURL]];
    NSLog(@"playing %@, from %@", self.post.playURL, self.post.playURL);
    [self.player play];
}

-(void)showPost
{
    [self continue];
}

-(void)hidePost
{
    if(self.player && self.player.rate)
    {
        [self pause];
    }
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
