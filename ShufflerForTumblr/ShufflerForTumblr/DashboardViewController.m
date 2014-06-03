//
//  DashboardViewController.m
//  ShufflerForTumblr
//
//  Created by Adrian Zborowski on 09/05/14.
//  Copyright (c) 2014 Hogeschoool van Amsterdam. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "DashboardViewController.h"
#import "TMAPIClient.h"
#import "AudioPost.h"
#import "TimeConverter.h"

@interface DashboardViewController ()
@end

/**
 */
static const int limitNextPage = 5;
/**
 */
NSMutableArray* postData;
/**
 */
NSArray* tableData;

/**
 */
@implementation DashboardViewController

/**
 */
-(void)viewDidLoad{
    [super viewDidLoad];
    
    postData = (NSMutableArray<Post>*)[[NSMutableArray alloc] init];
    tableData = [[NSArray alloc] init];
    
    NSArray* paramsKeys = [[NSArray alloc] initWithObjects:@"limit", @"offset", @"type", nil];
    NSArray* paramsVals = [[NSArray alloc] initWithObjects:
                           [[NSString alloc] initWithFormat:@"%i", limitNextPage],
                           [[NSString alloc] initWithFormat:@"%i", _dashboardOffsetAudio],
                           @"audio",
                           nil];
    NSDictionary *paramsDict = [[NSDictionary alloc]initWithObjects:paramsVals forKeys:paramsKeys];
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    [[TMAPIClient sharedInstance]dashboard:paramsDict callback:^(id response, NSError *error){
        if(!error) {
            for(NSArray* post in [response valueForKeyPath:@"posts"]){
                AudioPost* postItem     = [[AudioPost alloc]init];
                postItem.album          = [post valueForKeyPath:@"album"];
                postItem.album_art      = [post valueForKeyPath:@"album_art"];
                postItem.artist         = [post valueForKeyPath:@"artist"];
                postItem.audio_type     = [post valueForKeyPath:@"audio_type"];
                postItem.audio_url      = [post valueForKeyPath:@"audio_url"];
                postItem.blogName       = [post valueForKeyPath:@"blog_name"];
                postItem.can_reply      = [post valueForKeyPath:@"can_reply"];
                postItem.caption        = [post valueForKeyPath:@"caption"];
                postItem.date           = [post valueForKeyPath:@"date"];
                postItem.playerEmbed    = [post valueForKeyPath:@"embed"];
                postItem.followed       = [post valueForKeyPath:@"followed"];
                postItem.format         = [post valueForKeyPath:@"format"];
                postItem.highlighted    = [post valueForKeyPath:@"highlighted"];
                postItem.ID             = [post valueForKeyPath:@"id"];
                postItem.liked          = [post valueForKeyPath:@"liked"];
                postItem.note_count     = [post valueForKeyPath:@"note_count"];
                postItem.playerEmbed    = [post valueForKeyPath:@"player"];
                postItem.plays          = [post valueForKeyPath:@"plays"];
                postItem.postURL        = [post valueForKeyPath:@"post_url"];
                postItem.reblogKey      = [post valueForKeyPath:@"reblog_key"];
                postItem.short_url      = [post valueForKeyPath:@"short_url"];
                postItem.slug           = [post valueForKeyPath:@"slug"];
                postItem.state          = [post valueForKeyPath:@"state"];
                postItem.tags           = [post valueForKeyPath:@"album"];
                postItem.postTimestamp  = [post valueForKeyPath:@"timestamp"];
                postItem.track_name     = [post valueForKeyPath:@"track_name"];
                postItem.type           = 0;
                [postData addObject:postItem];
            }
            //>> NSLog(@"%@", [post valueForKeyPath:@"artist"]);
            //NSArray* testArray = [response valueForKeyPath:@"posts"];
            //NSLog(@"%@", testArray[0]);
        }
        dispatch_semaphore_signal(semaphore);
    }];
    
    while (dispatch_semaphore_wait(semaphore, DISPATCH_TIME_NOW)){
        [[NSRunLoop currentRunLoop]runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:10]];
    }
    
    tableData = [NSArray arrayWithObjects:@"Egg Benedict", @"Mushroom Risotto", @"Full Breakfast", @"Hamburger", @"Ham and Egg Sandwich", @"Creme Brelee", @"White Chocolate Donut", @"Starbucks Coffee", @"Vegetable Curry", @"Instant Noodle with Egg", @"Noodle with BBQ Pork", @"Japanese Noodle with Pork", @"Green Tea", @"Thai Shrimp Cake", @"Angry Birds Cake", @"Ham and Cheese Panini", nil];
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Setup tableView

