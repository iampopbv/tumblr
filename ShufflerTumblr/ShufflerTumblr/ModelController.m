//
//  ModelController.m
//  PageBasedAppTest
//
//  Created by Casper Eekhof on 05-05-13.
//  Copyright (c) 2013 Casper. All rights reserved.
//

#import "ModelController.h"
#import "Video.h"
#import "Audio.h"
#import "DataViewController.h"

/*
 A controller object that manages a simple model -- a collection of month names.
 
 The controller serves as the data source for the page view controller; it therefore implements pageViewController:viewControllerBeforeViewController: and pageViewController:viewControllerAfterViewController:.
 It also implements a custom method, viewControllerAtIndex: which is useful in the implementation of the data source methods, and in the initial configuration of the application.
 
 There is no need to actually create view controllers for each page in advance -- indeed doing so incurs unnecessary overhead. Given the data model, these methods create, configure, and return a new view controller on demand.
 */

@interface ModelController()
@property (readonly, strong, nonatomic) NSMutableArray *pageData;
@end

@implementation ModelController

- (id)init
{
    self = [super init];
    if (self) {
        // Create the data model.
        //        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //        _pageData = [[dateFormatter monthSymbols] copy];
        
        NSMutableArray * dummyData = [[NSMutableArray alloc] init];
        Video * vid1 = [[Video alloc] init];
        [vid1 setPlayerEmbed: @"<object width=\"248\" height=\"169\"><param\
         name=\"movie\" value=\"http://www.youtube.com/\
         v/4Q1aI7xPo0Y&rel=0&egm=0&\
         showinfo=0&fs=1\"></param><param name=\"wmode\"\
         value=\"transparent\"></param><param name=\"\
         allowFullScreen\" value=\"true\"></param><embed\
         src=\"http://www.youtube.com/v/\
         4Q1aI7xPo0Y\" type=\"application/x-shockwave-flash\"\
         width=\"248\" height=\"169\" allowFullScreen=\"true\"\
         wmode=\"transparent\"></embed></object>"];
        vid1.date = @"now";
        vid1.type = VIDEO;
        
        Video * vid2 = [[Video alloc] init];
        [vid2 setPlayerEmbed: @"<object width=\"248\" height=\"169\"><param\
         name=\"movie\" value=\"http://www.youtube.com/\
         v/4Q1aI7xPo0Y&rel=0&egm=0&\
         showinfo=0&fs=1\"></param><param name=\"wmode\"\
         value=\"transparent\"></param><param name=\"\
         allowFullScreen\" value=\"true\"></param><embed\
         src=\"http://www.youtube.com/v/\
         4Q1aI7xPo0Y\" type=\"application/x-shockwave-flash\"\
         width=\"248\" height=\"169\" allowFullScreen=\"true\"\
         wmode=\"transparent\"></embed></object>"];
        vid2.date = @"now";
        vid2.type = VIDEO;
        
        Audio * aud1 = [[Audio alloc] init];
        aud1.playURL = @"http://backup.upwhere.me/music/track02.cdda.wav";
        aud1.date = @"now";
        aud1.type = AUDIO;
        NSURL *albumArtURL = [[NSURL alloc] initWithString: @"http://assets.shuffler.fm/assets/static/images/shuffler_logo_200.png"];
        
        NSData *imageData = [[NSData alloc] initWithContentsOfURL: albumArtURL];
        aud1.albumArt = [[UIImage alloc] initWithData: imageData];
        
        
        [dummyData addObject: vid1];
        [dummyData addObject: vid2];
        [dummyData addObject: aud1];
        _pageData = [dummyData copy];
    }
    return self;
}

-(id)initWithBlog:(id)blog
{
    self = [super init];
    if(self)
    {
        self.blog = blog;
        [self.blog getPosts:VIDEO completionBlock:^(NSArray<Post> *posts, NSError *error) {
            _pageData = [posts copy];
        }];
    }
    return self;
}

- (DataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard
{
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    // Return the data view controller for the given index.
    if (([self.pageData count] == 0)) {
        [self.blog getPosts:VIDEO completionBlock:^(NSArray<Post> *posts, NSError *error) {
            _pageData = [posts copy];
            dispatch_semaphore_signal(sema);
        }];
        
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        dispatch_release(sema);
    }
    
    if (index >= [self.pageData count])
        return nil;
    
    // Create a new view controller and pass suitable data.
    DataViewController *dataViewController = [storyboard instantiateViewControllerWithIdentifier:@"DataViewController"];
    dataViewController.post = self.pageData[index];
    return dataViewController;
}

- (NSUInteger)indexOfViewController:(DataViewController *)viewController
{
    // Return the index of the given data view controller.
    // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
    return [self.pageData indexOfObject:viewController.post];
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(DataViewController *)viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(DataViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageData count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

@end
