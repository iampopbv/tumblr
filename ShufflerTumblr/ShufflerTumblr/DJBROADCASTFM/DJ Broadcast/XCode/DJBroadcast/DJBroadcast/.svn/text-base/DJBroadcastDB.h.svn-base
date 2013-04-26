//
//  DJBroadcastDB.h
//  DJBroadcast
//
//  Created by Casper Eekhof on 20-03-13.
//  Copyright (c) 2013 Casper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Release.h"

@interface DJBroadcastDB : NSObject

@property NSString * urlString;
extern const NSString * apiURL;

-(Release*) getRelease: (int) releaseId;

-(NSMutableArray*) getListData: (int) page;
-(NSMutableArray*) getBlockedData: (int) page;
-(NSMutableArray*) getSearch: (NSString*) searchString;
-(NSMutableArray*) TableData;



@end
