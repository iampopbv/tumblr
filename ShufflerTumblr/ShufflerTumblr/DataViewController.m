//
//  DataViewController.m
//  PageBasedAppTest
//
//  Created by Casper Eekhof on 05-05-13.
//  Copyright (c) 2013 Casper. All rights reserved.
//

#import "DataViewController.h"

@interface DataViewController ()

@end

@implementation DataViewController

- (void)viewDidLoad
{
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	// Dummy data
	self.post = [[Audio alloc] initWithDictionary:@{ @"audio_url" : @"http://sogreatandpowerful.com/SoGreatandPowerful%20-%20Untitled.mp3"}];
    
	self.player = [AVPlayer playerWithURL: [NSURL URLWithString: self.post.playURL]];
	[self.player play];
	NSLog(@"playing %@", self.post.playURL);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.dataLabel.text = [self.dataObject description];
}

@end
