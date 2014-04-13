//
//  MenuViewController.m
//  ShufflerTumblr
//
//  Created by Casper Eekhof on 11-05-13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import "MenuViewController.h"
#import "Blog.h"
#import "DirectURLGetter.h"
#import "TMAPIClient.h"
#import "TMTumblrAuthenticator.h"
#import "keys.h"
#import "User.h"
#import "Player.h"
#import "BlogPlaylistViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

/**
 No method description
 @return self
 */
-(id)initWithCoder:(NSCoder *)coder{
    
    self = [super initWithCoder:coder];
    if (self) {
        _hasInternet = NO;
    }
    return self;
}

/**
 No method description
 */
-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    // Go to the dashboard if we have the credentials
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"LoggedInNavigationController"];
    [vc setModalPresentationStyle: UIModalPresentationFullScreen];
    [vc setModalTransitionStyle: UIModalTransitionStyleCrossDissolve];
    
    [TMAPIClient sharedInstance].OAuthConsumerKey = kConsumerKey;
    [TMAPIClient sharedInstance].OAuthConsumerSecret = kConsumerSecret;
    
    NSString * docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex: 0];
    // Write away the keys for next time
    NSString *listPath = [docsDir stringByAppendingPathComponent:@"keys.plist"];
    
    if([[NSFileManager defaultManager] fileExistsAtPath: listPath]){
        NSArray *tokens = [[NSArray alloc] initWithContentsOfFile: listPath];
        
        [[TMAPIClient sharedInstance] setOAuthToken:tokens[0]];
        [[TMAPIClient sharedInstance] setOAuthTokenSecret:tokens[1]];
        [[User sharedInstance] setLoggedIn: YES];
        
        [self presentViewController: vc animated:YES completion:nil];
    }
    
    // If playing; show the post
    if([[Player sharedInstance] playing]){
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

/**
 No method description
 */
- (void)viewDidLoad{
    
    [super viewDidLoad];
    // Test whether we got interwebss
    [self testInternetConnection];
    
    // init the url getter so youtube urls can be converted anytime later on in a split second!
    [DirectURLGetter sharedInstance];
    _tabledata = [[NSMutableArray alloc] init];
    _tableimages = [[NSMutableArray alloc] init];
    _blogdata = [[NSMutableArray alloc] init];
    _blogs = [[NSMutableArray alloc] init];
    
    // Display the logo of ShufflerFM in the top
    UIImageView* logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shumblrlogo.png"]];
    logo.frame= CGRectMake(0,0,20,25);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:logo];
    
    NSDictionary *titleTextAttributesDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                             [UIColor whiteColor], NSForegroundColorAttributeName,
                                             [UIColor whiteColor], NSShadowAttributeName,
                                             [NSValue valueWithUIOffset:UIOffsetMake(0, 1)], NSShadowAttributeName,
                                             [UIFont fontWithName:@"BrandonGrotesque-Bold" size:20.0], NSFontAttributeName,
                                             nil];
    [self.navigationController.navigationBar setTitleTextAttributes: titleTextAttributesDict];
    
    // The featured blogs
    NSArray *blogURLS = [[NSArray alloc] initWithObjects:@"http://maxabelson.com/",  @"http://breakupyourband.tumblr.com/", @"http://traviesblog.com/", @"http://earsofthebeholder.com/", @"http://petewentz.com/", nil];
    
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
                [_blogs addObject: tmpBlog];
            });
        }];
        index++;
    }
    _signupbutton.titleLabel.font = [UIFont fontWithName:@"BrandonGrotesque-Bold" size:10];
    _listento.font = [UIFont fontWithName:@"BrandonGrotesque-Bold" size:22];
}

/**
 No method description
 */
-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 No method description
 */
-(void)openCurrentTrack{
    // code for opening the current track
    
    SinglePostViewController *vc = [[SinglePostViewController alloc] init];
    UIView *postView = [[[NSBundle mainBundle] loadNibNamed:@"PostView" owner: vc options:nil] objectAtIndex: 0];
    [vc.view addSubview: postView];
    
    vc.post = [[[Player sharedInstance] playlist] objectAtIndex: [[Player sharedInstance] playListCounter]];
    [vc setPostView: postView];
    [self.navigationController pushViewController: vc animated: YES];
}

