//
//  MenuViewController.m
//  DJBroadcastFM
//
//  Created by Casper Eekhof on 25-03-13.
//  Copyright (c) 2013 Casper. All rights reserved.
//

#import "MenuViewController.h"
//@interface MenuViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
//
//
//@end


@implementation MenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _loadedView = false;
    _infoPageIsShowing = false;
	// Do any additional setup after loading the view, typically from a nib.
    
    _releases = [[NSMutableArray alloc] init];
    
    
    int listArray[] = {1, 2, 3, 4};
    [self downloadAndDisplayLists:listArray amountOflists: 4];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) downloadAndDisplayLists: (int[]) listIds amountOflists: (int) nrOfPages{
    DJBroadcastDB *db = [[DJBroadcastDB alloc] init];
    for(int i = 0; i < nrOfPages; i++){
        [db getListData: listIds[i] completionBlock:^(NSArray *releases, NSError *error) {
            if(!error){
                [_releases addObjectsFromArray: releases];
                
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    // reload the data
                    [_collectionView reloadData];
                    if(i == nrOfPages -1) {
                        _loadedView = true;
                    }
                });
                
            } else {
                UIAlertView *someError = [[UIAlertView alloc] initWithTitle: @"Error" message: @"Er is geen netwerk connectie" delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil];
                
                [someError show];
            }
            
        }];
    }
    
}


// These are the methods called by iOS in order to generate the content for the UICollectionView

#pragma mark - UICollectionView Datasource
// Returns the number of cells to be displayed for a given section.
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return [self.releases count];
}
// Returns the total number of sections
- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}
// Is responsible for returning the cell at a given index path.
- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MusicTile *cell = [cv dequeueReusableCellWithReuseIdentifier:@"MusicTileCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    [cell displayRelease: [_releases objectAtIndex:[indexPath row]]];
    return cell;
}



// It is responsible for returning a view for either the header or footer for each section of the UICollectionView.
-(UICollectionReusableView *)collectionView:
(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    return [[UICollectionReusableView alloc] init];
}


//#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(_loadedView){ // do not show the release when the collection view is not done loading the cells.
        if(_infoPageIsShowing){
            [_infoPageContainer hideViewY];
            _infoPageIsShowing = false;
        }
        // TODO: Select Item
        //    [_detailContainer showWithSender: _detailContainer];
        [_detailVC showViewAndDisplayRelease: [_releases objectAtIndex: [indexPath item]]];
        
        // Deselect
        [_collectionView deselectItemAtIndexPath:indexPath animated: YES];
        
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Deselect item
}

- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

- (IBAction)swipedUp:(id)sender {
    if(!_infoPageIsShowing) {
        [_infoPageContainer showViewY];
        _infoPageIsShowing = true;
    }
}

- (IBAction)swipedDown:(id)sender {
    if(_infoPageIsShowing) {
        [_infoPageContainer hideViewY];
        _infoPageIsShowing = false;
    }
}




- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString * segueName = [segue identifier];
    
    
    // Link the view controller DetailVC via the segue (after this we can pass the container to the DetailVC).
    if ([segueName isEqualToString: @"embed_detailpage"]) {
        UIViewController * childViewController = (UIViewController *) [segue destinationViewController];
        DetailViewController * ddv = (DetailViewController*) childViewController;
        _detailVC = ddv;
        
        [_detailVC setParentContainer: _detailViewAndContainer];
    }
}
@end
