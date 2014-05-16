//
//  ViewController.m
//  MP3TEST
//
//  Created by Matthijs on 4/30/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"
#import "YTPlayerView.h"

@interface ViewController ()

//@property (nonatomic, strong) UIWebView *webView;

@end

@implementation ViewController

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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"goToPlayer"]){
        YTPlayerView *controller = segue.destinationViewController;
        controller.playerNumber = _PlayerNr;
    }
}

-(IBAction) setYoutube{
    _PlayerNr = 1;
}

-(IBAction) setSoundCloud{
    _PlayerNr = 2;
}

-(IBAction) setBandCamp{
    _PlayerNr = 3;
}

@end
