//
//  CustomSlider.m
//  DJBroadcastFM
//
//  Created by Casper Eekhof on 28-03-13.
//  Copyright (c) 2013 Casper. All rights reserved.
//

#import "CustomSlider.h"

@implementation CustomSlider




- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    NSLog(@"Slider init");
    [self setThumbImage:[UIImage imageNamed:@"slider_thumb.png"] forState:UIControlStateNormal];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{    
    // TODO: add code to support Retina display
    [self setThumbImage:[UIImage imageNamed:@"sliderthumb.png"] forState:UIControlStateNormal];
    [self setThumbImage:[UIImage imageNamed:@"sliderthumb_highlighted.png"] forState: UIControlStateHighlighted];
    
}


@end
