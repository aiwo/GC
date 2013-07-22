//
//  GCPullView.m
//  GC
//
//  Created by Gennady Berezovsky on 24.06.13.
//  Copyright (c) 2013 Gennady Berezovsky. All rights reserved.
//

#import "GCPullView.h"
#import "GCDayCell.h"

@interface GCPullView ()

@property (nonatomic, strong) GCBottomCalendarView *bottomView;

@end

@implementation GCPullView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 20)];
        topView.backgroundColor = [UIColor redColor];
        [self addSubview:topView];
        
        self.bottomView = [[GCBottomCalendarView alloc] initWithFrame:CGRectMake(0, 20, frame.size.width, frame.size.height-20)];
        [self addSubview:self.bottomView];
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *comp = [calendar components:NSWeekCalendarUnit fromDate:[NSDate date]];
        [self.bottomView setDaysWithWeekNumber:comp.week];
    }
    return self;
}

- (void)setDelegate:(id<UIScrollViewDelegate>)delegate
{
    _delegate = delegate;
    self.bottomView.delegate = self.delegate;
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
        self.showsHorizontalScrollIndicator = YES;
        self.alwaysBounceHorizontal = YES;
        self.pagingEnabled = YES;
    }
    
    return self;
}

- (void)setDaysWithWeekNumber:(int)weekNumber
{
    NSArray *array = [self allDatesInWeek:weekNumber];
    
    for (NSDate *date in array) {
        GCDayCell *dayCell = [GCDayCell cellWithDate:date];
        dayCell.left = [array indexOfObject:date]*dayCell.width;
        [self addSubview:dayCell];
        
        if ([array indexOfObject:date] < 7 && [array indexOfObject:date] > 0) {
            UIView *separator = [[UIView alloc] initWithFrame:CGRectMake([array indexOfObject:date]*dayCell.width, 0, 1, self.height)];
            separator.backgroundColor = [UIColor blackColor];
            [self addSubview:separator];
        }
    }
    self.contentSize = CGSizeMake(self.width, self.height);
}

- (NSArray *)allDatesInWeek:(int)weekNumber {

    NSCalendar *greg = [[NSCalendar alloc]
                        initWithCalendarIdentifier:NSGregorianCalendar];

    NSDateComponents *comps = [[NSDateComponents alloc] init];
    comps.day = 1;
    
    NSDate *today = [NSDate date];
    NSDate *tomorrow = [greg dateByAddingComponents:comps toDate:today options:0];
    
    const NSTimeInterval kDay = [tomorrow timeIntervalSinceDate:today];
    
    comps = [greg components:NSYearCalendarUnit fromDate:[NSDate date]];
    comps.day = 1;
    comps.month = 1;
    comps.hour = 12;
    
    NSDate *start = [greg dateFromComponents:comps];
    comps = [greg components:NSWeekdayCalendarUnit fromDate:start];
    if (weekNumber == 1) {
        start = [start dateByAddingTimeInterval:-kDay*(comps.weekday-1)];
    } else {
        start = [start dateByAddingTimeInterval:
                 kDay*(9-comps.weekday+7*(weekNumber-2))];
    }
    
    NSMutableArray *result = [NSMutableArray array];
    for (int i = 0; i<7; i++) {
        [result addObject:[start dateByAddingTimeInterval:kDay*i]];
    }
    
    return [NSArray arrayWithArray:result];
}

@end
