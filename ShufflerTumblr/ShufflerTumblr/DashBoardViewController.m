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
#import "SinglePostViewController.h"

@interface DashBoardViewController ()

@end

@implementation DashBoardViewController

@synthesize blogdata;
@synthesize tabledata;
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
    tabledata = [[NSMutableArray alloc] init];
    tableimages = [[NSMutableArray alloc] init];
    blogdata = [[NSMutableArray alloc] init];
    tableObjects = (NSMutableArray<Post>*)[[NSMutableArray alloc] init];
	// Do any additional setup after loading the view.
    
    _headLabel.font = [UIFont fontWithName:@"BrandonGrotesque-Bold" size:22];
    
    // if([...isPlaying]) {
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage * image = [UIImage imageNamed:@"topbar_nowplaying"];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"topbar_nowplaying"] forState:UIControlStateHighlighted];
    button.frame = CGRectMake(0, 0, 65, 37);
    [button addTarget:self action:@selector(openCurrentTrack) forControlEvents:UIControlEventTouchUpInside];
    button.accessibilityLabel = @"Now playing";
    button.tag = 123131;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    // }
    
    
    NSDictionary *titleTextAttributesDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                             [UIColor whiteColor], UITextAttributeTextColor,
                                             [UIColor whiteColor], UITextAttributeTextShadowColor,
                                             [NSValue valueWithUIOffset:UIOffsetMake(0, 1)], UITextAttributeTextShadowOffset,
                                             [UIFont fontWithName:@"BrandonGrotesque-Bold" size:23.0], UITextAttributeFont,
                                             nil];
    [self.navigationController.navigationBar setTitleTextAttributes: titleTextAttributesDict];
    
    
    
    
    [[User sharedInstance] getNextPageDashboard:^(NSArray<Post> * posts) {
        [tableObjects addObjectsFromArray: posts];
        
        for (id<Post> post in posts) {
            [tabledata addObject: [post blogName]];
            Audio * tmp = (Audio*)post;
            if([post type] == AUDIO && [tmp albumArt] != nil){
                [tableimages addObject: [tmp albumArt]];
            } else {
                [tableimages addObject: [UIImage imageNamed:@"play_ico"]];
            }
        }
        [_tableview reloadData];
    }];
}

-(void)viewDidAppear:(BOOL)animated {
    self.navigationController.navigationBar.topItem.title = @"Dashboard";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

#pragma UITableView delegates
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSString *segueName = [segue identifier];
    if([segueName isEqualToString: @"dashboard_segue"]){
        // Place the post in a new view.
        SinglePostViewController *tmp = [segue destinationViewController];
        tmp.post = [tableObjects objectAtIndex: chosenRow];
    }
}

-(void) tableView:(UITableView *) tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    chosenRow = indexPath.row;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"dashboard_segue" sender:self];
    
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tabledata count];
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    cell.textLabel.text = [tabledata objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:@"BrandonGrotesque-Bold" size: 20];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.imageView.image = [tableimages objectAtIndex: indexPath.row];
    cell.backgroundView = [[UIImageView alloc]initWithImage: [UIImage imageNamed:@"Blogfront.png"]];
    return cell;
}


- (void)viewDidUnload {
    [self setTableview:nil];
    [self setHeadLabel:nil];
    [super viewDidUnload];
}
@end
