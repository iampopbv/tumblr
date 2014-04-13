//
//  FavoriteViewController.m
//  ShufflerTumblr
//
//  Created by Casper Eekhof on 26-05-13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import "FavoriteViewController.h"
#import "SinglePostViewController.h"
#import "DirectURLGetter.h"
#import "Player.h"

@interface FavoriteViewController ()

@end

@implementation FavoriteViewController

@synthesize chosenRow;
@synthesize tableText;
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
    
    tableObjects = [[NSMutableArray alloc] init];
    
    // Logo display
    _textfavorite.font = [UIFont fontWithName:@"BrandonGrotesque-Bold" size:22];
    UIImageView* logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shumblrlogo.png"]];
    logo.frame= CGRectMake(0,0,20,25);
     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:logo];
    
    
    
    // Download the favorites
    [tableText removeAllObjects];
    tableText = [NSMutableArray arrayWithArray: [[Favourites sharedManager] getFavourites]];
    [_tableView reloadData];
    [[TMAPIClient sharedInstance] likes: nil callback:^(id response, NSError *error) {
        NSArray *tempArray = [response objectForKey:@"liked_posts"];
        for(int i = 0;i<[tempArray count];i++) {
            NSString *type = [[tempArray objectAtIndex:i] objectForKey:@"type"];
            id<Post> object;
            if ([type isEqual:@"video"]) {
                object = [[Video alloc] initWithDictionary: [tempArray objectAtIndex:i]];
            }
            else if([type isEqual:@"audio"]) {
                object = [[Audio alloc] initWithDictionary: [tempArray objectAtIndex:i]];
            } else {
                continue;
            }
            [tableObjects addObject: object];
        }
        
        [[DirectURLGetter sharedInstance] getDirectURLS: (NSArray<Post>*)tableObjects withBlock:^(id posts) {
            [tableObjects removeAllObjects];
            [tableObjects addObjectsFromArray: posts];
            for (id<Post> post in posts) {
                [tableText addObject: post];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [_tableView reloadData];
            });
        }];
    }];

}

- (void)viewDidAppear:(BOOL)animated {
    
    self.navigationController.navigationBar.topItem.title = @"Favorite";
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


#pragma UITableView delegate object
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableText count];
}

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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    UIView *bgColorView = [[UIView alloc] init];
    [bgColorView setBackgroundColor:[UIColor blackColor]];
    cell.textLabel.text = [[tableText objectAtIndex:indexPath.row] getListName];
    if ([[tableText objectAtIndex: indexPath.row] getType] == AUDIO && [[tableText objectAtIndex:indexPath.row] albumArt] != nil) {
        cell.imageView.image = [[tableText objectAtIndex:indexPath.row] albumArt];
    } else {
        cell.imageView.image = [UIImage imageNamed:@"play_ico"];
    }
    cell.backgroundView = [[UIImageView alloc]initWithImage: [UIImage imageNamed:@"Blogfront.png"]];
    NSLog(@"Created new cell with text: %@" , cell.textLabel.text);
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    //_favouriteData = nil;
}

- (void)viewDidUnload {
    [self setTextfavorite:nil];
    [super viewDidUnload];
}
@end
