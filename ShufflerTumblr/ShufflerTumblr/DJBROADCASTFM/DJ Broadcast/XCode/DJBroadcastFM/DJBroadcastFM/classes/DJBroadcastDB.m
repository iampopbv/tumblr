//
//  DJBroadcastDB.m
//  DJBroadcast
//
//  Created by Casper Eekhof on 20-03-13.
//  Copyright (c) 2013 Casper. All rights reserved.
//

#import "DJBroadcastDB.h"

@implementation DJBroadcastDB

const NSString * const apiURL = @"http://www.djbroadcast.fm/fmapi/";
+(NSString const*const)APIURI{return apiURL;}

static DJBroadcastDB * djBroadcastDB = nil;

- (id)init
{
	if(djBroadcastDB == nil){
		if ((djBroadcastDB = [super init])) {
			return djBroadcastDB;
		}
	}
	return djBroadcastDB;
}


-(void) getRelease: (int) releaseId completionBlock:(DJBroadcastSingleQueryCompletionBlock) block  {
	dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
	
	dispatch_async(queue, ^{
		NSString *url = [[NSString alloc] initWithFormat: @"%@%@%d", apiURL, @"release/", releaseId];
		NSURL *urlRequest = [NSURL URLWithString:url];
		NSError *err = nil;
		
		NSString *response = [NSString stringWithContentsOfURL:urlRequest encoding:NSUTF8StringEncoding error:&err];
		

		id<Release> release = [self parseJSONtoRelease:response];
		NSLog(@"Release title: %@", [release title]);
		
		// download the thumbnail and put it in the model
		NSURL *imageURL = [release imageSmallURL];
		NSData *imageData = [NSData dataWithContentsOfURL: imageURL options:0 error: &err];
		UIImage *image = [UIImage imageWithData:imageData];
		[release setImage: image];
		
		if(err) {
			NSLog(@"An error has occured %@", err  );
		}
		// Return the release object with the error if occured
		block(release, err);
	});
}

-(void) getListData: (int) page completionBlock:(DJBroadcastMultipleQueryCompletionBlock) block {
	dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
	
	dispatch_async(queue, ^{
		NSMutableArray *releasesTmp = [[NSMutableArray alloc] init];
		NSArray *returnReleases; // value to return
		
		NSString *url = [[NSString alloc] initWithFormat: @"%@%@%d", apiURL, @"listdata/", page];
		NSURL *urlRequest = [NSURL URLWithString:url];
		NSError *err = nil;
		
		NSMutableString *response = [NSMutableString stringWithContentsOfURL:urlRequest encoding:NSUTF8StringEncoding error:&err];
		
		
		// Go every Release object(JSON) and put it in the Release object(Model)
		NSArray *JSONObjects = [response componentsSeparatedByString:@"},{"];

		for(int i = 0; i < JSONObjects.count; i++) {
			NSMutableString *tempResult = [JSONObjects objectAtIndex: i];
			if (i == 0) {
				tempResult = [NSMutableString stringWithFormat: @"%@%@", [tempResult substringFromIndex:1] , @"}"];
			} else if (i == JSONObjects.count - 1) {
				tempResult = [NSMutableString stringWithFormat:@"{%@" , [tempResult substringWithRange: NSMakeRange(0, [tempResult length] - 2)]];
			}
			else {
				tempResult = [NSMutableString stringWithFormat:@"{%@%@" , tempResult , @"}"];
			}
			
//			NSLog(@"%@", tempResult);
			
			id<Release> currentRelease = [self parseJSONtoRelease:tempResult];
			if (currentRelease != NULL) {
			
				// download the thumbnail and put it in the model
				NSURL *imageURL;
				if (currentRelease.imageSmallURL != nil)
					imageURL = currentRelease.imageSmallURL;
				else
					imageURL = [NSURL URLWithString:@"http://www.mediabistro.com/agencyspy/files/original/logo_gray_block-761x641.jpg"];
			
//				NSLog(@"%@" , imageURL);
				NSData *imageData = [NSData dataWithContentsOfURL: imageURL options:0 error:&err];
				UIImage *image = [UIImage imageWithData:imageData];
				[currentRelease setImage: image];
			
				[releasesTmp addObject: currentRelease];
			
				if(err)
				{
					NSLog(@"An error has occured %@", err);
				}
			}
			
			
			
		}
				
		returnReleases = releasesTmp;
		block(returnReleases, err);
	});
}



