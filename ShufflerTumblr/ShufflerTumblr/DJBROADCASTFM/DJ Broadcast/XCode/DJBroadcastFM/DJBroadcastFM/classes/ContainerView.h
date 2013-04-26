//
//  TestView.h
//  DJBroadcastFM
//
//  Created by Casper Eekhof on 17-04-13.
//  Copyright (c) 2013 Casper. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContainerView : UIView

-(void) showView;
-(void) showWithSender: id;
-(void) hideView;
-(void) showViewY;
-(void) hideViewY;

@end
