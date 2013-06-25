//
//  GCPullView.m
//  GC
//
//  Created by Gennady Berezovsky on 24.06.13.
//  Copyright (c) 2013 Gennady Berezovsky. All rights reserved.
//

#import "GCPullView.h"

@implementation GCPullView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 20)];
        topView.backgroundColor = [UIColor redColor];
        [self addSubview:topView];
        
        UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, frame.size.width, frame.size.height-20)];
        [self addSubview:bottomView];
    }
    return self;
}

- (void)setState:(GCPullViewState)state
{
    _state = state;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

@implementation GCBottomCalendarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.showsVerticalScrollIndicator = NO;
    }
    return self;
}

@end
