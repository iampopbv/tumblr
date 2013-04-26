//
//  MenuViewController.h
//  DJBroadcastFM
//
//  Created by Casper Eekhof on 25-03-13.
//  Copyright (c) 2013 Casper. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "MusicTile.h"
#import "DJBroadcastDB.h"
#import "ContainerView.h"
#import "DetailViewController.h"

@interface MenuViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *upSwipeGesture;
@property (strong, nonatomic) IBOutlet UISwipeGestureRecognizer *downSwipeGesture;



@property NSMutableArray *releases; // the releases that should be shown on the collection view.
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
- (IBAction)swipedUp:(id)sender;
- (IBAction)swipedDown:(id)sender;
@property (weak, nonatomic) IBOutlet ContainerView *infoPageContainer;

@property BOOL loadedView;
@property BOOL infoPageIsShowing;
@property DetailViewController * detailVC;
@property (weak, nonatomic) IBOutlet ContainerView *detailViewAndContainer;
@property (weak, nonatomic) IBOutlet UIButton *focusButton;
- (IBAction)focusButtonTouchedUpInside:(id)sender;

@end
