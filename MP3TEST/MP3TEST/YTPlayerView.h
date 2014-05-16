//
//  YTPlayerView.h
//  MP3TEST
//
//  Created by Matthijs on 5/9/14.
//  Copyright (c) 2014 Matthijs. All rights reserved.
//

#import "ViewController.h"

@interface YTPlayerView : UIViewController{
    IBOutlet UIWebView *webView;
}

@property (nonatomic) int playerNumber;

-(IBAction)closer:(id)sender;
@end
