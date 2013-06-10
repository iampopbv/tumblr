//
//  DiscoverViewController.m
//  ShufflerTumblr
//
//  Created by Casper Eekhof on 10-06-13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import "DiscoverViewController.h"
#import "Blog.h"
#import "bloggetter.h"

@interface DiscoverViewController ()

@end

@implementation DiscoverViewController

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
    _tabledata = [[NSMutableArray alloc] init];
    _tableimages = [[NSMutableArray alloc] init];
    _blogdata = [[NSMutableArray alloc] init];
    _blogs = [[NSMutableArray alloc] init];
    
    
    NSArray *blogURLS = [[NSArray alloc] initWithObjects:@"http://maxabelson.com/",  @"http://breakupyourband.tumblr.com/", @"http://traviesblog.com/", @"http://earsofthebeholder.com/", @"http://petewentz.com/", @"http://mvmvmv.tumblr.com/", nil];
    
    // load the 4 featured blogs
    int index = 0;
    
    for(NSString *blogURL in blogURLS){
        Blog *tmpBlog = [[Blog alloc] initWithURL: blogURL];
        [tmpBlog getInfo:^(id<Info> info, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                BlogInfo * blogInfo = info;
                NSString * capitalizedName = [blogInfo.name uppercaseString];
                
                [_tabledata addObject: capitalizedName];
                if ([blogInfo image]) {
                    [_tableimages addObject:[blogInfo image]];
                } else {
                    [_tableimages addObject: [UIImage imageNamed:@"followed_ico.png"]];
                }
                
                [_tableView reloadData];
                [_blogdata addObject: self];
            });
        }];
        [_blogs addObject: tmpBlog];
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

//#pragma UITableView delegates
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSString *segueName = [segue identifier];
    if([segueName isEqualToString: @"discover_segue"]){
        [[_blogs objectAtIndex:_chosenBlog] reset];
        [(id<bloggetter>)segue.destinationViewController getBlog: [_blogs objectAtIndex:_chosenBlog]];
    }
}

-(void) tableView:(UITableView *) tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _chosenBlog = indexPath.row;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"discover_segue" sender:self];
    
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_tabledata count];
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    cell.textLabel.text = [_tabledata objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:@"BrandonGrotesque-Bold" size:15];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.imageView.image = [_tableimages objectAtIndex: indexPath.row];
    cell.backgroundView = [[UIImageView alloc]initWithImage: [UIImage imageNamed:@"Blogfront.png"]];
    return cell;
}

- (void)viewDidUnload {
    [self setTableView:nil];
    [self setTopMessageLabel:nil];
    [super viewDidUnload];
}
@end
