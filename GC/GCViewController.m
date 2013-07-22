//
//  GCViewController.m
//  GC
//
//  Created by Gennady Berezovsky on 24.06.13.
//  Copyright (c) 2013 Gennady Berezovsky. All rights reserved.
//

#import "GCViewController.h"
#import "GCDataManager.h"

#import "GTLCalendarCalendarListEntry.h"
#import "GTLCalendarCalendarList.h"
#import "GTLCalendarEvents.h"
#import "GTLCalendarEvent.h"

#import "GCPullView.h"
#import "GCEventCell.h"



@interface GCViewController ()

@property (nonatomic, assign) GCDataManager *dataManager;
@property (nonatomic, assign) GTLCalendarCalendarListEntry *activeCalendar;
@property (nonatomic, strong) GCPullView *pullView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end


@implementation GCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.pullView = [[GCPullView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 100)];
    self.pullView.delegate = self;
    [self.view insertSubview:self.pullView aboveSubview:self.tableView];
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.pullView addGestureRecognizer:panRecognizer];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.pullView.top = self.view.height-20;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.dataManager authorize];
    [self.dataManager getCalendarsOnSucess:^{
        self.activeCalendar = [GCDataManager sharedManager].calendars[0];
        [self.dataManager getEventsForCalendarId:self.activeCalendar.identifier onSuccess:^{
            [self.tableView reloadData];
        } onFailure:[self defaultFailureBlock]];
    } onFailure:[self defaultFailureBlock]];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods

- (GCDataManager *)dataManager
{
    return [GCDataManager sharedManager];
}

#pragma mark - UIScrollViewDelegate

CGPoint lastOffset;
NSTimeInterval lastOffsetCapture;
BOOL isScrollingFast;

- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    float point = scrollView.contentOffset.x * 2 + lastOffset.x;
    CGPoint currentOffset = scrollView.contentOffset;

    lastOffset = currentOffset;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataManager eventsForCalendarId:self.activeCalendar.identifier].items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GCEventCell *cell = [tableView dequeueReusableCellWithIdentifier:[GCEventCell reuseIdentifier]];
    cell.event = [self.dataManager eventsForCalendarId:self.activeCalendar.identifier][indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

#pragma mark - Handle Touches

- (void)handlePan:(UIPanGestureRecognizer *)recognizer
{
    CGPoint tr = [recognizer translationInView:self.pullView];
    
    if (recognizer.state == UIGestureRecognizerStateChanged) {
        
        if (fabs(tr.y) < 10)
            return;
        
        if (self.pullView.state == GCPullViewStateClosed)
            self.pullView.top = self.view.height-20+tr.y;
        else
            self.pullView.top = self.view.height-100+tr.y;
        
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        
        if (fabs(tr.y) < 10)
            return;
        
        NSInteger destinationPoint = self.view.height-20;
        if (fabs(tr.y) > 100)
            destinationPoint = self.view.height-100;
        
        [UIView animateWithDuration:0.2f animations:^{
            self.pullView.top = destinationPoint;
        } completion:^(BOOL finished) {
            self.pullView.state = destinationPoint == self.view.height-100;
        }];
    }
}



- (void)viewDidUnload {
    [self setTableView:nil];
    [super viewDidUnload];
}
@end
