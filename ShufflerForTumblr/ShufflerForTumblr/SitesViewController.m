//
//  SitesViewController.m
//  ShufflerForTumblr
//
//  Created by Adrian Zborowski on 19/05/14.
//  Copyright (c) 2014 Hogeschoool van Amsterdam. All rights reserved.
//

#import "TMApiClient.h"
#import "SitesViewController.h"
#import "Post.h"

@interface SitesViewController ()

@end

@implementation SitesViewController

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
    
    [[TMAPIClient sharedInstance] userInfo:^(id result, NSError *error) {
        if (!error){
            NSLog(@"Got some user info");
            NSLog(@"%@", [result valueForKeyPath:@"user.blogs.description"]);
        }else{
            NSLog(@"No user info!!!");
        }
    }];
    
    NSArray * paramsKeys = [[NSArray alloc] initWithObjects:
                            @"limit",
                            @"offset",
                            @"type",
                            nil];
    NSArray * paramsVals = [[NSArray alloc] initWithObjects:
                            [[NSString alloc] initWithFormat:@"%i", 5],
                            [[NSString alloc] initWithFormat:@"%i", 0],
                            @"audio",
                            nil];
    NSDictionary *paramsDict = [[NSDictionary alloc] initWithObjects: paramsVals forKeys: paramsKeys];
    NSMutableArray<Post> *posts = (NSMutableArray<Post> *)[[NSMutableArray alloc] init];
    
    [[TMAPIClient sharedInstance]dashboard:paramsDict callback:^(id response, NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
