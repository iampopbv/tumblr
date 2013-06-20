//
//  PlayerView.m
//  ShufflerTumblr
//
//  Created by Casper Eekhof on 19-06-13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import "PlayerView.h"

@implementation PlayerView

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
    AVPlayerItem *thePlayerItem = [[self player] currentItem];
    if (thePlayerItem.status == AVPlayerItemStatusReadyToPlay)
    {
        
        return([[[self player] currentItem] duration]);
    }
    
    return(kCMTimeInvalid);
}


-(void)initScrubberTimer
{
    double interval = .1f;
    
    CMTime playerDuration = [self playerItemDuration];
    if (CMTIME_IS_INVALID(playerDuration))
    {
        return;
    }
    double duration = CMTimeGetSeconds(playerDuration);
    if (isfinite(duration))
    {
        CGFloat width = CGRectGetWidth([self.slider bounds]);
        interval = 0.5f * duration / width;
    }
    
    /* Update the scrubber during normal playback. */
    _mTimeObserver = [[self player] addPeriodicTimeObserverForInterval:CMTimeMakeWithSeconds(interval, NSEC_PER_SEC)
                                                                queue:NULL /* If you pass NULL, the main queue is used. */
                                                           usingBlock:^(CMTime time)
                      {
                          [self syncScrubber];
                      }];
    
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
        double time = CMTimeGetSeconds([[self player] currentTime]);
        NSLog(@"setting value");
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
