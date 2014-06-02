//
//  SitesViewController.m
//  ShufflerForTumblr
//
//  Created by Adrian Zborowski on 19/05/14.
//  Copyright (c) 2014 Hogeschoool van Amsterdam. All rights reserved.
//

#import "TMApiClient.h"
#import "SitesViewController.h"
#import "AudioPost.h"

@interface SitesViewController ()

@end

@implementation SitesViewController{
    NSArray *tableData;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    tableData = [NSArray arrayWithObjects:@"Egg Benedict", @"Mushroom Risotto", @"Full Breakfast", @"Hamburger", @"Ham and Egg Sandwich", @"Creme Brelee", @"White Chocolate Donut", @"Starbucks Coffee", @"Vegetable Curry", @"Instant Noodle with Egg", @"Noodle with BBQ Pork", @"Japanese Noodle with Pork", @"Green Tea", @"Thai Shrimp Cake", @"Angry Birds Cake", @"Ham and Cheese Panini", nil];
}

/**
 */
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

/**
 */
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [tableData count];
}

/**
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // [UIColor colorWithRed:44/255.0 green:71/255.0 blue:98/255.0 alpha:1.0]
    
    static NSString *cellIdentifier = @"siteCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    cell.textColor = [UIColor whiteColor];
    
    return cell;
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{}

@end
