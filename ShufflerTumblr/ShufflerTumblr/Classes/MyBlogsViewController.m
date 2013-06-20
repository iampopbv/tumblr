//
//  MyBlogsViewController.m
//  ShufflerTumblr
//
//  Created by Casper Eekhof on 26-05-13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import "MyBlogsViewController.h"
#import "User.h"
#import "Blog.h"
#import "TMAPIClient.h"
#import "BlogPlaylistViewController.h"
#import "Player.h"


@interface MyBlogsViewController ()

@end

@implementation MyBlogsViewController

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
    // Do any additional setup after loading the view.
    
    // Show the shuffler logo
    UIImageView* logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shumblrlogo.png"]];
    logo.frame= CGRectMake(0,0,20,25);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:logo];
    
    // Init the table data holders
    tableText = [[NSMutableArray alloc] init];
    tableimages = [[NSMutableArray alloc] init];
    tableObjects = (NSMutableArray<Post>*)[[NSMutableArray alloc] init];
    
    // Download the users info
    [[TMAPIClient sharedInstance] userInfo:^(id response, NSError *error) {
        tableObjects = (NSMutableArray<Info>*)[[NSMutableArray alloc] init];
        
        NSDictionary *blogsDict = [[response objectForKey: @"user"] objectForKey:@"blogs"];
        for (NSDictionary *blogDict in blogsDict) {
            BlogInfo *tmpBlog = [[BlogInfo alloc] initWithBlogDictionary: blogDict];
            [tableObjects addObject: tmpBlog];
            [tableText addObject: [tmpBlog name]];
            [tableimages addObject: [tmpBlog image]];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableview reloadData];
        });
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated {
    self.navigationController.navigationBar.topItem.title = @"My Blogs";

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

- (void) openCurrentTrack {
    // code for opening the current track
    
    SinglePostViewController *vc = [[SinglePostViewController alloc] init];
    UIView *postView = [[[NSBundle mainBundle] loadNibNamed:@"PostView" owner: vc options:nil] objectAtIndex: 0];
    [vc.view addSubview: postView];
    
    vc.post = [[[Player sharedInstance] playlist] objectAtIndex: [[Player sharedInstance] playListCounter]];
    [vc setPostView: postView];
    [self.navigationController pushViewController: vc animated: YES];
}

#pragma UITableView Delegates
-(void) tableView:(UITableView *) tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    chosenRow = indexPath.row;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    BlogInfo *selectedBlogInfo = [tableObjects objectAtIndex:chosenRow];
    Blog *blog = [[Blog alloc] initWithURL: [[selectedBlogInfo blogURL] absoluteString]];
    [blog setBlogInfo: selectedBlogInfo];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    BlogPlaylistViewController *blogVC = [storyboard instantiateViewControllerWithIdentifier:@"BlogPlaylist"];
    [blogVC setBlog: blog];
    [self.navigationController pushViewController: blogVC animated:YES];
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

- (void)viewDidUnload {
    [self setTableview:nil];
    [super viewDidUnload];
}

@end
