//
//  DetailVC.m
//  DJBroadcastFM
//
//  Created by Casper Eekhof on 18-04-13.
//  Copyright (c) 2013 Casper. All rights reserved.
//

#import "DetailViewController.h"


@interface DetailViewController ()

@end

@implementation DetailViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)closeButtonTouchUpInside:(id)sender {
    if(_expanded)
        [_parentContainer hideView];
    _expanded = false;
}

- (IBAction)swipedLeft:(id)sender {
    if(_expanded)
        [_parentContainer hideView];
    _expanded = false;
}

- (void) showViewAndDisplayRelease:(id<Release>) release {
    if(!_expanded) {
        [_parentContainer showView];
    
        // Causes a NSInvalidArgumentException
        [self displayRelease: release];
        _release = release;
    }
    _expanded = true;
}


- (void) displayRelease: (id<Release>) release
{
	[_ratebar displayRating: 7];
	
	[_titleLabel setFont:[UIFont fontWithName:@"Lucida Grande" size: 25]];
	[_titleLabel setText:[release title]];
	
	[_image setImage:[release image]];
	
	ReleaseType t = [release type];
	NSString *typeName;
	if (t == ALBUM) {
		typeName = @"Album •";
	}
	if (t == MIX) {
		typeName = @"DJ Mix •";
	}
	if (t == TRACK) {
		typeName = @"Track •";
	}
	if (t == PLAYLIST) {
		typeName = @"Playlist •";
	}
	
	[_type setText:typeName];
	[_type setFont:[UIFont fontWithName:@"Lucida Grande" size: 13]];
	
	// description may be empty string.
	[_descriptionText setFont:[UIFont fontWithName:@"Lucida Grande" size: 16]];
	[_descriptionText setText: [release descriptiontext]];
	
	// split duration into (optional hours) minutes and seconds
	[_duration setText:[NSString stringWithFormat:@"%@%02d:%02d",
					[release playtime] < 3600 ? @"":
						[NSString stringWithFormat:@"%02d:",((int)[release playtime])/3600],
					(((int)[release playtime])%3600)/60,
					(((int)[release playtime])%3600)%60]];
	
	// serialise genres
	NSString *genres = @"";
	for (NSString *genre in [release genres]) {
		genres = [NSString stringWithFormat:@"%@, %@", genres, genre];
	}
	[_genre setText:[genres stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@", "]]];
}

- (IBAction)playButtonPressed:(id)sender
{
	[[[TopbarView alloc] init] playSong:_release];
}


@end
