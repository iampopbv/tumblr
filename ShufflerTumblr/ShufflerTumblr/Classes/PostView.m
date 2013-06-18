//
//  PostView.m
//  ShufflerTumblr
//
//  Created by Casper Eekhof on 18-06-13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import "PostView.h"

@implementation PostView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (PostView*) createPostView {
    PostView *postViewClone;
    postViewClone = [[[NSBundle mainBundle] loadNibNamed:@"PostView" owner:self options:nil] objectAtIndex: 0];
    
    return postViewClone;
}



- (void) setupPost: (id<Post>) post {
    
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
