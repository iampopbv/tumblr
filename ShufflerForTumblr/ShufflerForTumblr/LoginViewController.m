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

-(void)viewDidLoad{
    [super viewDidLoad];
    [self auth];
}

/**
 * Used for the "Login" button on the login-screen screen.
 */
-(IBAction)buttonTapped:(UIButton *)sender{
    [self auth];
}

/**
 * Method uses the TMAPIClient for the user authentication.
 * "authenticate" uses the application name for the authentication of the connection with the right 
 * Tumblr app.
 * After the authentication methods sends user to the "Authenticated" segue.
 */
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

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma mark - Navigation
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [segue destinationViewController];
}

@end
