//
//  ViewController.h
//  MP3TEST
//
//  Created by Matthijs on 4/30/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    IBOutlet UIWebView *webView;

}

@property (nonatomic) int PlayerNr;

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;
-(IBAction)setYoutube:(id)sender;
-(IBAction)setSoundCloud:(id)sender;
-(IBAction)setBandCamp:(id)sender;
@end
