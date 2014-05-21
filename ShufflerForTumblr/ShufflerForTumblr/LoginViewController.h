//
//  LoginViewController.h
//  ShufflerForTumblr
//
//  Created by Adrian Zborowski on 15/05/14.
//  Copyright (c) 2014 Hogeschoool van Amsterdam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

-(void)viewDidLoad;

-(IBAction)buttonTapped:(UIButton *)sender;

-(void)auth;

-(void)didReceiveMemoryWarning;

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;

@end
