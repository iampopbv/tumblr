//
//  AKZAuthViewController.m
//  ShufflerTumblr
//
//  Created by Adrian Zborowski on 24/04/14.
//  Copyright (c) 2014 stud. All rights reserved.
//

#import "AKZAuthViewController.h"
#import "AKZAppTabBarController.h"
#import "TMAPIClient.h"
#import "AKZDashboard.h"
#import "AKZSites.h"
#import "AKZPlayer.h"
#import "AKZDiscovery.h"
#import "AKZLikes.h"

@interface AKZAuthViewController ()

@end

@implementation AKZAuthViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    printf(">>> AKZAuthViewController\n");
    
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //[button setFrame:CGRectMake(320, 0, 100,100 )];
    [button setTitle:@"Auth. with Tumblr" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(auth) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    
    [self.view addSubview:button];
}

- (void)auth{
    [[TMAPIClient sharedInstance] authenticate:@"ShufflerTumblr" callback:^(NSError *error) {
        if (error){
            NSLog(@"Authentication failed: %@ %@", error, [error description]);
        }else{
            printf(">>> Authentication successful!\n");
            //NSLog(@"Authentication successful!");
        }
        
        [self performSegueWithIdentifier:@"AKZLoggedIn" sender:self];
    }];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{}

@end
