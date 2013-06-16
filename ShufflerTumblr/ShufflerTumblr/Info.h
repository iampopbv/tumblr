//
//  Info.h
//  ShufflerTumblr
//
//  Created by Sem Wong on 4/29/13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Info <NSObject>

/**
 *
 */
@property NSDictionary* blog;

// Fill the object with a response dictionary from the Tumblr API
-(id) initWithDictionary: (NSDictionary*) data;
// Fill the object with a blog dictionary from the Tumblr API
-(id) initWithBlogDictionary:(NSDictionary *) blogDict;

@end
