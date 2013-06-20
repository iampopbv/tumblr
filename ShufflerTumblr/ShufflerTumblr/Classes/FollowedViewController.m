//
//  FollowedViewController.m
//  ShufflerTumblr
//
//  Created by Casper Eekhof on 26-05-13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import "FollowedViewController.h"
#import "User.h"
#import "TMAPIClient.h"
#import "Player.h"
#import "BlogPlaylistViewController.h"

@interface FollowedViewController ()

@end

@implementation FollowedViewController

@synthesize tableText;
@synthesize chosenRow;
@synthesize tableimages;
@synthesize tableObjects;

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
    // show th ShufflerFM logo
    UIImageView* logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shumblrlogo.png"]];
    logo.frame= CGRectMake(0,0,20,25);
	 self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:logo];
    
    
    // init the table data holders
    tableText = [[NSMutableArray alloc] init];
    tableimages = [[NSMutableArray alloc] init];
    tableObjects = [[NSMutableArray alloc] init];
    
    // Get the next following page
    [[User sharedInstance] getNextFollowingPage:^(NSArray<Info> *blogs) {
        for (BlogInfo *blog in blogs) {
            [tableObjects addObject: blog];
            [tableText addObject: [blog name]];
            [tableimages addObject: [blog image]];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableview reloadData];
        });
        
    }];
    // If playing; show the post
    if([[Player sharedInstance] playing]) {
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage * image = [UIImage imageNamed:@"topbar_nowplaying"];
        [button setBackgroundImage:image forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"topbar_nowplaying"] forState:UIControlStateHighlighted];
        button.frame = CGRectMake(0, 0, 65, 37);
        [button addTarget:self action:@selector(openCurrentTrack) forControlEvents:UIControlEventTouchUpInside];
        button.accessibilityLabel = @"Now playing";
        button.tag = 123131;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    }

}

-(void)viewDidAppear:(BOOL)animated {
    self.navigationController.navigationBar.topItem.title = @"Followed";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) openCurrentTrack {
    // code for opening the current track
    
    SinglePostViewController *vc = [[SinglePostViewController alloc] init];
    UIView *postView = [[[NSBundle mainBundle] loadNibNamed:@"PostView" owner: vc options:nil] objectAtIndex: 0];
    [vc.view addSubview: postView];
    
    vc.post = [[[Player sharedInstance] playlist] objectAtIndex: [[Player sharedInstance] playListCounter]];
    [vc setPostView: postView];
    [self.navigationController pushViewController: vc animated: YES];
}

#pragma UITableView delegates
-(void) tableView:(UITableView *) tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    chosenRow = indexPath.row;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    BlogInfo *selectedBlogInfo = [tableObjects objectAtIndex:chosenRow];
    Blog *blog = [[Blog alloc] initWithURL: [[selectedBlogInfo blogURL] absoluteString]];
    [blog setBlogInfo: selectedBlogInfo];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    BlogPlaylistViewController *blogVC = [storyboard instantiateViewControllerWithIdentifier:@"BlogPlaylist"];
    [blogVC setBlog: blog];
    [self.navigationController pushViewController: blogVC animated:YES];}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableText count];
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    UIView *bgColorView = [[UIView alloc] init];
    [bgColorView setBackgroundColor:[UIColor blackColor]];
    cell.textLabel.text = [tableText objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:@"BrandonGrotesque-Bold" size: 20];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.imageView.image = [tableimages objectAtIndex: indexPath.row];
    cell.backgroundView = [[UIImageView alloc]initWithImage: [UIImage imageNamed:@"Blogfront.png"]];
    return cell;
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    double cal = (_tableview.contentOffset.y / _tableview.rowHeight) ;
    if (cal >= [tableObjects count] - 4){
        [[User sharedInstance] getNextPageDashboard:^(NSArray<Post> * posts) {
            [[User sharedInstance] getNextFollowingPage:^(NSArray<Info> *blogs) {
                for (BlogInfo *blog in blogs) {
                    [tableObjects addObject: blog];
                    [tableText addObject: [blog name]];
                    [tableimages addObject: [blog image]];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_tableview reloadData];
                });
            }];
        }];
    }
}

- (void)viewDidUnload {
    [self setTableview:nil];
    [super viewDidUnload];
}
@end
