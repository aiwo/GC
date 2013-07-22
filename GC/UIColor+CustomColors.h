//
//  UIColor+CustomColors.h
//  GC
//
//  Created by Gennady Berezovsky on 27.06.13.
//  Copyright (c) 2013 Gennady Berezovsky. All rights reserved.
//

#import <UIKit/UIKit.h>

#define WCOLOR(w) [UIColor colorWithWhite:(w)/255.0f alpha:1]
#define WACOLOR(w, a) [UIColor colorWithWhite:(w)/255.0f alpha:(a)]
#define RGBCOLOR(r, g, b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r, g, b, a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

@interface UIColor (CustomColors)

+ (UIColor *)activeEventTextColor;
+ (UIColor *)inactiveEventTextColor;

@end
