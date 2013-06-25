//
//  GCEventCell.m
//  GC
//
//  Created by Gennady Berezovsky on 25.06.13.
//  Copyright (c) 2013 Gennady Berezovsky. All rights reserved.
//

#import "GCEventCell.h"

@implementation GCEventCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
