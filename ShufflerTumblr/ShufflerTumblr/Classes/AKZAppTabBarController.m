//
//  AKZAppTabBarController.m
//  ShufflerTumblr
//
//  Created by Adrian Zborowski on 25/04/14.
//  Copyright (c) 2014 stud. All rights reserved.
//

#import "AKZAppTabBarController.h"

@interface AKZAppTabBarController ()

@end

@implementation AKZAppTabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    printf(">>> AKZAppTabBarcontroller -> viewDidLoad\n");
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
}

@end
