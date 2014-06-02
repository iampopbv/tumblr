//
//  YTPlayerView.m
//  MP3TEST
//
//  Created by Matthijs on 5/9/14.
//  Copyright (c) 2014 Matthijs. All rights reserved.
//

#import "YTPlayerView.h"

@interface YTPlayerView ()

@end

@implementation YTPlayerView

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
    _width = 300;
    _height = 200;
    _audioString = @"audio";
    _videoString = @"video";
    _bandcampString = @"bandcamp";
    _soundCloudString = @"soundcloud";
    _tumblrString = @"tumblr";
    _youtubeString = @"youtube";
    
    [super viewDidLoad];
    
    if (_type == _audioString) {
        if (_audio_type == _bandcampString) {
            [self PlayBandCamp];
        }else if(_audio_type == _soundCloudString){
            [self PlaySoundcloud];
        }else if (_audio_type == _tumblrString){
            [self PlayTumblrAudio];
        }else{
            //Nothing or Error message?
        }
    }else if(_type == _videoString){
        if (_video_type == _youtubeString) {
            [self PlayYoutube];
        }else if (_video_type == _tumblrString){
            [self PlayTumblrVideo];
        }else{
            //Nothing or Error message?
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setWebView{
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(10, 70, 300, 200)];
    [webView setAllowsInlineMediaPlayback:YES];
    [webView setMediaPlaybackRequiresUserAction:NO];
    
    [self.view addSubview:webView];
}

-(IBAction)PlayTumblrAudio{
    
        NSString* str = _embed;
        str = [str stringByReplacingOccurrencesOfString:@"width=\"500\" height=\"169\"" withString:@"width=\"300\" height=\"150\""];
    
        [self setWebView];
        NSString* embedHTML = [NSString stringWithFormat:@"\
                           <html>\
                           <body style='margin:0px;padding:0px;'>\
                           %@\
                           </body>\
                           </html>", str];
    
    
    [webView loadHTMLString:embedHTML baseURL:[[NSBundle mainBundle] resourceURL]];
}

-(IBAction)PlayTumblrVideo{
    [self setWebView];
     NSURL *url = [NSURL URLWithString:_video_url];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [webView loadRequest:requestObj];
}

-(IBAction)PlaySoundcloud{
    NSString* str = _player;
    str = [str stringByReplacingOccurrencesOfString:@"%3A" withString: @":"];
    str = [str stringByReplacingOccurrencesOfString:@"%2F" withString: @"/"];
    str = [str stringByReplacingOccurrencesOfString:@"width=\"500\" height=\"500\"" withString:@"width=\"300\" height=\"200\""];
    [self setWebView];
    NSString* embedHTML = [NSString stringWithFormat:@"\
                           <html>\
                           <body style='margin:0px;padding:0px;'>\
                           %@\
                           </body>\
                           </html>", str];
    
    
    [webView loadHTMLString:embedHTML baseURL:[[NSBundle mainBundle] resourceURL]];
    
}

-(IBAction)PlayBandCamp{
    
    NSString* str = _player;
    str = [str stringByReplacingOccurrencesOfString:@"width=\"500\" height=\"120\""
                                         withString: @"width=\"300\" height=\"200\""];
    
    [self setWebView];
    NSString* embedHTML = [NSString stringWithFormat:@"\
                           <html>\
                           <body style='margin:0px;padding:0px;'>\
                           %@\
                           </body>\
                           </html>", str];
                           
                           
    [webView loadHTMLString:embedHTML baseURL:[[NSBundle mainBundle] resourceURL]];
                           
}

-(IBAction)PlayYoutube{
    
    NSString* str = _permalink_url;
    str = [str stringByReplacingOccurrencesOfString:@"http://www.youtube.com/watch?v=" withString:@""];
    
    [self setWebView];
    NSString* embedHTML = [NSString stringWithFormat:@"\
                           <html>\
                           <body style='margin:0px;padding:0px;'>\
                           <script type='text/javascript' src='http://www.youtube.com/iframe_api'></script>\
                           <script type='text/javascript'>\
                           function onYouTubeIframeAPIReady()\
                           {\
                           ytplayer=new YT.Player('playerId',{events:{onReady:onPlayerReady}})\
                           }\
                           function onPlayerReady()a\
                           { \
                           a.target.playVideo(); \
                           }\
                           </script>\
                           <iframe id='playerId' type='text/html' width='%d' height='%d' src='http://www.youtube.com/embed/%@?enablejsapi=1&rel=0&playsinline=1&autoplay=1' frameborder='0'>\
                           </body>\
                           </html>", _width, _height, str];
    [webView loadHTMLString:embedHTML baseURL:[[NSBundle mainBundle] resourceURL]];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
