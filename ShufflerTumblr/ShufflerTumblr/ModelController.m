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
        _pageData = nil;
        _isLoadingPosts = NO;
    }
    return self;
}

-(id)initWithBlog:(id)blog
{
    self = [super init];
    if(self)
    {
        self.blog = blog;
        _isLoadingPosts = NO;
    }
    return self;
}

- (DataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard
{
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    // Return the data view controller for the given index.
    if (([self.pageData count] == 0)) {
        [self.blog getNextPageLatest:^(NSArray<Post> *posts, NSError *error) {
            _pageData = [[NSMutableArray alloc] initWithArray: posts];
            NSLog(@"loaded %i posts", [posts count]);
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
        if(!_isLoadingPosts) {
            NSLog(@"Initiating posts");
            _isLoadingPosts = YES;
            [self.blog getNextPageLatest:^(NSArray<Post> *posts, NSError *error) {
                if([posts count] != 0) {
                    [_pageData removeObjectsInRange: NSMakeRange(0, [_pageData count] - 2)];
                    [_pageData addObjectsFromArray:posts];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        NSArray *viewControllers = @[viewController];
                        [_rootVC.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:NULL];
                        
                        [_rootVC addChildViewController: _rootVC.pageViewController];
                        [_rootVC.view addSubview: _rootVC.pageViewController.view];
                        
                        // Set the page view controller's bounds using an inset rect so that self's view is visible around the edges of the pages.
                        CGRect pageViewRect = _rootVC.view.bounds;
                        _rootVC.pageViewController.view.frame = pageViewRect;
                        
                        [_rootVC.pageViewController didMoveToParentViewController:_rootVC];
                        NSLog(@"loaded %i posts", [posts count]);
                        _isLoadingPosts = NO;
                    });
                } else {
                    // Show the user that this was the last post.
                }
            }];
        } else {
            NSLog(@"Already loading posts");
        }
        
        return nil;
    }
    
    
    
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

@end
