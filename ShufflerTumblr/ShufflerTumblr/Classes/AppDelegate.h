
//
//  AppDelegate.h
//  ShufflerTumblr
//
//  Created by stud on 4/17/13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
	NSString				*oauthVerifier_;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, readwrite, copy) NSString *oauthVerifier;
@end
