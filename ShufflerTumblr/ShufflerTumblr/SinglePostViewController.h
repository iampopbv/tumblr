//
//  SinglePostViewController.h
//  ShufflerTumblr
//
//  Created by Casper Eekhof on 13-06-13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

@interface SinglePostViewController : UIViewController

@property id<Post> post;

@property (weak, nonatomic) IBOutlet UIView *playerContainer;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIWebView *videoView;
@property (weak, nonatomic) IBOutlet UIButton *sharebutton;


- (IBAction)sharebuttonpressed:(id)sender;


@end
