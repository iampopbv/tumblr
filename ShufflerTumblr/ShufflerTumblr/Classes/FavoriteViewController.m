//
//  FavoriteViewController.m
//  ShufflerTumblr
//
//  Created by Casper Eekhof on 26-05-13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import "FavoriteViewController.h"
#import "SinglePostViewController.h"

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
    
    // Logo display
    _textfavorite.font = [UIFont fontWithName:@"BrandonGrotesque-Bold" size:22];
    UIImageView* logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shumblrlogo.png"]];
    logo.frame= CGRectMake(0,0,20,25);
     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:logo];
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    // Download the favorites
    self.navigationController.navigationBar.topItem.title = @"Favorite";
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
            [tableText addObject: object];
            [_tableView reloadData];
        }
    }];
}


#pragma UITableView delegate object
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableText count];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSString *segueName = [segue identifier];
    if([segueName isEqualToString: @"favourite_segue"]){
        // Place the post in a new view.
        SinglePostViewController *tmp = [segue destinationViewController];
        tmp.post = [tableText objectAtIndex: chosenRow];
    }
}

-(void) tableView:(UITableView *) tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    chosenRow = indexPath.row;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"favourite_segue" sender:self];
    
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
