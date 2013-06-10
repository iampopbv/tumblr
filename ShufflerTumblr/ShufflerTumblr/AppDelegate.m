//
//  AppDelegate.m
//  ShufflerTumblr
//
//  Created by stud on 4/17/13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import "AppDelegate.h"
#import "MPOAuthAuthenticationMethodOAuth.h"
#import "RootViewController.h"
#import "DashBoardViewController.h"
#import "MPURLRequestParameter.h"


@implementation AppDelegate

@synthesize oauthVerifier = oauthVerifier_;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (void)applicationDidFinishLaunching:(UIApplication *)application {
	
	// Configure and show the window
}

#pragma mark - MPOAuthAPIDelegate Methods -

- (NSURL *)callbackURLForCompletedUserAuthorization {
	// The x-com-mpoauth-mobile URI is a claimed URI Type
	// check Info.plist for details
	return [NSURL URLWithString:@"x-com-shumblr-mobile://success"];
}

- (NSString *)oauthVerifierForCompletedUserAuthorization {
	return oauthVerifier_;
}

- (BOOL)automaticallyRequestAuthenticationFromURL:(NSURL *)inAuthURL withCallbackURL:(NSURL *)inCallbackURL {
	return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
	// the url is the callback url with the query string including oauth_token and oauth_verifier in 1.0a
	if ([[url host] isEqualToString:@"success"] && [url query].length > 0) {
		NSDictionary *oauthParameters = [MPURLRequestParameter parameterDictionaryFromString:[url query]];
		oauthVerifier_ = [oauthParameters objectForKey:@"oauth_verifier"];
        
        // Notifty the LoginViewController that we can go to the dashboard
        [[NSNotificationCenter defaultCenter] postNotificationName:@"segueListener" object:nil];
        
        NSLog(@"Success authenticating");
	}
    NSLog(@"Failure when authenticating");
	return YES;
}
@end
