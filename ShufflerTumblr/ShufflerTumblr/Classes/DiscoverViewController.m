//
//  DiscoverViewController.m
//  ShufflerTumblr
//
//  Created by Casper Eekhof on 10-06-13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import "DiscoverViewController.h"
#import "Blog.h"
#import "BlogPlaylistViewController.h"

@interface DiscoverViewController ()

@end

@implementation DiscoverViewController

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
    tableObjects = [[NSMutableArray alloc] init];
    
    // Show the logo of shuffler up in the top
    UIImageView* logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shumblrlogo"]];
    logo.frame= CGRectMake(0,0,20,25);
     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:logo];

    
    
    
    // The featured blogs
    NSArray *blogURLS = [[NSArray alloc] initWithObjects:@"http://maxabelson.com/",  @"http://breakupyourband.tumblr.com/", @"http://traviesblog.com/", @"http://earsofthebeholder.com/", @"http://petewentz.com/", @"http://mvmvmv.tumblr.com/", nil];
    
    // load the featured blogs
    int index = 0;
    
    for(NSString *blogURL in blogURLS){
        Blog *tmpBlog = [[Blog alloc] initWithURL: blogURL];
        [tmpBlog getInfo:^(id<Info> info, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                BlogInfo * blogInfo = info;
                NSString * capitalizedName = [blogInfo.name uppercaseString];
                
                [tableText addObject: capitalizedName];
                if ([blogInfo image]) {
                    [tableimages addObject:[blogInfo image]];
                } else {
                    [tableimages addObject: [UIImage imageNamed:@"followed_ico.png"]];
                }
                
                [_tableView reloadData];
                [tableObjects addObject: tmpBlog];
            });
        }];
        index++;
    }
        _topMessageLabel.font = [UIFont fontWithName:@"BrandonGrotesque-Bold" size:22];
}


- (void) viewDidAppear:(BOOL)animated {
    self.navigationController.navigationBar.topItem.title = @"Discover";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma UITableView delegates
-(void) tableView:(UITableView *) tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    chosenRow = indexPath.row;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    BlogPlaylistViewController *blogVC = [storyboard instantiateViewControllerWithIdentifier:@"BlogPlaylist"];
    [blogVC setBlog: [tableObjects objectAtIndex: chosenRow]];
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
    cell.textLabel.font = [UIFont fontWithName:@"BrandonGrotesque-Bold" size:15];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.imageView.image = [tableimages objectAtIndex: indexPath.row];
    cell.backgroundView = [[UIImageView alloc]initWithImage: [UIImage imageNamed:@"Blogfront.png"]];
    return cell;
}

// Load the new page (still needs implemntation by ShufflerFM)
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    double cal = (_tableView.contentOffset.y / _tableView.rowHeight) ;
    if (cal >= [tableObjects count] - 4){
        // Load new pages
    }
}

- (void)viewDidUnload {
    [self setTableView:nil];
    [self setTopMessageLabel:nil];
    [super viewDidUnload];
}
@end
