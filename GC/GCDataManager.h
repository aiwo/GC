//
//  GCDataManager.h
//  GC
//
//  Created by Gennady Berezovsky on 25.06.13.
//  Copyright (c) 2013 Gennady Berezovsky. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GTMOAuth2Authentication, GTLCalendarCalendarList, GTLCalendarEvents;

@interface GCDataManager : NSObject

+ (GCDataManager *)sharedManager;
- (BOOL)isSignedIn;
- (void)authorize;

- (GTLCalendarCalendarList *)calendars;
- (GTLCalendarEvents *)eventsForCalendarId:(NSString *)calendarId;

- (void)getCalendarsOnSucess:(ActionBlock)onSuccess onFailure:(FailureBlock)onFailure;
- (void)getEventsForCalendarId:(NSString *)calendarId onSuccess:(ActionBlock)onSuccess onFailure:(FailureBlock)onFailure;

@end
