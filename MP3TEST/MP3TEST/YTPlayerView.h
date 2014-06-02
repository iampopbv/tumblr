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

@property (nonatomic) int width;
@property (nonatomic) int height;
@property (nonatomic) NSString* audioString;
@property (nonatomic) NSString* bandcampString;
@property (nonatomic) NSString* soundCloudString;
@property (nonatomic) NSString* tumblrString;
@property (nonatomic) NSString* videoString;
@property (nonatomic) NSString* youtubeString;

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
@property (nonatomic) NSString* video_url;
@property (nonatomic) NSString* video_type;

@property (nonatomic) NSString* permalink_url;
@property (nonatomic) NSString* embed_code;
@property (nonatomic) NSString* thumbnail_url;
@end
