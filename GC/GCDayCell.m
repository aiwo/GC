//
//  GCDayCell.m
//  GC
//
//  Created by Gennady Berezovsky on 27.06.13.
//  Copyright (c) 2013 Gennady Berezovsky. All rights reserved.
//

#import "GCDayCell.h"

@interface GCDayCell ()

@property (strong, nonatomic) IBOutlet UILabel *dayNumberLabel;
@property (strong, nonatomic) IBOutlet UILabel *weekDayLabel;

@end

@implementation GCDayCell

static NSCalendar *calendar;
static NSDateFormatter *formatter;

+ (void)initialize
{
    calendar = [NSCalendar currentCalendar];
    formatter = [NSDateFormatter new];
    formatter.dateFormat = @"eee";
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ru_RU"];
}

+ (GCDayCell *)cellWithDate:(NSDate *)date
{
    GCDayCell *cell = [[NSBundle mainBundle] loadNibNamed:@"GCDayCell" owner:0 options:0][0];
    cell.date = date;
    return cell;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.dayNumberLabel.font = [UIFont regularFontWithSize:17];
    self.weekDayLabel.font = [UIFont regularFontWithSize:10];
    self.weekDayLabel.textColor = self.dayNumberLabel.textColor = [UIColor activeEventTextColor];
}

- (void)setDate:(NSDate *)date
{
    _date = date;
    
    NSDateComponents *components = [calendar components:NSDayCalendarUnit | NSWeekdayCalendarUnit fromDate:date];
    self.dayNumberLabel.text = [@(components.day) stringValue];
    self.weekDayLabel.text = [formatter shortStandaloneWeekdaySymbols][components.weekday-1];// [@([calendar ordinalityOfUnit:NSWeekdayCalendarUnit inUnit:NSWeekCalendarUnit forDate:date]) stringValue];
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