/**
 Check if the internet connection is acquired
 */
-(void)testInternetConnection{
    __weak typeof(self) weakSelf = self;
    _internetReachableChecker = [Reachability reachabilityWithHostname:@"www.google.com"];
    
    // Internet is reachable
    _internetReachableChecker.reachableBlock = ^(Reachability*reach){
        // Update the UI on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.hasInternet = YES;
        });
    };
    
    // Internet is not reachable
    _internetReachableChecker.unreachableBlock = ^(Reachability*reach){
        // Update the UI on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.hasInternet = YES;
        });
    };
    
    [_internetReachableChecker startNotifier];
}

/**
 No method description
 */
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    
    // a segue from here should only result in a popup if there is no internet
    if(!_hasInternet){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"No connection" message:@"You need a working internet connection to be able to use Shumbler."  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil, nil];
        [alert show];
        return NO;
    }
    return YES;
}

#pragma UITableView delegate methods
/**
 No method description
 */
-(void)tableView:(UITableView *) tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _chosenBlog = (int)indexPath.row;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    BlogPlaylistViewController *blogVC = [storyboard instantiateViewControllerWithIdentifier:@"BlogPlaylist"];
    [blogVC setBlog: [_blogs objectAtIndex: _chosenBlog]];
    [self.navigationController pushViewController: blogVC animated:YES];
}

/**
 No method description
 */
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_tabledata count];
}

/**
 No method description
 */
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    UIView *bgColorView = [[UIView alloc] init];
    [bgColorView setBackgroundColor:[UIColor blackColor]];
    [cell setSelectedBackgroundView:bgColorView];
    
    cell.textLabel.text = [_tabledata objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:@"BrandonGrotesque-Bold" size:15];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.imageView.image = [_tableimages objectAtIndex: indexPath.row];
    cell.backgroundView = [[UIImageView alloc]initWithImage: [UIImage imageNamed:@"Blogfront.png"]];
    return cell;
}

/**
 Login with OAuth and save the credentials
 */
-(IBAction)signInButtonPressed:(id)sender{
    
    NSString * docsDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex: 0];
    // Write away the keys for next time
    NSString *listPath = [docsDir stringByAppendingPathComponent:@"keys.plist"];
    
    if(![[NSFileManager defaultManager] fileExistsAtPath: listPath]){
        [[TMAPIClient sharedInstance] authenticate:@"Shumbler" callback:^(NSError *error) {
            if(!error){
                NSLog(@"Succes on authentication");
                
                
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
                UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"LoggedInNavigationController"];
                [vc setModalPresentationStyle: UIModalPresentationFullScreen];
                [vc setModalTransitionStyle: UIModalTransitionStyleCrossDissolve];
                [self presentViewController: vc animated:YES completion:nil];
                [[User sharedInstance] setLoggedIn: YES];
                
                
                NSString * token = [[TMAPIClient sharedInstance] OAuthToken];
                NSString * tokenSecret = [[TMAPIClient sharedInstance] OAuthTokenSecret];
                
                // Save the credentials
                NSArray *keysArray = [[NSArray alloc] initWithObjects: token, tokenSecret, nil];
                [keysArray writeToFile:listPath atomically:YES];
                
            } else {
                // Pop-up for failure
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Permission error" message:@"You did not give permission to Shumbler. You can not use the app."  delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil, nil];
                    [alert show];
                });
                
            }
        }];
    } else {
        NSArray *tokens = [[NSArray alloc] initWithContentsOfFile: listPath];
        
        [[TMAPIClient sharedInstance] setOAuthToken:tokens[0]];
        [[TMAPIClient sharedInstance] setOAuthTokenSecret:tokens[1]];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"LoggedInNavigationController"];
        [vc setModalPresentationStyle: UIModalPresentationFullScreen];
        [vc setModalTransitionStyle: UIModalTransitionStyleCrossDissolve];
        [self presentViewController: vc animated:YES completion:nil];
        
    }
}

/**
 No method description
 */
-(void)viewDidUnload {
    [self setListento:nil];
    [self setSignupbutton:nil];
    [self setTableView:nil];
    [self setTableView:nil];
    [self setSigninButton:nil];
    [super viewDidUnload];
}

@end
