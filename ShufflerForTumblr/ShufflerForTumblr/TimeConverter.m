//
//  TimeConverter.m
//  ShufflerForTumblr
//
//  Created by Adrian Zborowski on 03/06/14.
//  Copyright (c) 2014 Hogeschoool van Amsterdam. All rights reserved.
//

#import "TimeConverter.h"

@implementation TimeConverter

/**
 */
+(NSString *)stringForTimeIntervalSinceCreated:(NSDate *)dateTime serverTime:(NSDate *)serverDateTime{
    NSInteger MinInterval;
    NSInteger HourInterval;
    NSInteger DayInterval;
    NSInteger DayModules;
    
    NSInteger interval = abs([dateTime timeIntervalSinceDate:serverDateTime]);
    if(interval >= 86400){
        DayInterval  = interval/86400;
        DayModules = interval%86400;
        if(DayModules!=0){
            if(DayModules>=3600){
                return [NSString stringWithFormat:@"%lu DAYS\n\t\tAGO", DayInterval];
            }else{
                if(DayModules>=60){
                    return [NSString stringWithFormat:@"%lu DAYS\n\t\tAGO", DayInterval];
                }else{
                    return [NSString stringWithFormat:@"%lu DAYS\n\t\tAGO", DayInterval];
                }
            }
        }else{
            return [NSString stringWithFormat:@"%lu DAYS\n\t\tAGO", DayInterval];
        }
    }else{
        if(interval>=3600){
            HourInterval= interval/3600;
            return [NSString stringWithFormat:@"%lu HOURS\n\t\tAGO", HourInterval];
        }else if(interval>=60){
            MinInterval = interval/60;
            return [NSString stringWithFormat:@"%lu MINS\n\t\tAGO", MinInterval];
        }else{
            return [NSString stringWithFormat:@"%lu SEC.\n\t\tAGO", interval];
        }
    }
}

@end
