//
//  WebViewController.m
//  ShufflerTumblr
//
//  Created by stud on 4/24/13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import "LoginViewController.h"
#import "keys.h"
#import "TMAPIClient.h"

@interface LoginViewController ()

@end

//https://github.com/tumblr/TMTumblrSDK#documentation

@implementation LoginViewController

- (id)initWithURL:(NSURL *)inURL {
	if ((self = [super initWithNibName:@"UserAuthViewController" bundle:nil])) {
	}
	
	return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void) loginSegue {
    [self performSegueWithIdentifier:@"login_segue" sender:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSegue) name:@"segueListener" object:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clearCredentials {
    //	[self.navigationItem setPrompt:@"Credentials Cleared"];
    //	[_oauthAPI discardCredentials];
}

- (void)reauthenticate {
    //	[self.navigationItem setPrompt:@"Reauthenticating User"];
    //	[_oauthAPI authenticate];
}

@end
