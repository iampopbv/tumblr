//
//  PlayerView.m
//  ShufflerTumblr
//
//  Created by Casper Eekhof on 19-06-13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import "PlayerView.h"

@implementation PlayerView

@synthesize player;

+ (Class)layerClass {
    return [AVPlayerLayer class];
}

- (AVPlayer*)player {
    return [(AVPlayerLayer *)[self layer] player];
}

- (void)setPlayer:(AVPlayer *)player {
    [(AVPlayerLayer *)[self layer] setPlayer:player];
}

- (CMTime)playerItemDuration
{
    AVPlayerItem *thePlayerItem = [player currentItem];
    if (thePlayerItem.status == AVPlayerItemStatusReadyToPlay)
    {
        
        return([[player currentItem] duration]);
    }
    
    return(kCMTimeInvalid);
}


- (void)syncScrubber
{
    CMTime playerDuration = [self playerItemDuration];
    if (CMTIME_IS_INVALID(playerDuration))
    {
        _slider.minimumValue = 0.0;
        return;
    }
    
    double duration = CMTimeGetSeconds(playerDuration);
    if (isfinite(duration) && (duration > 0))
    {
        float minValue = [ _slider minimumValue];
        float maxValue = [ _slider maximumValue];
        double time = CMTimeGetSeconds([player currentTime]);
        [_slider setValue:(maxValue - minValue) * time / duration + minValue];
    }
}

 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
     [_slider setThumbImage:[UIImage imageNamed:@"sliderthumb.png"] forState:UIControlStateNormal];
     [_slider setThumbImage:[UIImage imageNamed:@"sliderthumb_highlighted.png"] forState: UIControlStateHighlighted];
 }



@end
