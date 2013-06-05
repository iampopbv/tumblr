//
//  PostSorter.m
//  ShufflerTumblr
//
//  Created by Casper Eekhof on 04-06-13.
//  Copyright (c) 2013 stud. All rights reserved.
//

#import "PostSorter.h"

@implementation PostSorter

-(void) sortPostsOnTime: (NSArray<Post>*) posts {
    for(id<Post> post in posts){
        
    }
}


void quicksortInPlace(NSMutableArray<Post> *array, const long first, const long last) {
    if (first >= last) return;
    NSValue *pivot = array[(first + last) / 2];
    long left = first;
    long right = last;
    while (left <= right) {
        while (array[left] < pivot)
            left++;
        while (array[right] > pivot)
            right--;
        if (left <= right)
            [array exchangeObjectAtIndex:left++ withObjectAtIndex:right--];
    }
    quicksortInPlace(array, first, right);
    quicksortInPlace(array, left, last);
}

NSArray* quicksort(NSArray *unsorted) {
    NSMutableArray *a = [NSMutableArray arrayWithArray:unsorted];
    quicksortInPlace(a, 0, a.count - 1);
    return a;
}


@end
