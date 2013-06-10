//
//  MenuViewController.m
//  ShufflerTumblr
//
//  Created by Casper Eekhof on 11-05-13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import "MenuViewController.h"
#import "Blog.h"
#import "YoutubeURLGetter.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _hasInternet = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

  
	// Do any additional setup after loading the view.
    [self testInternetConnection];
    
    // init the url getter so youtube urls can be converted anytime later on in a split second!
    [[YoutubeURLGetter alloc] init];
    _tabledata = [[NSMutableArray alloc] init];
    _tableimages = [[NSMutableArray alloc] init];
    _blogdata = [[NSMutableArray alloc] init];
    
    
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

    
    // load the 4 featured blogs
    _blog1 = [[Blog alloc] initWithURL: @"http://maxabelson.com/"];
    [_blog1 getInfo:^(id<Info> info, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            BlogInfo * blogInfo = info;
            NSString * capitalizedName = [blogInfo.name uppercaseString];
            [_blog1Title setText: capitalizedName];
            
            [_tabledata addObject: capitalizedName];
            [_imageBlog1 setImage: [blogInfo image]];
            [_tableimages addObject:[blogInfo image]];
            [_tableView reloadData];
            [_blogdata addObject: self];
        });
    }];
    
    NSLog(@"Init second blog");
    _blog2 = [[Blog alloc] initWithURL: @"http://breakupyourband.tumblr.com/"];
    [_blog2 getInfo:^(id<Info> info, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            BlogInfo * blogInfo = info;
            NSString * capitalizedName = [blogInfo.name uppercaseString];
            
            [_blog2Title setText: capitalizedName];
            [_tabledata addObject: capitalizedName];
            [_imageBlog2 setImage: [blogInfo image]];
            [_tableimages addObject:[blogInfo image]];
            [_blogdata addObject: self];
            [_tableView reloadData];
        });
    }];
    NSLog(@"Init third blog");
    _blog3 = [[Blog alloc] initWithURL: @"http://traviesblog.com/"];
    [_blog3 getInfo:^(id<Info> info, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            BlogInfo * blogInfo = info;
            NSString * capitalizedName = [blogInfo.name uppercaseString];
            
            [_blog3Title setText: capitalizedName];
            [_tabledata addObject: capitalizedName];
            [_imageBlog3 setImage: [blogInfo image]];
            [_tableimages addObject:[blogInfo image]];
            [_tableView reloadData];
            [_blogdata addObject: self];
        });
    }];
    NSLog(@"Init fourth blog");
    _blog4 = [[Blog alloc] initWithURL: @"http://earsofthebeholder.com/"];
    [_blog4 getInfo:^(id<Info> info, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            BlogInfo * blogInfo = info;
            NSString * capitalizedName = [blogInfo.name uppercaseString];
            
            [_blog4Title setText: capitalizedName];
            [_tabledata addObject: capitalizedName];
            [_imageBlog4 setImage: [blogInfo image]];
            [_tableimages addObject:[blogInfo image]];
            [_tableView reloadData];
            [_blogdata addObject: self];
        });
    }];
    NSLog(@"Init fith blog");
    _blog5 = [[Blog alloc] initWithURL: @"http://petewentz.com/"];
    [_blog5 getInfo:^(id<Info> info, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            BlogInfo * blogInfo = info;
            NSString * capitalizedName = [blogInfo.name uppercaseString];
            
            [_blog5Title setText: capitalizedName];
            if(capitalizedName != nil)
                [_tabledata addObject: capitalizedName];
            else
                [_tabledata addObject:@"No title"];
            [_imageBlog5 setImage: [blogInfo image]];
            if ([blogInfo image] != nil)
                [_tableimages addObject:[blogInfo image]];
            else
                [_tableimages addObject: [UIImage imageNamed:@"followed_ico.png"]];
            [_tableView reloadData];
            [_blogdata addObject: self];
        });
    }];
    _signupbutton.font = [UIFont fontWithName:@"Brandon Grotesque" size:12];
    _listento.font = [UIFont fontWithName:@"BrandonGrotesque-Bold" size:22];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) openCurrentTrack {
    [self performSegueWithIdentifier:@"segue_blog1" sender:self];
}

// Checks if we have an internet connection or not
- (void)testInternetConnection
{
    __weak typeof(self) weakSelf = self;
    _internetReachableChecker = [Reachability reachabilityWithHostname:@"www.google.com"];
    
    // Internet is reachable
    _internetReachableChecker.reachableBlock = ^(Reachability*reach)
    {
        // Update the UI on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.hasInternet = YES;
        });
    };
    
    // Internet is not reachable
    _internetReachableChecker.unreachableBlock = ^(Reachability*reach)
    {
        // Update the UI on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.hasInternet = YES;
        });
    };
    
    [_internetReachableChecker startNotifier];
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    // a segue from here should only result in a popup if there is no internet
    if(!_hasInternet){
        UIAlertView *cellularData = [[UIAlertView alloc] initWithTitle: @"Geen internet" message:@"U heeft een active internetverbinding nodig om Shumbler te kunnen gebruiken"  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil, nil];
        [cellularData show];
        return NO;
    }
    return YES;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSString *segueName = [segue identifier];
    if([segueName isEqualToString: @"segue_blog1"]){
        [_blog1 reset];
        [(id<bloggetter>)segue.destinationViewController getBlog:_blog1];
    } else if([segueName isEqualToString: @"segue_blog2"]) {
        [_blog2 reset];
        [(id<bloggetter>)segue.destinationViewController getBlog:_blog2];
    } else if([segueName isEqualToString: @"segue_blog3"]){
        [_blog3 reset];
        [(id<bloggetter>)segue.destinationViewController getBlog:_blog3];
    } else if([segueName isEqualToString: @"segue_blog4"]) {
        [_blog4 reset];
        [(id<bloggetter>)segue.destinationViewController getBlog:_blog4];
    }else if([segueName isEqualToString: @"segue_blog5"]) {
        [(id<bloggetter>)segue.destinationViewController getBlog:_blog5];
    }else if([segueName isEqualToString: @"LoadBlogSegue"]) {
        [(id<bloggetter>)segue.destinationViewController getBlog:_segueBlog];
    }
    
    
}

-(void) tableView:(UITableView *) tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _segueBlog = [_blogdata objectAtIndex: indexPath.row];
    
    

    [self performSegueWithIdentifier:@"segueToBlog" sender:self];
    
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
    [self setImageBlog1:nil];
    [self setImageBlog2:nil];
    [self setImageBlog3:nil];
    [self setImageBlog4:nil];
    [self setListento:nil];
    [self setShumblr:nil];
    [self setSignupbutton:nil];
    [self setTableView:nil];
    [self setTableView:nil];
    [super viewDidUnload];
}
@end
