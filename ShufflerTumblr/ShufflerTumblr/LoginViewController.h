//
//  WebViewController.h
//  ShufflerTumblr
//
//  Created by stud on 4/24/13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MPOAuthAPI;

@interface LoginViewController : UIViewController <UIWebViewDelegate> {
    
    IBOutlet UIWebView *webview;
    NSURL *_userAuthURL;
    
    MPOAuthAPI	*_oauthAPI;
    
}

@property (nonatomic, readwrite, retain) NSURL *userAuthURL;

- (IBAction)clearCredentials;
- (IBAction)reauthenticate;

@end
