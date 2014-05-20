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

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {}
//    return self;
//}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self auth];
}

-(IBAction)buttonTapped:(UIButton *)sender{
    [self auth];
}

-(void)auth{
    [[TMAPIClient sharedInstance] authenticate:@"ShufflerForTumblr" callback:^(NSError *error) {
        if(error){
            NSLog(@"\nAuthentication failed: %@ %@", error, [error description]);
        }else{
            NSLog(@"\nAuthentication successful!");
            [self performSegueWithIdentifier:@"Authenticated" sender:self];
        }
    }];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma mark - Navigation
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [segue destinationViewController];
}

@end
