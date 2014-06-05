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
#import "User.h"
#import "Audio.h"

@interface DashboardViewController ()
@property (nonatomic,retain) UIRefreshControl *refreshControl;
@end

/**
 */
static const int limitNextPage = 8;
/**
 */
NSMutableArray* postData;
/**
 */
static NSString* cellIdentifier = @"dashCell";
/**
 */
static const float sectionHeaderSize[4] = {0.0, 0.0, 320.0, 56.0};

/**
 */
@implementation DashboardViewController

/**
 */
-(void)viewDidLoad{
    [super viewDidLoad];
    postData = (NSMutableArray<Post>*)[[NSMutableArray alloc] init];
    
    [self loadNewPosts];
}

-(void)loadNewPosts{
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
        }
        dispatch_semaphore_signal(semaphore);
    }];
    
    while (dispatch_semaphore_wait(semaphore, DISPATCH_TIME_NOW)){
        [[NSRunLoop currentRunLoop]runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:10]];
    }
}

/**
 */
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tabBarController setSelectedIndex:2];
}

- (void)scrollViewDidScroll:(UIScrollView *)aScrollView {
    CGPoint offset = aScrollView.contentOffset;
    CGRect bounds = aScrollView.bounds;
    CGSize size = aScrollView.contentSize;
    UIEdgeInsets inset = aScrollView.contentInset;
    float y = offset.y + bounds.size.height - inset.bottom;
    float h = size.height;
    float reload_distance = -100;
    
    if(offset.y <= -100) {
        NSLog(@"load more rows: %g", offset.y);
    }
    
    if(y > (h + reload_distance)) {
        NSLog(@"load more rows");
    }
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
    return 224.0;
}

/**
 */
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 48;
}

/**
 */
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 8;
}

/**
 Style and content of the cells.
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
    AudioPost* post = [postData objectAtIndex:indexPath.section];
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    /**
     Configure cell background
     */
    UIImageView *cellBackView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 0, 320, 220)];
    cellBackView.backgroundColor = [UIColor clearColor];
    cellBackView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:post.album_art]]];
    if(!cellBackView.image) cellBackView.image = [UIImage imageNamed:@"cellBackground.png"];
    
    /**
     Configure cell
     */
    cell.backgroundView = cellBackView;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [NSString stringWithFormat:@"%@", post.track_name];
    
    return cell;
}

/**
 Style the post
 */
-(void)tableView:(UITableView*)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.backgroundColor = [UIColor clearColor];
    cell.layer.backgroundColor = [[UIColor clearColor] CGColor];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.shadowColor = [UIColor blackColor];
    cell.textLabel.shadowOffset = CGSizeMake(1.0, 1.0);
    
    cell.layer.cornerRadius = 8;
    cell.layer.masksToBounds = YES;
}

/**
 */
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    AudioPost* post = [postData objectAtIndex:section];
    
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(sectionHeaderSize[0], sectionHeaderSize[1], sectionHeaderSize[2], sectionHeaderSize[3])];
    
    /**
     Calculate the time
     */
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[post.postTimestamp doubleValue]];
    NSDate* currentDate = [NSDate date];
    NSString* timestampString = [TimeConverter stringForTimeIntervalSinceCreated:date serverTime:currentDate];
    
    /**
     Style the header
     */
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    headerLabel.backgroundColor = [UIColor whiteColor];
    headerLabel.opaque = NO;
    headerLabel.textColor = [UIColor blackColor];
    headerLabel.font = [UIFont boldSystemFontOfSize:12];
    headerLabel.frame = CGRectMake(sectionHeaderSize[0], sectionHeaderSize[1], sectionHeaderSize[2], sectionHeaderSize[3]);
    headerLabel.text = [NSString stringWithFormat:@"\t\t%@ %@", post.blogName, timestampString];
    
    //UIImageView *titleImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"placeholder.png"]];
    NSString* avatarUrl = [NSString stringWithFormat:@"api.tumblr.com/v2/blog/%@.tumblr.com/avatar", post.blogName];
    UIImage* avatarImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:avatarUrl]]];
    UIImageView *titleImage = [[UIImageView alloc] initWithImage:avatarImg];
    CGRect imageViewRect = CGRectMake(0.0,  0.0, 42.0 , 42.0);
    titleImage.frame = imageViewRect;
    
    [customView addSubview:titleImage];
    [customView addSubview:headerLabel];
    
    return customView;
}

/**
 */
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 5.0)];
    customView.backgroundColor = [UIColor colorWithRed:44/255.0 green:71/255.0 blue:98/255.0 alpha:1.0];
    customView.opaque = NO;
    
    return customView;
}

// Setup tableView
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#pragma mark - Navigation
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSLog(@"DashboardViewController -> prepareForSegue");
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

@end
