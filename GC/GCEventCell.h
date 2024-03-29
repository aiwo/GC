//
//  GCEventCell.h
//  GC
//
//  Created by Gennady Berezovsky on 25.06.13.
//  Copyright (c) 2013 Gennady Berezovsky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GCCell.h"

@class GTLCalendarEvent;

@interface GCEventCell : GCCell

@property (nonatomic, strong) GTLCalendarEvent *event;

@end
