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

@property (nonatomic) NSString* album;
@property (nonatomic) NSString* album_art;
@property (nonatomic) NSString* artist;
@property (nonatomic) NSString* audio_type;
@property (nonatomic) NSString* blog_name;
@property (nonatomic) NSString* date;
@property (nonatomic) NSString* embed;
@property (nonatomic) NSString* ID;
@property (nonatomic) NSString* is_external;
@property (nonatomic) NSString* player;
@property (nonatomic) NSString* post_url;
@property (nonatomic) NSString* source_title;
@property (nonatomic) NSString* track_name;
@property (nonatomic) NSString* type;

@property (nonatomic) NSString* permalink_url;
@property (nonatomic) NSString* embed_code;
@property (nonatomic) NSString* thumbnail_url;

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;
-(IBAction)setYoutube:(id)sender;
-(IBAction)setSoundCloud:(id)sender;
-(IBAction)setBandCamp:(id)sender;
@end
