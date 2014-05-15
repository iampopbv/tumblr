//
//  LoginViewController.m
//  ShufflerForTumblr
//
//  Created by Adrian Zborowski on 15/05/14.
//  Copyright (c) 2014 Hogeschoool van Amsterdam. All rights reserved.
//

#import "TMAPIClient.h"
#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
}

-(IBAction)buttonTapped:(UIButton *)sender{
    [self auth];
}

-(void)auth{
    [[TMAPIClient sharedInstance] authenticate:@"ShufflerForTumblr" callback:^(NSError *error) {
        if(error){
            NSLog(@"Authentication failed: %@ %@", error, [error description]);
        }else{
            NSLog(@"Authentication successful!");
            [self performSegueWithIdentifier:@"Authenticated" sender:self];
        }
    }];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
