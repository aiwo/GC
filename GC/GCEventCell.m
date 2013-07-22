//
//  GCEventCell.m
//  GC
//
//  Created by Gennady Berezovsky on 25.06.13.
//  Copyright (c) 2013 Gennady Berezovsky. All rights reserved.
//

#import "GCEventCell.h"
#import "GTLCalendarEvent.h"
#import "GTLCalendarEventDateTime.h"
#import "GTLDateTime.h"
#import <QuartzCore/QuartzCore.h>

@interface GCEventCell()

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *detailLabel;
@property (strong, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *endTimeLabel;
@property (strong, nonatomic) IBOutlet UIImageView *colorDotView;


@end

@implementation GCEventCell

static NSDateFormatter *formatter;

+ (void)initialize
{
    formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"HH:mm"];
}

- (void)awakeFromNib
{
    self.startTimeLabel.font = [UIFont regularFontWithSize:11];
    self.endTimeLabel.font = [UIFont regularFontWithSize:9];
    self.titleLabel.font = [UIFont regularFontWithSize:17];
    self.detailLabel.font = [UIFont regularFontWithSize:11];
}

- (void)layoutSubviews
{
    self.colorDotView.layer.cornerRadius = self.colorDotView.height / 2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setEvent:(GTLCalendarEvent *)event
{
    _event = event;
    
    UIColor *textColor = nil;
    if ([event.start.dateTime.date compare:[NSDate date]] == NSOrderedDescending) {
        textColor = [UIColor activeEventTextColor];
    } else {
        textColor = [UIColor inactiveEventTextColor];
    }
        
    NSDictionary *attributes = @{NSForegroundColorAttributeName : textColor};
    [self.titleLabel replaceAttributedTextWithString:event.summary andAttributes:attributes];
    [self.detailLabel replaceAttributedTextWithString:event.descriptionProperty andAttributes:attributes];
    
    self.startTimeLabel.textColor = self.endTimeLabel.textColor = textColor;
    self.startTimeLabel.text = [formatter stringFromDate:event.start.dateTime.date];
    self.endTimeLabel.text = [formatter stringFromDate:event.end.dateTime.date];
}

@end
