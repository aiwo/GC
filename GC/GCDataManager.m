//
//  GCDataManager.m
//  GC
//
//  Created by Gennady Berezovsky on 25.06.13.
//  Copyright (c) 2013 Gennady Berezovsky. All rights reserved.
//

#import "GCDataManager.h"

#import <GTMOAuth2Authentication.h>
#import <GTMOAuth2ViewControllerTouch.h>

#import "GTLQueryCalendar.h"
#import "GTLServiceCalendar.h"
#import "GTLCalendarCalendarList.h"
#import "GTLCalendarConstants.h"
#import "GTLCalendarCalendarListEntry.h"
#import "GTLCalendarEvents.h"

@interface GCDataManager()

@property (nonatomic, strong) GTLServiceCalendar *service;
@property (nonatomic, strong) GTLCalendarCalendarList *calendars;
@property (nonatomic, strong) NSMutableDictionary *events;

@end

@implementation GCDataManager

NSString *const kKeychainItemName = @"CalendarSample: Google Calendar";

 + (GCDataManager *)sharedManager
{
    static dispatch_once_t onceToken;
    static GCDataManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [GCDataManager new];
    });
    return instance;
}

- (id)init
{
    if (self = [super init]) {
        self.service = [[GTLServiceCalendar alloc] init];
        self.service.authorizer = [GTMOAuth2ViewControllerTouch authForGoogleFromKeychainForName:kKeychainItemName
                                                                          clientID:kClientId
                                                                      clientSecret:kClientSecret];
        
    }
    return self;
}

- (void)authorize
{
    if (!self.isSignedIn) {
        GTMOAuth2ViewControllerTouch *controller = [GTMOAuth2ViewControllerTouch controllerWithScope:kGTLAuthScopeCalendar clientID:kClientId clientSecret:kClientSecret keychainItemName:kKeychainItemName completionHandler:^(GTMOAuth2ViewControllerTouch *viewController, GTMOAuth2Authentication *auth, NSError *error) {
            self.service.authorizer = auth;
            [[UIViewController topViewController] dismissModalViewControllerAnimated:YES];
        }];
        controller.showsInitialActivityIndicator = YES;
        [[UIViewController topViewController] presentModalViewController:controller animated:YES];
    }
}

- (NSString *)signedInUsername {
    // Get the email address of the signed-in user
    GTMOAuth2Authentication *auth = self.service.authorizer;
    BOOL isSignedIn = auth.canAuthorize;
    if (isSignedIn) {
        return auth.userEmail;
    } else {
        return nil;
    }
}

- (BOOL)isSignedIn {
    NSString *name = [self signedInUsername];
    return (name != nil);
}

#pragma mark - Getters

- (GTLCalendarCalendarList *)calendars
{
    return self.calendars;
}

- (GTLCalendarEvents *)eventsForCalendarId:(NSString *)calendarId
{
    return self.events[calendarId];
}

#pragma mark - Loader Methods

- (void)getCalendarsOnSucess:(ActionBlock)onSuccess onFailure:(FailureBlock)onFailure
{
    GTLQueryCalendar *query = [GTLQueryCalendar queryForCalendarListList];
    query.minAccessRole = kGTLCalendarMinAccessRoleOwner;
    
    [self.service executeQuery:query completionHandler:^(GTLServiceTicket *ticket, id calendarList, NSError *error) {
        self.calendars = calendarList;
        onSuccess();
    }];
}

- (void)getEventsForCalendarId:(NSString *)calendarId onSuccess:(ActionBlock)onSuccess onFailure:(FailureBlock)onFailure
{
    GTLQueryCalendar *q = [GTLQueryCalendar queryForEventsListWithCalendarId:calendarId];
    [self.service executeQuery:q completionHandler:^(GTLServiceTicket *ticket, id object, NSError *error) {
        if (!error) {
            [self.events setObject:object forKey:calendarId];
            onSuccess();
        } else {
            onFailure(error);
        }
    }];
}

@end
