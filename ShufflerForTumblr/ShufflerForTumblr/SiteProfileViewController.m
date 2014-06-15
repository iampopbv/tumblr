//
//  SiteProfileViewController.m
//  ShufflerForTumblr
//
//  Created by Adrian Zborowski on 05/06/14.
//  Copyright (c) 2014 Hogeschoool van Amsterdam. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "SiteProfileViewController.h"
#import "TMAPIClient.h"
#import "AppSession.h"
#import "AudioPost.h"
#import "TimeConverter.h"

@interface SiteProfileViewController ()
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@end

@implementation SiteProfileViewController

/**
 */
static NSString* cellIdentifier = @"siteProfileCell";
/**
 */
static const float sectionHeaderSize[4] = {0.0, 0.0, 320.0, 56.0};
/**
 */
UIView* profileView;

/**
 */
- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = [[NSString stringWithFormat:@"%@", _blogName] uppercaseString];
    
    /**
     Header view for the profile information
     */
    profileView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 227)];
    profileView.backgroundColor = [UIColor colorWithRed:26/255.0 green:42/255.0 blue:58/255.0 alpha:1.0];
    
    /**
     Center the avatar values
     */
    float avatarViewMid = ((profileView.frame.size.width / 2)-(92 / 2));
    /**
     Center the description webview
     */
    float descriptionViewMid = ((profileView.frame.size.width / 2)-(184 / 2));
    
    /**
     Get the avatar
     */
    [[TMAPIClient sharedInstance]avatar:_blogName size:128 callback:^(id response, NSError *error) {
        UIImage* avatarImage = [UIImage imageWithData:response];
        UIImageView* headerImage = [[UIImageView alloc] initWithImage:avatarImage];
        headerImage.frame = CGRectMake(avatarViewMid, 16.0, 92.0, 92.0);
        headerImage.layer.cornerRadius = 46;
        headerImage.layer.masksToBounds = YES;
        [profileView addSubview:headerImage];
    }];
    
    /**
     Get the blog followers
     */
    NSArray * paramsKeys = [[NSArray alloc] initWithObjects:@"limit", nil];
    NSArray * paramsVals = [[NSArray alloc] initWithObjects:[[NSString alloc] initWithFormat:@"%i", 20], nil];
    NSDictionary *paramsDict = [[NSDictionary alloc] initWithObjects: paramsVals forKeys: paramsKeys];
    [[TMAPIClient sharedInstance]followers:_blogName parameters:paramsDict callback:^(id response, NSError *error) {
        
//        NSLog(@"%@", _blogName);
//        NSLog(@"%@", response);
        
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 250, 64)];
//        [label setText:[response valueForKeyPath:@"total_users"]];
//        [profileView addSubview:label];
    }];
    
    [[TMAPIClient sharedInstance]blogInfo:_blogName callback:^(id response, NSError *error) {
        UIWebView* webView = [[UIWebView alloc]initWithFrame:CGRectMake(descriptionViewMid, 128, 184, 95)];
        [webView delegate];
        [webView loadHTMLString:[NSString stringWithFormat:@"\
                                 <html>\
                                 <head>\
                                 <style>\
                                    @import url(http://fonts.googleapis.com/css?family=Ubuntu);\
                                    body{\
                                        font-size: 12px;\
                                        font-family: 'Ubuntu', sans-serif;\
                                        color: #FFFFFF;\
                                        background-color: #1A2A3A;\
                                        color: #FFFFFF;\
                                    }\
                                    img{\
                                        display: none;\
                                        visibility: hidden;\
                                    }\
                                    a{\
                                        pointer-events: none;\
                                        cursor: default;\
                                        color: #FFFFFF;\
                                        text-decoration: none;\
                                    }\
                                 </style>\
                                 </head>\
                                 <body>\
                                 %@\
                                 </body>\
                                 </html>", [response valueForKeyPath:@"blog.description"]] baseURL:nil];
        [webView setBackgroundColor:[UIColor clearColor]];
        [webView setOpaque:NO];
        [profileView addSubview:webView];
    }];
    
    /**
     TableView
     */
    [_tableView delegate];
    [_tableView dataSource];
    float tableViewMid = ((profileView.frame.size.width / 2) - (280 / 2));
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(tableViewMid, 240, 280, 600) style:UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.scrollEnabled = NO;
    [[AppSession sharedInstance]loadSiteProfilePosts:^(NSArray<Post>* posts){
        
        [[AppSession sharedInstance]setSiteProfilePosts:[[NSMutableArray alloc] initWithArray:posts]];
        
        [[self tableView] reloadData];
        NSLog(@"%f", self.tableView.frame.size.height);
        
        CGRect frame = self.tableView.frame;
        frame.size.height = self.tableView.contentSize.height;
        self.tableView.frame = frame;
        NSLog(@"%f", self.tableView.frame.size.height);
        
        /**
         Scroll view content
         */
        float scrollViewContentHeight = (profileView.frame.size.height + self.tableView.frame.size.height);
        self.scrollView.bounces = YES;
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, scrollViewContentHeight);
    } blog:_blogName];
    
    [self.scrollView addSubview:profileView];
    [self.scrollView addSubview:self.tableView];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:NO];
    
    [[AppSession sharedInstance]setSiteProfileAudioPostOffset:0];
}

