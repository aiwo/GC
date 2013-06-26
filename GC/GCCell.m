//
//  GCCell.m
//  GC
//
//  Created by Gennady Berezovsky on 26.06.13.
//  Copyright (c) 2013 Gennady Berezovsky. All rights reserved.
//

#import "GCCell.h"

@implementation GCCell

+ (NSString *)reuseIdentifier
{
    return NSStringFromClass([self class]);
}

@end
