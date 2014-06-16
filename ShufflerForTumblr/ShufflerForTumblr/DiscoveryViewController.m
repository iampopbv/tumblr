//
//  DiscoveryViewController.m
//  ShufflerForTumblr
//
//  Created by Adrian Zborowski on 06/06/14.
//  Copyright (c) 2014 Hogeschoool van Amsterdam. All rights reserved.
//

#import "DiscoveryViewController.h"
#import "TMAPIClient.h"
#import "AudioPost.h"
#import "TimeConverter.h"
#import "AppSession.h"

@interface DiscoveryViewController ()
@end

/**
 */
//NSMutableArray* postData;
/**
 */
static NSString* cellIdentifier = @"discCell";
/**
 */
static const float sectionHeaderSize[4] = {0.0, 0.0, 320.0, 56.0};

@implementation DiscoveryViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    _tableView.delegate = self;
//    postData = (NSMutableArray<Post>*)[[NSMutableArray alloc] init];
    
    [[AppSession sharedInstance]loadDiscoveryPosts:^(NSArray<Post>* posts){
//        [postData addObjectsFromArray:posts];
        
        [[AppSession sharedInstance]setDiscoveryPosts:[[NSMutableArray alloc] initWithArray:posts]];
        
        [[self tableView] reloadData];
    }];
}

/**
 */
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [[AppSession sharedInstance]setCurrentlyPlayingIndex:(int)indexPath.section];
    
    [[AppSession sharedInstance]setCurrentlyPlayingPostLocation:3];
    
    [self.tabBarController setSelectedIndex:2];
}

/**
 */
- (void)scrollViewDidScroll:(UIScrollView *)aScrollView {
    
    CGPoint offset = aScrollView.contentOffset;
    
    if(offset.y <= -100) {
        [[AppSession sharedInstance]reloadDiscoveryPosts];
        
        [[self tableView] reloadData];
    }
}

/**
 */
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    float tableCount = [[[AppSession sharedInstance]discoveryPosts] count];
    float tableLocation = (_tableView.contentOffset.y / _tableView.rowHeight);
    float loadPostsAfter = (tableCount - 3);
    
    if(tableLocation >= loadPostsAfter){
        [[AppSession sharedInstance]addDiscoveryPosts];
        
        [[self tableView] reloadData];
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Setup tableView

/**
 Number of sections in the tableview.
 */
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return [postData count];
    return [[[AppSession sharedInstance]discoveryPosts] count];
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
//    AudioPost* post = [postData objectAtIndex:indexPath.section];
    AudioPost* post = [[[AppSession sharedInstance]discoveryPosts] objectAtIndex:indexPath.section];
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
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ NOTES", post.note_count];
    
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
    
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.shadowColor = [UIColor blackColor];
    cell.detailTextLabel.shadowOffset = CGSizeMake(1.0, 1.0);
    
    cell.layer.cornerRadius = 8;
    cell.layer.masksToBounds = YES;
}

/**
 */
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    AudioPost* post = [postData objectAtIndex:section];
    AudioPost* post = [[[AppSession sharedInstance]discoveryPosts] objectAtIndex:section];
    
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
    headerLabel.numberOfLines = 0;
    headerLabel.backgroundColor = [UIColor whiteColor];
    headerLabel.opaque = NO;
    headerLabel.textColor = [UIColor blackColor];
    headerLabel.font = [UIFont boldSystemFontOfSize:12];
    headerLabel.frame = CGRectMake(sectionHeaderSize[0], sectionHeaderSize[1], sectionHeaderSize[2], sectionHeaderSize[3]);
    headerLabel.text = [NSString stringWithFormat:@"\t\t%@\n\t\t%@", post.blogName, timestampString];
    
    UIImageView* avatarImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    [[TMAPIClient sharedInstance]avatar:@"zborowa" size:64 callback:^(id response, NSError *error) {
        avatarImage.image = [UIImage imageWithData:response];
    }];
    [avatarImage addSubview:headerLabel];
    
    //UIImageView *titleImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"placeholder.png"]];
    NSString* avatarUrl = [NSString stringWithFormat:@"api.tumblr.com/v2/blog/%@.tumblr.com/avatar", post.blogName];
    UIImage* avatarImg = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:avatarUrl]]];
    UIImageView *titleImage = [[UIImageView alloc] initWithImage:avatarImg];
    CGRect imageViewRect = CGRectMake(0.0,  0.0, 42.0 , 42.0);
    titleImage.frame = imageViewRect;
    
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

/**
 */
- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

/**
 */
#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{}

@end
