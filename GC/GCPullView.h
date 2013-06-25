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

@interface GCPullView : UIView

@property (nonatomic, assign) GCPullViewState state;

@end

@interface GCBottomCalendarView : UIScrollView

@end