/**
 Number of sections in the tableview.
 */
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [postData count];
}

/**
 Number of cells within the sections in th tableview.
 In each section there is 1 cell because of the header en footer functionality in each section
 */
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

/**
 */
-(CGFloat)tableView:(UITableView *)aTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 220.0;
}

// Setup tableView
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/**
 Style and content of the cells.
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AudioPost* post = [postData objectAtIndex:indexPath.section];
    
    // [UIColor colorWithRed:44/255.0 green:71/255.0 blue:98/255.0 alpha:1.0]
    
    static NSString *cellIdentifier = @"dashCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    /// Cell background color
    [cell setBackgroundColor:[UIColor clearColor]];
    
    /// Selection color
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIImageView *cellBackView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 220)];
    cellBackView.backgroundColor = [UIColor clearColor];
    
//    cellBackView.image = [UIImage imageNamed:@"cellBackground.png"];
    
    cellBackView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:post.album_art]]];
    if(!cellBackView.image){
        cellBackView.image = [UIImage imageNamed:@"cellBackground.png"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", post.track_name];
    
    //cell.textColor = [UIColor whiteColor];
    
    cell.backgroundView = cellBackView;
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tabBarController setSelectedIndex:2];
}

/**
 */
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 42;
//}

/**
 */
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    AudioPost* post = [postData objectAtIndex:section];
    
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 42.0)];
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    headerLabel.backgroundColor = [UIColor whiteColor];
    headerLabel.opaque = NO;
    headerLabel.textColor = [UIColor blackColor];
    headerLabel.font = [UIFont boldSystemFontOfSize:12];
    headerLabel.frame = CGRectMake(0.0, 0.0, 320.0, 42.0);
    headerLabel.text = [NSString stringWithFormat:@"\t\t%@", post.blogName];
    [customView addSubview:headerLabel];
    
    //UIImageView *titleImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"placeholder.png"]];
    NSString* avatarUrl = [NSString stringWithFormat:@"api.tumblr.com/v2/blog/%@.tumblr.com/avatar", post.blogName];
    UIImage* avatarImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:avatarUrl]]];
    
    UIImageView *titleImage = [[UIImageView alloc] initWithImage:avatarImg];
    
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[post.postTimestamp doubleValue]];
    NSDate* currentDate = [NSDate date];
    NSString* timestampString = [TimeConverter stringForTimeIntervalSinceCreated:date serverTime:currentDate];
    NSLog(@"%@", timestampString);
    
    CGRect imageViewRect = CGRectMake(0.0,  0.0, 42.0 , 42.0);
    titleImage.frame = imageViewRect;
    [customView addSubview:titleImage];
    
    return customView;
}

/**
 */
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}

/**
 */
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 5.0)];
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    headerLabel.backgroundColor = [UIColor colorWithRed:44/255.0 green:71/255.0 blue:98/255.0 alpha:1.0];
    headerLabel.opaque = NO;
    [customView addSubview:headerLabel];
    
    return customView;
}

/**
 */
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.backgroundColor = [UIColor clearColor];
    cell.layer.backgroundColor = [[UIColor clearColor] CGColor];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.shadowColor = [UIColor blackColor];
    cell.textLabel.shadowOffset = CGSizeMake(1.0, 1.0);
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - Navigation
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSLog(@"DashboardViewController -> prepareForSegue");
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

@end
