//
//  DashboardTableView.m
//  ShufflerForTumblr
//
//  Created by Adrian Zborowski on 09/05/14.
//  Copyright (c) 2014 Hogeschoool van Amsterdam. All rights reserved.
//

#import "DashboardTableView.h"
#import "AudioPost.h"

/**
 */
@implementation DashboardTableView{
    NSMutableArray *_posts;
}

/**
 */
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    return self;
}

/**
 */
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

/**
 */
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.posts count];
}

/**
 */
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell"];
    
    return cell;
}

@end
