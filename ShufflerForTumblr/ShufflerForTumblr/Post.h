//
//  Post.h
//  ShufflerForTumblr
//
//  Created by Adrian Zborowski on 09/05/14.
//  Copyright (c) 2014 Hogeschoool van Amsterdam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Post : NSObject

@property(nonatomic, copy) NSString *username;
@property(nonatomic, copy) NSString *timestamp;
@property(nonatomic, copy) NSString *profile;
@property(nonatomic, copy) NSString *image;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *notes;

@end
