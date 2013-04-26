//
//  ViewController.m
//  DJBroadcast
//
//  Created by Casper Eekhof on 20-03-13.
//  Copyright (c) 2013 Casper. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController





- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)downloadButton:(id)sender {
    DJBroadcastDB * db = [[DJBroadcastDB alloc] init];
    NSLog(@"%@", [db description]);
        
//    if([_queryTextfield hasText]){
//        [db getSearch: [_queryTextfield text]];
//    } else {
//        [db getRelease: 50];
//    }
//    [_queryTextfield resignFirstResponder];
}

@end
