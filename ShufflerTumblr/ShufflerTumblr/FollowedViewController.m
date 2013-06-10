//
//  FollowedViewController.m
//  ShufflerTumblr
//
//  Created by Casper Eekhof on 26-05-13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import "FollowedViewController.h"
#import "bloggetter.h"

@interface FollowedViewController ()

@end

@implementation FollowedViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    NSDictionary *titleTextAttributesDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                             [UIColor whiteColor], UITextAttributeTextColor,
                                             [UIColor whiteColor], UITextAttributeTextShadowColor,
                                             [NSValue valueWithUIOffset:UIOffsetMake(0, 1)], UITextAttributeTextShadowOffset,
                                             [UIFont fontWithName:@"BrandonGrotesque-Bold" size:23.0], UITextAttributeFont,
                                             nil];
    [self.navigationController.navigationBar setTitleTextAttributes: titleTextAttributesDict];
	// Do any additional setup after loading the view.
    _testBlog = [[Blog alloc] initWithURL:@"http://tuneage.tumblr.com/"];
    [_testBlog getInfo:^(id<Info> info, NSError *error) {
    }];
}

-(void)viewDidAppear:(BOOL)animated {
    self.navigationController.navigationBar.topItem.title = @"Followed";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSString *segueName = [segue identifier];
    
    if([segueName isEqualToString:@"segue_follow"]){
         [(id<bloggetter>)segue.destinationViewController getBlog: _testBlog];
    }
}

@end
