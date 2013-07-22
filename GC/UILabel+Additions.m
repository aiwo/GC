//
//  UILabel+Additions.m
//  GC
//
//  Created by Gennady Berezovsky on 27.06.13.
//  Copyright (c) 2013 Gennady Berezovsky. All rights reserved.
//

#import "UILabel+Additions.h"

@implementation UILabel (Additions)

- (void)replaceAttributedTextWithString:(NSString *)string
{
    [self replaceAttributedTextWithString:string andAttributes:nil];
}

- (void)replaceAttributedTextWithString:(NSString *)string andAttributes:(NSDictionary *)attributes
{
    NSMutableAttributedString *mString = [self.attributedText mutableCopy];
    
    if (attributes) {
        [mString setAttributes:attributes range:NSMakeRange(0, mString.length)];
    }
    
    [mString replaceCharactersInRange:NSMakeRange(0, mString.length) withString:string];
    self.attributedText = mString;
}
@end
