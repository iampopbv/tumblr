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

 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
     [_slider setThumbImage:[UIImage imageNamed:@"thumb"] forState:UIControlStateNormal];
     [_slider setThumbImage:[UIImage imageNamed:@"thumb_highlighted.png"] forState: UIControlStateHighlighted];
 }



@end
