//
//  SitesViewController.m
//  ShufflerForTumblr
//
//  Created by Adrian Zborowski on 19/05/14.
//  Copyright (c) 2014 Hogeschoool van Amsterdam. All rights reserved.
//

#import "TMApiClient.h"
#import "SitesViewController.h"
#import "AppSession.h"
#import "Following.h"
#import "SiteProfileViewController.h"

@interface SitesViewController ()
@end

/**
 */
NSMutableArray* followData;
NSArray *tableData;
/**
 */
static NSString* cellIdentifier = @"siteCell";
/**
 */
NSMutableString* user;

/**
 */
@implementation SitesViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    followData = [[NSMutableArray alloc] init];
    
//    [self loadFollowingUsers];
    
    [[AppSession sharedInstance]loadSites:^(NSArray* follows) {
        followData =[[NSMutableArray alloc] initWithArray:follows];
        [[self tableView] reloadData];
    }];
}

-(void)loadFollowingUsers{
    dispatch_semaphore_t semaphore1 = dispatch_semaphore_create(0);
    [[TMAPIClient sharedInstance] userInfo:^(id result, NSError *error) {
        if (!error){
            user = [result valueForKeyPath:@"user.name"];
        }
        dispatch_semaphore_signal(semaphore1);
    }];
    while (dispatch_semaphore_wait(semaphore1, DISPATCH_TIME_NOW)){
        [[NSRunLoop currentRunLoop]runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:10]];
    }
    
    NSArray* paramsKeys = [[NSArray alloc] initWithObjects:@"base-hostname", nil];
    NSArray* paramsVals = [[NSArray alloc] initWithObjects:
                           [[NSString alloc] initWithFormat:@"%@", user], nil];
    NSDictionary *paramsDict = [[NSDictionary alloc]initWithObjects:paramsVals forKeys:paramsKeys];
    
    dispatch_semaphore_t semaphore2 = dispatch_semaphore_create(0);
    
    [[TMAPIClient sharedInstance]following:paramsDict callback:^(id result, NSError *error) {
        if(!error){
            for(NSArray* follow in [result valueForKeyPath:@"blogs"]){
                Following* siteFollow = [[Following alloc]init];
                siteFollow.description = [follow valueForKeyPath:@"description"];
                siteFollow.name = [follow valueForKeyPath:@"name"];
                siteFollow.title = [follow valueForKeyPath:@"title"];
                siteFollow.updated = [[follow valueForKeyPath:@"updated"] integerValue];
                siteFollow.url = [follow valueForKeyPath:@"url"];
                [followData addObject:siteFollow];
            }
        }
        dispatch_semaphore_signal(semaphore2);
    }];
    
    while (dispatch_semaphore_wait(semaphore2, DISPATCH_TIME_NOW)){
        [[NSRunLoop currentRunLoop]runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:10]];
    }
}

/**
 */
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath{
    Following* follow = [followData objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"followProfile" sender:follow.name];
}

/**
 */
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

/**
 */
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [followData count];
}

/**
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    /**
     Transparent tableView background
     */
    tableView.backgroundColor = [UIColor clearColor];
    /**
     Hide the scrollbar in the tableView
     */
    [tableView setShowsVerticalScrollIndicator:NO];
    
    /**
     Set needed objects
     */
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    Following* follow = [followData objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [[NSString stringWithFormat:@"%@", follow.name] uppercaseString];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"followProfile"]){
        NSString* name = (NSString*)sender;
        SiteProfileViewController* spvw = (SiteProfileViewController*)[segue destinationViewController];
        spvw.blogName = name;
    }
}

@end
