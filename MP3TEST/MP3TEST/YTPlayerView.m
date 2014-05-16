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
    [super viewDidLoad];
    if (_playerNumber == 1) {
        [self PlayYoutube];
    }else if (_playerNumber == 2){
        [self PlaySoundcloud];
    }else if (_playerNumber == 3){
        [self PlayBandCamp];
    }else{
    }
        
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setWebView{
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(10, 70, 300, 300)];
    [webView setAllowsInlineMediaPlayback:YES];
    [webView setMediaPlaybackRequiresUserAction:NO];
    
    [self.view addSubview:webView];
}

-(IBAction)PlaySoundcloud{
    [self setWebView];
    NSString* embedHTML = [NSString stringWithFormat:@"\
                           <html>\
                           <body style='margin:0px;padding:0px;'>\
                           <iframe width='%d' height='%d' scrolling='no' frameborder='no' src='https://w.soundcloud.com/player/?url=https://w.soundcloud.com/tracks/%@?amp;auto_play=false&amp;hide_related=false&amp;visual=true'></iframe>\
                           </body>\
                           </html>", 300, 200, @"12104576"];
    
    
    [webView loadHTMLString:embedHTML baseURL:[[NSBundle mainBundle] resourceURL]];
    
}

-(IBAction)PlayBandCamp{
    [self setWebView];
    NSString* embedHTML = [NSString stringWithFormat:@"\
                           <html>\
                           <body style='margin:0px;padding:0px;'>\
                           <iframe style='border: 0; width: %dpx; height: %dpx;' src='http://bandcamp.com/EmbeddedPlayer/album=2248675723/size=large/bgcol=ffffff/linkcol=0687f5/tracklist=false/artwork=small/track=2598169180/transparent=true/' seamless><a href='http://blackjamesfranco.bandcamp.com/album/sun-house'>Sun House by Black James Franco</a></iframe>\
                           </body>\
                           </html>", 300, 200];
                           
                           
    [webView loadHTMLString:embedHTML baseURL:[[NSBundle mainBundle] resourceURL]];
                           
}

-(IBAction)PlayYoutube{
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
                           </html>", 300, 200, @"2pKk_meu524"];
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
