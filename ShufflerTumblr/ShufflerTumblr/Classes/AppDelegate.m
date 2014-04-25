//
//  AppDelegate.m
//  ShufflerTumblr
//
//  Created by stud on 4/17/13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import "AppDelegate.h"
#import "DashBoardViewController.h"
#import "TMAPIClient.h"
#import "Player.h"
#import "AKZAuthViewController.h"



@implementation AppDelegate


-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
    printf(">>> didFinishLaunchingwithOptions\n");
    
    [TMAPIClient sharedInstance].OAuthConsumerKey = @"NPIxO1R794eabwFPmWLuqhsyMxYcYIXwGBCALvOlzNFoaCt378";
    [TMAPIClient sharedInstance].OAuthConsumerSecret = @"pVOq6DkuOjNjUy52oXXX2iKzMJl9gcfIPVkutFjkmzrxjPfqMc";
    
    // Override point for customization after application launch.
    //[[UINavigationBar appearance] setBackgroundImage: [UIImage imageNamed:@"navigationbar3"] forBarMetrics:UIBarMetricsDefault];
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    [audioSession setActive:YES error:nil];
    
//    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    self.window.backgroundColor = [UIColor colorWithRed:0.173 green:0.278 blue:0.384 alpha:1];
//    [self.window makeKeyAndVisible];
//    self.window.rootViewController = [[AKZAuthViewController alloc] init];
    
//    if(1){
//        UIViewController* rootController = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"AKZAuthViewController"];
//        
//        UINavigationController* navigation = [[UINavigationController alloc] initWithRootViewController:rootController];
//        
//        self.window.rootViewController = navigation;
//    }else{
//        UIViewController* rootController = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"AKZLoginViewController"];
//        
//        UINavigationController* navigation = [[UINavigationController alloc] initWithRootViewController:rootController];
//        
//        self.window.rootViewController = navigation;
//    }
    
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
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    [audioSession setActive:YES error:nil];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (void)applicationDidFinishLaunching:(UIApplication *)application {
	
	// Configure and show the window
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    [audioSession setActive:YES error:nil];
}

- (NSURL *)callbackURLForCompletedUserAuthorization {
    // Call back to our app :)
	return [NSURL URLWithString:@"x-com-shumblr-mobile://success"];
}

- (BOOL)automaticallyRequestAuthenticationFromURL:(NSURL *)inAuthURL withCallbackURL:(NSURL *)inCallbackURL {
	return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [[TMAPIClient sharedInstance] handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [[TMAPIClient sharedInstance] handleOpenURL:url];
}

@end
