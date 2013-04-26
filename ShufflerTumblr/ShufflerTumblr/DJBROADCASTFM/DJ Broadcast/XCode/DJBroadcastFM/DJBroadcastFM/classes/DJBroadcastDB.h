//
//  DJBroadcastDB.h
//  DJBroadcast
//
//  Created by Casper Eekhof on 20-03-13.
//  Copyright (c) 2013 Casper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Release.h"
#import "Mix.h"
#import "Album.h"
#import "Track.h"

@interface DJBroadcastDB : NSObject

typedef void (^DJBroadcastSingleQueryCompletionBlock)(id<Release> release, NSError *error);
typedef void (^DJBroadcastMultipleQueryCompletionBlock)(NSArray *releases, NSError *error);


//@property NSString * urlString;
extern const NSString * const apiURL;
+(NSString *const) APIURI;

-(void) getRelease: (int) releaseId completionBlock:(DJBroadcastSingleQueryCompletionBlock) block;
-(void) getListData: (int) page completionBlock:(DJBroadcastMultipleQueryCompletionBlock) block;
-(void) getBlockData: (int) page completionBlock:(DJBroadcastMultipleQueryCompletionBlock) block;
-(void) getSearch: (NSString*) searchString completionBlock:(DJBroadcastMultipleQueryCompletionBlock) block;
-(id<Release>) parseJSONtoRelease: (NSString*) jsonString;

//-(NSMutableArray*) TableData;



@end
