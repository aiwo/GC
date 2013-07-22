//
//  UIFont+CustomFonts.m
//  GC
//
//  Created by Gennady Berezovsky on 27.06.13.
//  Copyright (c) 2013 Gennady Berezovsky. All rights reserved.
//

#import "UIFont+CustomFonts.h"

@implementation UIFont (CustomFonts)

+ (UIFont *)boldFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"GothamPro-Bold" size:size];
}

+ (UIFont *)boldItalicFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"GothamPro-BoldItalic" size:size];
}

+ (UIFont *)blackFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"GothamPro-Black" size:size];
}

+ (UIFont *)blackItalicFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"GothamPro-BlackItalic" size:size];
}

+ (UIFont *)italicFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"GothamPro-Italic" size:size];
}

+ (UIFont *)mediumFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"GothamPro-Medium" size:size];
}

+ (UIFont *)mediumItalicFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"GothamPro-MediumItalic" size:size];
}

+ (UIFont *)narrowBoldFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"GothamProNarrow-Bold" size:size];
}

+ (UIFont *)narrowMediumFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"GothamProNarrow-Medium" size:size];
}

+ (UIFont *)regularFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"GothamPro" size:size];
}

+ (UIFont *)lightFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"GothamPro-Light" size:size];
}

+ (UIFont *)lightItalicFontWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"GothamPro-LightItalic" size:size];
}

@end
