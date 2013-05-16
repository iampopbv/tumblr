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
    NSLog(@"mail");
    self.post = post;
    
    self.player = [AVPlayer playerWithURL: [NSURL URLWithString: self.post.playURL]];
    [self.player play];
    NSLog(@"playing %@, from %@", self.post.playURL, self.post.playURL);
}

static id<postgetter> shareddelegate;
-(id<postgetter>)delegate{return shareddelegate;}
-(void)setDelegate:(id<postgetter>)delegate{shareddelegate=delegate;}

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
    [self setSeekbar:nil];
    [self setPlaypause:nil];
    [super viewDidUnload];
}
- (IBAction)playpause:(id)sender {
    if(self.player.rate)
       [self.player pause];
    else
        [self.player play];
}
@end
