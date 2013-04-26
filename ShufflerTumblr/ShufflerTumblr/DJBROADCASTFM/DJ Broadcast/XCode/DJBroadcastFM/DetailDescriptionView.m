//
//  DetailDescriptionContainerView.m
//  DJBroadcastFM
//
//  Created by Casper Eekhof on 03-04-13.
//  Copyright (c) 2013 Casper. All rights reserved.
//

#import "DetailDescriptionView.h"

@implementation DetailDescriptionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) displayRelease: (id<Release>) release {
    [_titleLabel setText:[release title]];
    [_image setImage:[release image]];
    
    NSMutableString *artiststring = [[NSMutableString alloc] init];
    for(NSString *artist in [release artists])
    {
        [artiststring appendFormat:@"%@ ", artist];
    }
    
    [_artist setText: artiststring];
    
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
