//
//  DashBoardViewController.m
//  ShufflerTumblr
//
//  Created by Casper Eekhof on 26-05-13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import "DashBoardViewController.h"
#import "MPOAuthURLRequest.h"
#import "MPOAuthURLResponse.h"
#import "keys.h"
#import "MPOAuthSignatureParameter.h"

@interface DashBoardViewController ()

@end

@implementation DashBoardViewController

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
    _responseData = [[NSMutableData alloc] init];
	// Do any additional setup after loading the view.
    
    NSDictionary *titleTextAttributesDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                             [UIColor whiteColor], UITextAttributeTextColor,
                                             [UIColor whiteColor], UITextAttributeTextShadowColor,
                                             [NSValue valueWithUIOffset:UIOffsetMake(0, 1)], UITextAttributeTextShadowOffset,
                                             [UIFont fontWithName:@"BrandonGrotesque-Bold" size:23.0], UITextAttributeFont,
                                             nil];
    [self.navigationController.navigationBar setTitleTextAttributes: titleTextAttributesDict];
    
    
    
    NSURL * url = [[NSURL alloc] initWithString: @"http://api.tumblr.com/v2/user/dashboard"];
    NSMutableURLRequest *urlMutableRequest = [[NSMutableURLRequest alloc] initWithURL: url];
    [urlMutableRequest setHTTPMethod: @"GET"];
    
    MPOAuthURLRequest *request = [[MPOAuthURLRequest alloc] initWithURLRequest: urlMutableRequest];
    
    
    
    
    NSURLRequest *urlRequest = [request urlRequestSignedWithSecret:kConsumerSecret usingMethod: kMPOAuthSignatureMethodHMACSHA1];
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:urlRequest delegate: self];
}

-(void)viewDidAppear:(BOOL)animated {
    self.navigationController.navigationBar.topItem.title = @"Dashboard";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_responseData appendData: data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // it is now safe to use the data elsewhere.
    NSString* dataS = [NSString stringWithUTF8String:[_responseData bytes]];
    NSLog(@"Data received %@", dataS);

    [_responseData setData: nil];
}


@end
