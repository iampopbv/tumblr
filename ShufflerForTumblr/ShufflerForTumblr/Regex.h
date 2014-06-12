//
//  Regex.h
//  ShufflerForTumblr
//
//  Created by Adrian Zborowski on 13/06/14.
//  Copyright (c) 2014 Hogeschoool van Amsterdam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Regex : NSObject

+(NSString*) hyperlinkRegex:(NSString*)input;

+(NSString*)imageSizeRegex:(NSString*)input;

@end
