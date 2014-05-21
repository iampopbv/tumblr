//
//  DashboardViewController.m
//  ShufflerForTumblr
//
//  Created by Adrian Zborowski on 09/05/14.
//  Copyright (c) 2014 Hogeschoool van Amsterdam. All rights reserved.
//

#import "DashboardViewController.h"
#import "TMAPIClient.h"

@interface DashboardViewController ()

@end

@implementation DashboardViewController{
    NSArray *tableData;
}

/**
 */
- (void)viewDidLoad{
    [super viewDidLoad];
    
    [[TMAPIClient sharedInstance] userInfo:^(id result, NSError *error) {
        if (!error){
            NSString* userDescription = [[result valueForKeyPath:@"user.blogs.url"]firstObject];
            NSLog(@"\nBlog url: %@", userDescription);
        }else{
            NSLog(@"No user info!!!");
        }
    }];
    
    tableData = [NSArray arrayWithObjects:@"Egg Benedict", @"Mushroom Risotto", @"Full Breakfast", @"Hamburger", @"Ham and Egg Sandwich", @"Creme Brelee", @"White Chocolate Donut", @"Starbucks Coffee", @"Vegetable Curry", @"Instant Noodle with Egg", @"Noodle with BBQ Pork", @"Japanese Noodle with Pork", @"Green Tea", @"Thai Shrimp Cake", @"Angry Birds Cake", @"Ham and Cheese Panini", nil];
}

/**
 */
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [tableData count];
}

/**
 */
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

/**
 */
//-(CGFloat)tableView:(UITableView *)aTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 262.0;
//}

/**
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // [UIColor colorWithRed:44/255.0 green:71/255.0 blue:98/255.0 alpha:1.0]
    
    static NSString *cellIdentifier = @"dashCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    /// Cell background color
    [cell setBackgroundColor:[UIColor clearColor]];
    
    UIImageView *cellBackView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 220)];
    cellBackView.backgroundColor = [UIColor clearColor];
    cellBackView.image = [UIImage imageNamed:@"cellBackground.png"];
    cell.backgroundView = cellBackView;
    
    /// Selection color
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    cell.textColor = [UIColor whiteColor];
    //cell.imageView.image = [UIImage imageNamed:@"kingler-krabby.png"];
    
    return cell;
}

/**
 */
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 42;
//}

/**
 */
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 42.0)];
    
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    headerLabel.backgroundColor = [UIColor whiteColor];
    headerLabel.opaque = NO;
    headerLabel.textColor = [UIColor blackColor];
    headerLabel.font = [UIFont boldSystemFontOfSize:12];
    headerLabel.frame = CGRectMake(20.0, 0.0, 320.0, 42.0);
    headerLabel.text = [tableData objectAtIndex:0];
    [customView addSubview:headerLabel];
    
    UIImageView *titleImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"placeholder.png"]];
    CGRect imageViewRect = CGRectMake(0.0,  0.0, 42.0 , 42.0);
    titleImage.frame = imageViewRect;
    //titleImage.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    [customView addSubview:titleImage];
    
    return customView;
}

/**
 */
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}

/**
 */
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 5.0)];
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    headerLabel.backgroundColor = [UIColor colorWithRed:44/255.0 green:71/255.0 blue:98/255.0 alpha:1.0];
    headerLabel.opaque = NO;
    //headerLabel.frame = CGRectMake(0.0, 0.0, 320.0, 5.0);
    [customView addSubview:headerLabel];
    
    return customView;
}

#pragma mark - Navigation
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

@end
