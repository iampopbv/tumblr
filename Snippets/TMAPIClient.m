/*
 * Get the user blog url
 */
[[TMAPIClient sharedInstance] userInfo:^(id result, NSError *error) {
    if (!error){
        NSString* userDescription = [[result valueForKeyPath:@"user.blogs.url"]firstObject];
        NSLog(@"\nBlog url: %@", userDescription);
    }else{
        NSLog(@"No user info!!!");
    }
}];
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/*
 * Get the posts
 */
NSArray* paramsKeys = [[NSArray alloc] initWithObjects:
                       @"limit",
                       @"offset",
                       @"type",
                       nil];
NSArray* paramsVals = [[NSArray alloc] initWithObjects:
                       [[NSString alloc] initWithFormat:@"%i", limitNextPage],
                       [[NSString alloc] initWithFormat:@"%i", _dashboardOffsetAudio],
                       @"video",
                       nil];
NSDictionary *paramsDict = [[NSDictionary alloc]initWithObjects:paramsVals forKeys:paramsKeys];
NSMutableArray<Post> *posts = (NSMutableArray<Post> *)[[NSMutableArray alloc] init];

[[TMAPIClient sharedInstance]dashboard:paramsDict callback:^(id response, NSError *error){
    if(!error) {
        NSDictionary *dashboard = response;
        NSLog(@"%@", dashboard);
    }
}];