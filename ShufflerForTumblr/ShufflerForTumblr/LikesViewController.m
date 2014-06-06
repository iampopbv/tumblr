//
//  LikesViewController.m
//  ShufflerForTumblr
//
//  Created by Adrian Zborowski on 06/06/14.
//  Copyright (c) 2014 Hogeschoool van Amsterdam. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "LikesViewController.h"
#import "TMAPIClient.h"

@interface LikesViewController ()

@end

@implementation LikesViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    NSArray* paramsKeys = [[NSArray alloc] initWithObjects:nil];
    NSArray* paramsVals = [[NSArray alloc] initWithObjects:nil];
    NSDictionary *paramsDict = [[NSDictionary alloc]initWithObjects:paramsVals forKeys:paramsKeys];
    
    [[TMAPIClient sharedInstance]likes:paramsDict callback:^(id response, NSError *error) {
        NSLog(@"%@", response);
    }];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{}

@end