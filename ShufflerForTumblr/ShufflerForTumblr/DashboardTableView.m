//
//  DashboardTableView.m
//  ShufflerForTumblr
//
//  Created by Adrian Zborowski on 09/05/14.
//  Copyright (c) 2014 Hogeschoool van Amsterdam. All rights reserved.
//

#import "DashboardTableView.h"
#import "Post.h"

@implementation DashboardTableView{
    NSMutableArray *_posts;
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _posts = [NSMutableArray arrayWithCapacity:20];
        
        Post *post = [[Post alloc] init];
        post.username   = @"a";
        post.timestamp  = @"a";
        post.profile    = @"a";
        post.image      = @"a";
        post.title      = @"a";
        post.notes      = @"a";
        [_posts addObject:post];
        
        post = [[Post alloc] init];
        post.username   = @"b";
        post.timestamp  = @"b";
        post.profile    = @"b";
        post.image      = @"b";
        post.title      = @"b";
        post.notes      = @"b";
        [_posts addObject:post];
        
        self.posts = _posts;
    }
    return self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.posts count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell"];
    
    Post *post = (self.posts)[indexPath.row];
    cell.textLabel.text = post.username;
    cell.detailTextLabel.text = post.timestamp;
    
    return cell;
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
