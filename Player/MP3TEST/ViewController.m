//
//  ViewController.m
//  MP3TEST
//
//  Created by Matthijs on 4/30/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"
#import "YTPlayerView.h"

@interface ViewController ()

//@property (nonatomic, strong) UIWebView *webView;

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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"goToPlayer"]){
        YTPlayerView *controller = segue.destinationViewController;
        controller.playerNumber = _PlayerNr;
        controller.album = _album;
        controller.album_art = _album_art;
        controller.artist = _artist;
        controller.audio_type = _audio_type;
        controller.blog_name = _blog_name;
        controller.date = _date;
        controller.embed = _embed;
        controller.ID = _ID;
        controller.is_external = _is_external;
        controller.player = _player;
        controller.post_url = _post_url;
        controller.source_title = _source_title;
        controller.track_name = _track_name;
        controller.type = _type;
        controller.video_url = _video_url;
        controller.video_type = _video_type;
        
        controller.permalink_url = _permalink_url;
        controller.embed = _embed;
        controller.thumbnail_url = _thumbnail_url;
        
    }
}

-(IBAction) setYoutube{
    _type = @"video";
    _video_type = @"youtube";
    _permalink_url = @"http://www.youtube.com/watch?v=z4OjBGzFR1Q";
}

-(IBAction) setSoundCloud{
    _type = @"audio";
    _audio_type = @"soundcloud";
    _player = @"<iframe src=\"https://w.soundcloud.com/player/?url=http%3A%2F%2Fapi.soundcloud.com%2Ftracks%2F149667609&amp;visual=true&amp;liking=false&amp;sharing=false&amp;auto_play=false&amp;show_comments=false&amp;continuous_play=false&amp;origin=tumblr\" frameborder=\"0\" allowtransparency=\"true\" class=\"soundcloud_audio_player\" width=\"500\" height=\"500\"></iframe>";
}

-(IBAction) setBandCamp{
    _type = @"audio";
    _audio_type = @"bandcamp";
    _player = @"<iframe class=\"bandcamp_audio_player\" width=\"500\" height=\"120\" src=\"http://bandcamp.com/EmbeddedPlayer/size=medium/bgcol=ffffff/linkcol=0687f5/notracklist=true/transparent=true/track=1969767334/\" allowtransparency=\"true\" frameborder=\"0\"></iframe>";
}

-(IBAction) setTmblrAudio{
    _type = @"audio";
    _audio_type = @"tumblr";
    _embed = @"<iframe class=\"tumblr_audio_player tumblr_audio_player_87384608810\" src=\"http://tumblr.absono.us/post/87384608810/audio_player_iframe/whitneymcn/tumblr_ma8pdoO9nZ1qdcalg?audio_file=https%3A%2F%2Fwww.tumblr.com%2Faudio_file%2Fwhitneymcn%2F87384608810%2Ftumblr_ma8pdoO9nZ1qdcalg\" frameborder=\"0\" allowtransparency=\"true\" scrolling=\"no\" width=\"500\" height=\"169\"></iframe>";
}

-(IBAction) setTmblrVideo{
    _type = @"video";
    _video_type = @"tumblr";
    _video_url = @"http://vt.tumblr.com/tumblr_n6jj3q3Fjx1s2ig4y.mp4";
}

@end
