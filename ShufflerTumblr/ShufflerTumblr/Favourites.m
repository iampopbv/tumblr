//
//  Favourites.m
//  ShufflerTumblr
//
//  Created by Sem Wong on 5/30/13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import "Favourites.h"
#import "TMAPIClient.h"

@implementation Favourites

+(Favourites *) sharedManager {
    static Favourites * _favourites = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _favourites = [[Favourites alloc] init];
    });
    
    return _favourites;
}

-(id)init {
    self = [super init];
    if (self) {
        /*_favouriteObjects = [[NSMutableArray alloc] init];
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
        }*/

    }
    return self;
}

/**
 * Adds a favorite post.
 */
-(void) addFavourite:(id<Post>)post {
    /*NSLog(@"--------------------------------Adding New Object to Favourites-------------------------------------");
    NSString *fileURL = [NSString stringWithFormat:@"%@/%@.plist", _root, [post getName]];
    NSFileManager *fileMngr = [NSFileManager defaultManager];
    if (![fileMngr fileExistsAtPath:fileURL]) {
        NSLog(@"File does not yet exists, trying to add object...: %@; With fileURL: %@" , post, fileURL);
        [NSKeyedArchiver archiveRootObject:post toFile:fileURL];
        [_favouriteObjects addObject:[NSKeyedUnarchiver unarchiveObjectWithFile:fileURL]];
        NSLog(@"File added to Favorites!");
    } else {
        NSLog(@"File already exists, going to remove Object...");
        [self removeFavourite: post];
    }
    NSLog(@"Finished. Total objects in favoriteObjects: %d", [self.favouriteObjects count]);*/
    [[TMAPIClient sharedInstance] likes: nil callback:^(id response, NSError *error) {
        if(!error) {
            NSLog(@"check");
            NSArray *tempArray = [response objectForKey:@"liked_posts"];
            BOOL success = true;
            for(int i = 0;i<[tempArray count];i++) {
                NSLog(@"Checking Post ID: %@ with likesArray ID: %@" , [post getPostId] , [[tempArray objectAtIndex:i] objectForKey:@"id"]);
                if ([[post getPostId] isEqual:[[tempArray objectAtIndex:i] objectForKey:@"id"]]) {
                    NSLog(@"Object is already favourited");
                    [self removeFavourite: post];
                    success = false;
                    break;
                }
            }
            if (success) {
                [[TMAPIClient sharedInstance] like:[post getPostId] reblogKey:[post reblogKey] callback:^(id response, NSError *error) {
                    if(!error) {
                        NSLog(@"Successfully added favourite to favourites");
                    } else {
                        NSLog(@"An error occurred while trying to add favourite");
                    }
                }];
            }
        } else {
            NSLog(@"An error occurred!");
        }
    }];
}

/**
 * Removes a favorite post.
 */
-(void) removeFavourite:(id<Post>)post {
    /*(NSLog(@"--------------------------------Removing Objects from Favourites-------------------------------------");
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
    NSLog(@"Finished. Total objects in favoriteObjects: %d", [self.favouriteObjects count]);*/
    
    [[TMAPIClient sharedInstance] likes: nil callback:^(id response, NSError *error) {
        if(!error) {
            NSLog(@"check");
            NSArray *tempArray = [response objectForKey:@"liked_posts"];
            BOOL success = false;
            for(int i = 0;i<[tempArray count];i++) {
                NSLog(@"Checking Post ID: %@ with likesArray ID: %@" , [post getPostId] , [[tempArray objectAtIndex:i] objectForKey:@"id"]);
                if ([[post getPostId] isEqual: [[tempArray objectAtIndex:i] objectForKey:@"id"]]) {
                    success = true;
                    break;
                }
            }
            if (success) {
                [[TMAPIClient sharedInstance] unlike:[post getPostId] reblogKey:[post reblogKey] callback:^(id response, NSError *error) {
                    if(!error) {
                        NSLog(@"Successfully removed favourite to favourites");
                    } else {
                        NSLog(@"An error occurred while trying to remove favourite:\n%@" , response);
                    }
                }];
            }
        } else {
            NSLog(@"An error occurred!");
        }
    }];
}

// Checks whether a fav exist or not
-(BOOL) checkFavourite: (id) ID {
    for(int i = 0; i <[_favouriteObjects count];i++) {
        if ([[[_favouriteObjects objectAtIndex:i] getPostId] isEqual:ID]) {
            return true;
        }
    }
    return false;
}

-(NSMutableArray*) getFavourites {
    return _favouriteObjects;
}


@end
