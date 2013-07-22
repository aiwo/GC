//
//  UIFont+CustomFonts.h
//  GC
//
//  Created by Gennady Berezovsky on 27.06.13.
//  Copyright (c) 2013 Gennady Berezovsky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (CustomFonts)

+ (UIFont *)boldFontWithSize:(CGFloat)size;
+ (UIFont *)boldItalicFontWithSize:(CGFloat)size;
+ (UIFont *)blackFontWithSize:(CGFloat)size;
+ (UIFont *)blackItalicFontWithSize:(CGFloat)size;
+ (UIFont *)italicFontWithSize:(CGFloat)size;
+ (UIFont *)mediumFontWithSize:(CGFloat)size;
+ (UIFont *)mediumItalicFontWithSize:(CGFloat)size;
+ (UIFont *)narrowBoldFontWithSize:(CGFloat)size;
+ (UIFont *)narrowMediumFontWithSize:(CGFloat)size;
+ (UIFont *)regularFontWithSize:(CGFloat)size;
+ (UIFont *)lightFontWithSize:(CGFloat)size;
+ (UIFont *)lightItalicFontWithSize:(CGFloat)size;

@end
