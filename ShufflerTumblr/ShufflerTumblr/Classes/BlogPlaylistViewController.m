//
//  BlogPlaylistViewController.m
//  ShufflerTumblr
//
//  Created by Casper Eekhof on 20-06-13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import "BlogPlaylistViewController.h"
#import "Player.h"
#import "SinglePostViewController.h"

@interface BlogPlaylistViewController ()

@end

@implementation BlogPlaylistViewController

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
    tableText = [[NSMutableArray alloc] init];
    tableimages = [[NSMutableArray alloc] init];
    tableObjects = (NSMutableArray<Post>*)[[NSMutableArray alloc] init];
    
    
    [_titleLabel setText: [[NSString alloc] initWithFormat: @"Playlist of %@", [[_blog blogInfo] name]]];
    [_titleLabel setFont: [UIFont fontWithName:@"BrandonGrotesque-Bold" size: 25]];
    
    [self setupUI];
    [self loadNextPage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTableView:nil];
    [self setTitleLabel:nil];
    [super viewDidUnload];
}

- (void) setupUI {
    UIBarButtonItem *barButtonAppearance = [UIBarButtonItem appearance];
    [barButtonAppearance setTintColor:[UIColor blackColor]]; // Change to your colour
    
}

-(void)loadNextPage {
    [_blog getNextPageLatest:^(NSArray<Post> *posts, NSError *error) {
        
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
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [_tableView reloadData];
            });
        }
    }];
}

-(void)setBlog:(Blog *)blog {
    _blog = blog;
    [_blog reset];
}


#pragma UITableView delegates
-(void) tableView:(UITableView *) tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    chosenRow = indexPath.row;
    [tableView deselectRowAtIndexPath:indexPath animated: YES];
    
    [[Player sharedInstance] clear];
    // Set the playlist starting from the selected row
    [[Player sharedInstance] setPlaylist: (NSMutableArray<Post>*) [[NSMutableArray alloc] initWithArray: [tableObjects subarrayWithRange: NSMakeRange( chosenRow, [tableObjects count] - chosenRow -1)]]];
    
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
    
    double cal = (_tableView.contentOffset.y / _tableView.rowHeight) ;
    if (cal >= [tableObjects count] - 4){
        // Load next page of playlist
        [self loadNextPage];
    }
}
@end