-(void) getBlockData: (int) page completionBlock:(DJBroadcastMultipleQueryCompletionBlock) block {
	
	dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
	
	dispatch_async(queue, ^{
		NSMutableArray *releasesTmp = [[NSMutableArray alloc] init];
		NSArray *returnReleases; // value to return
		
		NSString *url = [[NSString alloc] initWithFormat: @"%@%@%d", apiURL, @"blockdata/", page];
		NSURL *urlRequest = [NSURL URLWithString:url];
		NSError *err = nil;
		
		NSString *response = [NSString stringWithContentsOfURL:urlRequest encoding:NSUTF8StringEncoding error:&err];
		
		
		// Go every Release object(JSON) and put it in the Release object(Model)
		//        for () {
		// Parse
		NSArray *JSONObjects = [response componentsSeparatedByString:@"},{"];
		for(int i = 0; i < JSONObjects.count; i++) {
			NSString *tempResult = [JSONObjects objectAtIndex: i];
			if (i == 0) {
				tempResult = [NSString stringWithFormat:tempResult , @"}" ];
			} else if (i == JSONObjects.count - 1) {
				tempResult = [NSString stringWithFormat:@"{%@" , tempResult];
			}
			else {
				tempResult = [NSString stringWithFormat:@"{%@%@" , tempResult , @"}"];
			}
			
			id<Release> currentRelease = [self parseJSONtoRelease:tempResult];
			
			// download the thumbnail and put it in the model
			NSURL *imageURL = [[NSURL alloc] initWithString:@""];
			NSData *imageData = [NSData dataWithContentsOfURL: imageURL options:0 error:&err];
			UIImage *image = [UIImage imageWithData:imageData];
			[currentRelease setImage: image];
			
			if(err)
			{
				NSLog(@"An error has occured %@", err);
			}
			
			returnReleases = releasesTmp;
			block(returnReleases, err);
			
		}
	});
}

-(void) getSearch: (NSString*) searchString completionBlock:(DJBroadcastMultipleQueryCompletionBlock) block {
	
	dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
	
	dispatch_async(queue, ^{
		NSMutableArray *releasesTmp = [[NSMutableArray alloc] init];
		NSArray *returnReleases; // value to return
		
		NSString *url = [[NSString alloc] initWithFormat: @"%@%@%@", apiURL, @"search/", searchString];
		NSURL *urlRequest = [NSURL URLWithString:url];
		NSError *err = nil;
		
		NSString *response = [NSString stringWithContentsOfURL:urlRequest encoding:NSUTF8StringEncoding error:&err];
		

		// Parse
		NSArray *JSONObjects = [response componentsSeparatedByString:@"},{"];
		for(int i = 0; i < JSONObjects.count; i++) {
			NSString *tempResult = [JSONObjects objectAtIndex: i];
			if (i == 0) {
				tempResult = [NSString stringWithFormat:tempResult , @"}" ];
			} else if (i == JSONObjects.count - 1) {
				tempResult = [NSString stringWithFormat:@"{%@" , tempResult];
			}
			else {
				tempResult = [NSString stringWithFormat:@"{%@%@" , tempResult , @"}"];
			}
			
			id<Release> currentRelease = [self parseJSONtoRelease:tempResult];
			
			// download the thumbnail and put it in the model
			NSURL *imageURL = [[NSURL alloc] initWithString:@""];
			NSData *imageData = [NSData dataWithContentsOfURL: imageURL options:0 error:&err];
			UIImage *image = [UIImage imageWithData:imageData];
			[currentRelease setImage: image];
			
			if(err)
			{
				NSLog(@"An error has occured %@", err);
			}
			
			returnReleases = releasesTmp;
			block(returnReleases, err);
			
		}
		
	});
}


-(id <Release>) parseJSONtoRelease: (NSString*) jsonString
{
	SBJSON *parser = [[SBJSON alloc] init];
	// TODO: add code for parsing
	
	NSDictionary *results = [parser objectWithString:jsonString error:nil];
	
	NSString *type = [results objectForKey:@"type"];
	
	id<Release> r;
	switch ([type characterAtIndex:0])
	{
		case 'm':
			r = [Mix alloc];
			break;
		case 'a':
			r = [Album alloc];
			break;
	}
	return [r initWithData:results];
}


@end
