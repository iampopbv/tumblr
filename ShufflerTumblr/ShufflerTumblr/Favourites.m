//
//  Favourites.m
//  ShufflerTumblr
//
//  Created by Sem Wong on 5/30/13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import "Favourites.h"

@implementation Favourites

static Favourites * favourites = nil;

-(id)init {
    if (favourites == nil) {
        if((favourites = [super init])) {
            return favourites;
        }
    }
    return favourites;
}

-(id)initLoad {
    self = [super init];
    if (self) {
        _favouriteObjects = [[NSMutableArray alloc] init];
        NSFileManager *fileMngr = [NSFileManager defaultManager];
        _root = [[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"shuffler"] stringByAppendingPathComponent: @"favourites"];
        BOOL dir;
        if(![fileMngr fileExistsAtPath:_root isDirectory:&dir]) {
            NSURL *rootURL = [NSURL fileURLWithPath: _root];
            if(![fileMngr createDirectoryAtURL:rootURL withIntermediateDirectories:YES attributes:nil error:NULL])  {
                NSLog(@"Error creating directory");
            }
        }
        NSArray *dirContents = [fileMngr contentsOfDirectoryAtPath:_root error:nil];
        NSPredicate *fltr = [NSPredicate predicateWithFormat:@"self ENDSWITH '.plist'"];
        NSArray *plists = [dirContents filteredArrayUsingPredicate:fltr];
        for(NSString* file in plists) {
            NSString *fileURL = [NSString stringWithFormat:@"%@/%@", _root, file];
            id<Post> object = [NSKeyedUnarchiver unarchiveObjectWithFile:fileURL];
            [_favouriteObjects addObject:object];
        }

    }
    return self;
}

-(void) addFavourite:(id<Post>)post {
    NSLog(@"--------------------------------Adding New Object to Favourites-------------------------------------");
    NSString *fileURL = [NSString stringWithFormat:@"%@/%@.plist", _root, [post getName]];
    NSFileManager *fileMngr = [NSFileManager defaultManager];
    if (![fileMngr fileExistsAtPath:fileURL]) {
        NSLog(@"File does not yet exists, trying to add object...");
        [NSKeyedArchiver archiveRootObject:post toFile:fileURL];
        [_favouriteObjects addObject:[NSKeyedUnarchiver unarchiveObjectWithFile:fileURL]];
        NSLog(@"File added to Favorites!");
    } else {
        NSLog(@"File already exists, going to remove Object...");
        [self removeFavourite: post];
    }
    NSLog(@"Finished. Total objects in favoriteObjects: %d", [self.favouriteObjects count]);
}

-(void) removeFavourite:(id<Post>)post {
    NSLog(@"--------------------------------Removing Objects from Favourites-------------------------------------");
    NSString *fileURL = [NSString stringWithFormat:@"%@/%@.plist", _root, [post getName]];
    NSFileManager *fileMngr = [NSFileManager defaultManager];
    for(int i = 0;i<[_favouriteObjects count];i++) {
        id<Post> object = [_favouriteObjects objectAtIndex:i];
        if ([[object getPostId] isEqual:[post getPostId]]) {
            [_favouriteObjects removeObjectAtIndex:i];
            NSLog(@"Object removed at index: %d", i);
            break;
        }
    }
    if ([fileMngr fileExistsAtPath:fileURL]) {
        if([fileMngr removeItemAtPath:fileURL error:nil]) {
            NSLog(@"File removed");
        } else {
            NSLog(@"File was not removed");
        }
    } else {
        NSLog(@"Error couldn't find file in system: %@" , fileURL);
    }
    NSLog(@"Finished. Total objects in favoriteObjects: %d", [self.favouriteObjects count]);
}

-(BOOL) checkFavourite: (id) ID {
    for(int i = 0; i <[_favouriteObjects count];i++) {
        if ([[[_favouriteObjects objectAtIndex:i] getPostId] isEqual:ID]) {
            return true;
        }
    }
    return false;
}

-(NSArray*) getFavourites {
    return _favouriteObjects;
}


@end
