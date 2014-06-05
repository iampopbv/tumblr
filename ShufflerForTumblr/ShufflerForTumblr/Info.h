//
//  Info.h
//  ShufflerForTumblr
//
//  Created by Adrian Zborowski on 05/06/14.
//  Copyright (c) 2014 Hogeschoool van Amsterdam. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Info <NSObject>

@property NSDictionary* blog;

// Fill the object with a response dictionary from the Tumblr API
-(id) initWithDictionary: (NSDictionary*) data;
// Fill the object with a blog dictionary from the Tumblr API
-(id) initWithBlogDictionary:(NSDictionary *) blogDict;

@end
