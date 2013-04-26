//
//  DetailDescriptionContainerView.h
//  DJBroadcastFM
//
//  Created by Casper Eekhof on 03-04-13.
//  Copyright (c) 2013 Casper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Release.h"

 
@interface DetailDescriptionView : UIView
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *artist;

- (void) displayRelease: (id<Release>) release;

@end