/**
 */
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [[AppSession sharedInstance]setCurrentlyPlayingIndex:(int)indexPath.section];
    
    [[AppSession sharedInstance]setCurrentlyPlayingPostLocation:1];
    
    [self.tabBarController setSelectedIndex:2];
}

/**
 */
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    float scrollLocation = ((self.scrollView.contentOffset.y - profileView.frame.size.height));
    float loadPostsAfter = (self.tableView.contentSize.height - 900);
    
    if(scrollLocation >= loadPostsAfter){
        [[AppSession sharedInstance]addSiteProfilePosts:_blogName];
        
        [[self tableView] reloadData];
        CGRect tableFrame = [self.tableView frame];
        tableFrame.size.height = self.tableView.contentSize.height;
        [self.tableView setFrame:tableFrame];
        
        float scrollViewContentHeight = (profileView.frame.size.height + self.tableView.contentSize.height);
        [[self scrollView] setContentSize:CGSizeMake(self.scrollView.frame.size.width, scrollViewContentHeight)];
        [[self scrollView] setNeedsDisplay];
    }
}

/**
 */
- (void)scrollViewDidScroll:(UIScrollView *)aScrollView {
    
    CGPoint offset = aScrollView.contentOffset;
    
    if(offset.y <= -100) {
        [[AppSession sharedInstance]reloadSiteProfilePosts:_blogName];
        
        [[self tableView] reloadData];
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Setup tableView

/**
 Number of sections in the tableview.
 */
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[[AppSession sharedInstance]siteProfilePosts] count];
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
    AudioPost* post = [[[AppSession sharedInstance]siteProfilePosts] objectAtIndex:indexPath.section];
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
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
    AudioPost* post = [[[AppSession sharedInstance]siteProfilePosts] objectAtIndex:section];
    
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(sectionHeaderSize[0], sectionHeaderSize[1], sectionHeaderSize[2], sectionHeaderSize[3])];
    
    /**
     Calculate the time
     */
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[post.postTimestamp doubleValue]];
    NSDate* currentDate = [NSDate date];
    NSString* timestampString = [TimeConverter stringForTimeIntervalSinceCreated:date serverTime:currentDate];
    
    /**
     Style the header label
     */
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    headerLabel.numberOfLines = 0;
    headerLabel.backgroundColor = [UIColor whiteColor];
    headerLabel.opaque = NO;
    headerLabel.textColor = [UIColor blackColor];
    headerLabel.font = [UIFont boldSystemFontOfSize:12];
    headerLabel.frame = CGRectMake(sectionHeaderSize[0], sectionHeaderSize[1], sectionHeaderSize[2], sectionHeaderSize[3]);
    headerLabel.text = [NSString stringWithFormat:@"\t\t%@\n\t\t%@", post.blogName, timestampString];
    
    /**
     Set the header image
     */
    [[TMAPIClient sharedInstance]avatar:post.blogName size:64 callback:^(id response, NSError *error) {
        UIImage* avatarImage = [UIImage imageWithData:response];
        UIImageView* headerImage = [[UIImageView alloc] initWithImage:avatarImage];
        headerImage.frame = CGRectMake(6.0, 6.0, 44.0, 44.0);
        headerImage.layer.cornerRadius = 22;
        headerImage.layer.masksToBounds = YES;
        [customView addSubview:headerImage];
    }];
    
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
