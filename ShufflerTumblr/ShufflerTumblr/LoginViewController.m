//
//  WebViewController.m
//  ShufflerTumblr
//
//  Created by stud on 4/24/13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import "LoginViewController.h"
#import "MPOAuthAPI.h"
#import "MPOAuthAuthenticationMethodOAuth.h"

#define kConsumerKey		@"9DTflrfaaL6XIwUkh1KidnXFUX0EQUZFVEtjwcTyOLNsUPoWLV"
#define kConsumerSecret		@"08SjC79ZiQPqY8Dn8kg0Rn2OxIPrNb8xEuNbB7Op7rMW0VFdOs"

@interface LoginViewController ()

@end

//https://github.com/tumblr/TMTumblrSDK#documentation

@implementation LoginViewController

- (id)initWithURL:(NSURL *)inURL {
	if ((self = [super initWithNibName:@"UserAuthViewController" bundle:nil])) {
		self.title = @"User Auth";
		self.navigationItem.prompt = @"Request Authorization for this application";
		self.userAuthURL = inURL;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    if (!_oauthAPI) {
		NSDictionary *credentials = [NSDictionary dictionaryWithObjectsAndKeys:	kConsumerKey, kMPOAuthCredentialConsumerKey,
									 kConsumerSecret, kMPOAuthCredentialConsumerSecret,
									 nil];
		_oauthAPI = [[MPOAuthAPI alloc] initWithCredentials:credentials
										  authenticationURL:[NSURL URLWithString:@"http://www.tumblr.com/oauth/authorize"]
												 andBaseURL:[NSURL URLWithString:@"http://www.tumblr.com/"]];
		
		if ([[_oauthAPI authenticationMethod] respondsToSelector:@selector(setDelegate:)]) {
			[(MPOAuthAuthenticationMethodOAuth *)[_oauthAPI authenticationMethod] setDelegate:(id <MPOAuthAuthenticationMethodOAuthDelegate>)[UIApplication sharedApplication].delegate];
		}
        
        [_oauthAPI discardCredentials];
        
	} else {
		[_oauthAPI authenticate];
	}

    [_oauthAPI authenticate];
    
	[webview setDelegate:self];
//	[webview loadRequest:[NSURLRequest requestWithURL:self.userAuthURL]];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
	// this is a ghetto way to handle this, but it's for when you must use http:// URIs
	// so that this demo will work correctly, this is an example, DONT.BE.GHETTO
	NSURL *userAuthURL = [(id <MPOAuthAuthenticationMethodOAuthDelegate>)[UIApplication sharedApplication].delegate callbackURLForCompletedUserAuthorization];
	if ([request.URL isEqual:userAuthURL]) {
		[[self navigationController] popViewControllerAnimated:YES];
		return NO;
	}
	
	return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clearCredentials {
	[self.navigationItem setPrompt:@"Credentials Cleared"];
	[_oauthAPI discardCredentials];
}

- (void)reauthenticate {
	[self.navigationItem setPrompt:@"Reauthenticating User"];
	[_oauthAPI authenticate];
}

@end
