//
//  UILabel+Additions.h
//  GC
//
//  Created by Gennady Berezovsky on 27.06.13.
//  Copyright (c) 2013 Gennady Berezovsky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Additions)

- (void)replaceAttributedTextWithString:(NSString *)string;
- (void)replaceAttributedTextWithString:(NSString *)string andAttributes:(NSDictionary *)attributes;

@end
