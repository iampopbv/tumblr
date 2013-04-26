//
//  Tile.m
//  DJBroadcastFM
//
//  Created by Casper Eekhof on 27-03-13.
//  Copyright (c) 2013 Casper. All rights reserved.
//

#import "MusicTile.h"

@implementation MusicTile

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


-(void) displayRelease: (id <Release>) release
{
    
    NSMutableString *artiststring = [[NSMutableString alloc] init];
    for(NSString *artist in [release artists])
    {
        //        NSLog(@"Artist: %@", )
        [artiststring appendFormat:@"%@ ", artist];
    }
    
    //    NSString * className = [release ];
    
    
    NSString *text;
    NSString *typeName;
    
    ReleaseType t = [release type];
    
    if (t == ALBUM) {
        typeName = @"Album";
    }
    if (t == MIX) {
        typeName = @"DJ Mix";
    }
    if (t == TRACK) {
        typeName = @"Track";
    }
    if (t == PLAYLIST) {
        typeName = @"Playlist";
    }
    
    if(![artiststring length] == 0){
        text = [[NSString alloc] initWithFormat:@"%@ • %@ - %@", typeName, artiststring, [release title]];
    } else {
        text = [[NSString alloc] initWithFormat:@"%@ • %@", typeName, [release title]];
        [_title setText: [release title]];
    }
    
    [_photo setImage: [release image]];
    
    
    

    if ([_title respondsToSelector:@selector(setAttributedText:)])
    {
        // iOS6 and above : Use NSAttributedStrings
        UIFont *boldFont = [UIFont fontWithName:@"Lucida Grande Bold" size: (CGFloat) 14];
        UIFont *regularFont = [UIFont fontWithName:@"Lucida Grande" size: (CGFloat) 15];
        UIColor *foregroundColor = [UIColor whiteColor];
        
        // Create the attributes
        NSDictionary *attrs = [NSDictionary dictionaryWithObjectsAndKeys:
                               boldFont, NSFontAttributeName,
                               foregroundColor, NSForegroundColorAttributeName, nil];
        NSDictionary *subAttrs = [NSDictionary dictionaryWithObjectsAndKeys:
                                  regularFont, NSFontAttributeName, nil];

        const NSRange range = NSMakeRange(0, [typeName length]+2);
        
        // Create the attributed string (text + attributes)
        NSMutableAttributedString *attributedText =
        [[NSMutableAttributedString alloc] initWithString: text
                                               attributes:subAttrs];
        [attributedText setAttributes:attrs range:range];
        
        // Set it in our UILabel and we are done!
        [_title setAttributedText:attributedText];
    } else {
        // iOS5 and below
        // Here we have some options too. The first one is to do something
        // less fancy and show it just as plain text without attributes.
        // The second is to use CoreText and get similar results with a bit
        // more of code. Interested people please look down the old answer.
        
        // Now I am just being lazy so :p
        [_title setText: text];
        
    }
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect
//{
//    // Drawing code
//}


@end
