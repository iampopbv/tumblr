//
//  DashBoardViewController.m
//  ShufflerTumblr
//
//  Created by Casper Eekhof on 26-05-13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import "DashBoardViewController.h"
#import "User.h"
#import "Audio.h"
#import "Player.h"
#import "SinglePostViewController.h"
#import "DirectURLGetter.h"

@interface DashBoardViewController ()

@end

@implementation DashBoardViewController

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
    
    // init the table data holders
    tableText = [[NSMutableArray alloc] init];
    tableimages = [[NSMutableArray alloc] init];
    tableObjects = (NSMutableArray<Post>*)[[NSMutableArray alloc] init];
    
    [self setupUI];
    [self loadNextPage];
    
}

- (void) setupUI {
    _headLabel.font = [UIFont fontWithName:@"BrandonGrotesque-Bold" size:22];
    
    // If there is something playing make a button to link to it
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
    
    
    NSDictionary *titleTextAttributesDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                             [UIColor whiteColor], NSForegroundColorAttributeName,
                                             [UIColor whiteColor], NSShadowAttributeName,
                                             [NSValue valueWithUIOffset:UIOffsetMake(0, 1)], NSShadowAttributeName,
                                             [UIFont fontWithName:@"BrandonGrotesque-Bold" size:23.0], NSFontAttributeName,
                                             nil];
    [self.navigationController.navigationBar setTitleTextAttributes: titleTextAttributesDict];
}

-(void)loadNextPage {
    // Get the dashboard and display the first 5 items
    [[User sharedInstance] getNextPageDashboard:^(NSArray<Post> * posts) {
        
        [[DirectURLGetter sharedInstance] getDirectURLS: posts withBlock:^(id posts) {
            
            [tableObjects addObjectsFromArray: posts];
            
            for (id<Post> post in posts) {
                Audio * tmp = (Audio*)post;
                if([post type] == AUDIO){
                    NSString *title;
                    
                    //remove the '{}' from the attributed string
                    NSString *trackName = [[tmp trackName] string];
                    if([tmp artist] != nil)
                        title = [[NSString alloc] initWithFormat: @"%@ - %@", [tmp artist], trackName];
                    else if([tmp trackName] != nil)
                        title = [[NSString alloc] initWithFormat: @"%@ - %@", [tmp blogName], trackName];
                    else {
                        title = [tmp blogName];
                    }
                    [tableText addObject: title];
                    
                    
                    if([tmp albumArt] != nil) {
                        [tableimages addObject: [tmp albumArt]];
                    } else {
                        [tableimages addObject: [UIImage imageNamed:@"audio_ico"]];
                    }
                } else {
                    [tableText addObject: [post blogName]];
                    [tableimages addObject: [UIImage imageNamed:@"play_ico"]];
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [_tableview reloadData];
            });
        }];
        
    }];
}

-(void)viewDidAppear:(BOOL)animated {
    self.navigationController.navigationBar.topItem.title = @"Dashboard";
    
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
    chosenRow = (int)indexPath.row;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
    [[Player sharedInstance] clear];
    // Set the playlist starting from the selected row
    [[Player sharedInstance] setPlaylist: (NSMutableArray<Post>*) [[NSMutableArray alloc] initWithArray: [tableObjects subarrayWithRange: NSMakeRange( chosenRow, [tableObjects count] - chosenRow)]]];
    
    SinglePostViewController *vc = [[SinglePostViewController alloc] init];
    UIView *postView = [[[NSBundle mainBundle] loadNibNamed:@"PostView" owner: vc options:nil] objectAtIndex: 0];
    [vc.view addSubview: postView];
    
    vc.post = [tableObjects objectAtIndex: chosenRow];
    [vc setPostView: postView];
    [self.navigationController pushViewController: vc animated: YES];
}

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

// Lazyloading; when at the end, load a new dashboard page
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    double cal = (_tableview.contentOffset.y / _tableview.rowHeight) ;
    if (cal >= [tableObjects count] - 4){ // - 4 because we see 5 cells, when we only see 4 because we dragged down, we load the next.
        [self loadNextPage];
    }
}


- (void)viewDidUnload {
    [self setTableview:nil];
    [self setHeadLabel:nil];
    [super viewDidUnload];
}

@end
