//
//  AudioPost.m
//  ShufflerForTumblr
//
//  Created by Adrian Zborowski on 01/06/14.
//  Copyright (c) 2014 Hogeschoool van Amsterdam. All rights reserved.
//

#import "AudioPost.h"

@implementation AudioPost

@synthesize blog;
@synthesize response;
@synthesize posts;
@synthesize playURL;
@synthesize playerEmbed;
@synthesize ID;
@synthesize date;
@synthesize caption;
@synthesize track_name;
@synthesize artist;
@synthesize album;
@synthesize album_art;
@synthesize albumArtURL;
@synthesize type;
@synthesize latestPostNr;
@synthesize postTimestamp;
@synthesize blogName;
@synthesize postURL;
@synthesize reblogKey;

/**
 */
-(NSString *) getListName {
	return [NSString stringWithFormat:@"Audio - %@", self.blogName];
}

/**
 */
-(NSString *)getName {
	NSString *name = [NSString stringWithFormat:@"Audio from: %@", self.ID];
	return name;
}

/**
 */
-(id)getPostId {
	return self.ID;
}

/**
 */
-(id) initWithDictionary:(NSDictionary *)dictionary {
	self = [super init];
	if (self) {
		self.posts = [dictionary objectForKey:@"post"];
		//[self.response objectForKey:@"post"];
		
		self.blogName = [dictionary objectForKey: @"blog_name"];
		self.blog = [dictionary objectForKey:@"blog"];
		self.postURL = [dictionary objectForKey: @"post_url"];
		self.playURL = [dictionary objectForKey:@"audio_url"];
		self.playerEmbed = [dictionary objectForKey:@"player"];
		self.reblogKey = [dictionary objectForKey:@"reblog_key"];
		self.playerEmbed=[dictionary objectForKey: @"playerEmbed"];
		self.ID = [dictionary objectForKey:@"id"];
		self.date = [dictionary objectForKey:@"date"];
		self.caption = [dictionary objectForKey:@"caption"];
        NSString* namehtml = [dictionary objectForKey:@"track_name"];
        if(namehtml){
            self.track_name = [[NSAttributedString alloc] initWithString: namehtml];
        }
        
		self.artist = [dictionary objectForKey:@"artist"];
		self.album = [dictionary objectForKey:@"album"];
		self.album_art = [NSURL URLWithString: [dictionary objectForKey:@"album_art"]];
		
		NSData *imageData = [[NSData alloc] initWithContentsOfURL: albumArtURL];
		self.albumImage = [[UIImage alloc] initWithData: imageData];
		self.latestPostNr = [[self.blog objectForKey:@"total_posts"] intValue] - 1;
		self.postTimestamp = [dictionary objectForKey:@"timestamp"];
		
		
		self.type = AUDIO;
        //		NSLog(@"made %@ from %@ ( not %@ ) with %@",self.playURL, [dictionary objectForKey:@"audio_url"], [self.response objectForKey:@"audio_url"], dictionary);
        //		NSLog(@"latest post nr: %i", latestPostNr);
	}
	return self;
}

/**
 */
-(PostType) getType {
	return self.type;
}

@end
