//
//  DetailViewController.h
//  ShufflerTumblr
//
//  Created by stud on 4/17/13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end