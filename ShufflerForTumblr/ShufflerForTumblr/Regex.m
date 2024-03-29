//
//  Regex.m
//  ShufflerForTumblr
//
//  Created by Adrian Zborowski on 13/06/14.
//  Copyright (c) 2014 Hogeschoool van Amsterdam. All rights reserved.
//

#import "Regex.h"

@implementation Regex

/**
 */
+(NSString*) hyperlinkRegex:(NSString*)input{
    NSString *stringtoReplace = @"(?i)<a([^>]+)>";
    
    NSString *pattern = [NSString stringWithFormat:@"%@", stringtoReplace];
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *result = [regex stringByReplacingMatchesInString:input options:0 range:NSMakeRange(0, input.length) withTemplate:@""];
    
    return result;
}

@end
