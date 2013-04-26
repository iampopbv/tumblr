//
//  TestView.m
//  DJBroadcastFM
//
//  Created by Casper Eekhof on 17-04-13.
//  Copyright (c) 2013 Casper. All rights reserved.
//

#import "ContainerView.h"

@implementation ContainerView
static id sender;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

-(void) replaceToX: (NSInteger) x {
    CGRect frame = self.frame;
    
    frame.origin.x = x;
    
    [UIView animateWithDuration: 0.0 animations: ^{
        self.frame = frame;
    }];
}

-(void) showWithSender: (id) DetailNEW {
    sender = DetailNEW;
    [sender showView];
}

-(void) showView {
    CGRect frame = self.frame;
    
    frame.origin.x += frame.size.width;
    
    [UIView animateWithDuration: 0.6 animations: ^{
        self.frame = frame;
    }];
}


-(void) showViewY {
    CGRect frame = self.frame;
    
    frame.origin.y -= 450;
    
    [UIView animateWithDuration: 0.6 animations: ^{
        self.frame = frame;
    }];
}

-(void) hideViewY {
    CGRect frame = self.frame;
    
    frame.origin.y += 450;
    
    [UIView animateWithDuration: 0.6 animations: ^{
        self.frame = frame;
    }];
}

- (void) hideWithSender {
    [sender hideView];
}

-(void) hideView {
    CGRect frame = self.frame;
    
    frame.origin.x -= frame.size.width;
    
    [UIView animateWithDuration: 0.6 animations: ^{
        self.frame = frame;
    }];
}



- (IBAction)switch:(id)sender {
    [self hideWithSender];
}


@end
