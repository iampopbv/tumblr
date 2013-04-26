//
//  RateBarView.m
//  DJBroadcastFM
//
//  Created by Casper Eekhof on 20-04-13.
//  Copyright (c) 2013 Casper. All rights reserved.
//

#import "RateBar.h"

@implementation RateBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Displays the rating with an int from 0 till 10
-(void) displayRating: (int) rate {
    
    UIImage *highlightedImage = [UIImage imageNamed:@"ratebar_highlighted.png"];
    
    switch (rate) {
        case 10:
            [[_images objectAtIndex: 9] setImage: highlightedImage];
        case 9:
            [[_images objectAtIndex: 8] setImage: highlightedImage];
        case 8:
            [[_images objectAtIndex: 7] setImage: highlightedImage];
        case 7:
            [[_images objectAtIndex: 6] setImage: highlightedImage];
        case 6:
            [[_images objectAtIndex: 5] setImage: highlightedImage];
        case 5:
            [[_images objectAtIndex: 4] setImage: highlightedImage];
        case 4:
            [[_images objectAtIndex: 3] setImage: highlightedImage];
        case 3:
            [[_images objectAtIndex: 2] setImage: highlightedImage];
        case 2:
            [[_images objectAtIndex: 1] setImage: highlightedImage];
        case 1:
            [[_images objectAtIndex: 0] setImage: highlightedImage];
        default:
            break;
    }
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
