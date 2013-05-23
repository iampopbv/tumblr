//
//  BlogInfo.h
//  ShufflerTumblr
//
//  Created by Sem Wong on 4/29/13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Info.h"

@interface BlogInfo : NSObject <Info>

@property NSString* title;
@property NSString* name;
@property NSString* posts;
@property NSURL* blogURL;
@property NSString* updated;
@property NSString* description;
@property NSString* ask;
@property NSString* askAnon;
@property NSNumber* likes;
@property UIImage *image;

@end
