//
//  Info.h
//  ShufflerTumblr
//
//  Created by Sem Wong on 4/29/13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Info <NSObject>


@property NSDictionary* blog;

-(id) initWithDictionary: (NSDictionary*) data;
-(id) initWithBlogDictionary:(NSDictionary *) blogDict;

@end
