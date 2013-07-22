//
//  GCPullView.h
//  GC
//
//  Created by Gennady Berezovsky on 24.06.13.
//  Copyright (c) 2013 Gennady Berezovsky. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    GCPullViewStateClosed = 0,
    GCPullViewStateOpened = 1
} GCPullViewState;

@interface GCPullView : UIView <UIScrollViewDelegate>

@property (nonatomic, assign) GCPullViewState state;
@property (nonatomic, assign) id<UIScrollViewDelegate> delegate;

@end

@interface GCBottomCalendarView : UIView

- (void)setDaysWithWeekNumber:(int)weekNumber;

@end
