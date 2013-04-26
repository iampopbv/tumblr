//
//  DetailVC.h
//  DJBroadcastFM
//
//  Created by Casper Eekhof on 18-04-13.
//  Copyright (c) 2013 Casper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContainerView.h"
#import "Release.h"
#import "RateBar.h"
#import "TopbarView.h"
#import "Album.h"

@interface DetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) ContainerView * parentContainer;
@property BOOL expanded;
@property BOOL dragging;
@property int oldX;


@property id<Release> release;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *swipeLeft;


- (IBAction)closeButtonTouchUpInside:(id)sender;
- (IBAction)swipedLeft:(id)sender;
- (void) showViewAndDisplayRelease: (id<Release>) release;



@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *type;
@property (weak, nonatomic) IBOutlet UILabel *duration;
@property (weak, nonatomic) IBOutlet UILabel *filter;
@property (weak, nonatomic) IBOutlet UILabel *genre;
@property (weak, nonatomic) IBOutlet RateBar *ratebar;
@property (weak, nonatomic) IBOutlet UILabel *descriptionText;
@property (weak, nonatomic) IBOutlet UITableView *tracklist;

@end
