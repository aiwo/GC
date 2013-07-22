//
//  GCDayCell.h
//  GC
//
//  Created by Gennady Berezovsky on 27.06.13.
//  Copyright (c) 2013 Gennady Berezovsky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GCDayCell : UIView

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, assign) NSInteger eventCounter;

+ (GCDayCell *)cellWithDate:(NSDate *)date;

@end
