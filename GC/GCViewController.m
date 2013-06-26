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
    
    self.pullView = [[GCPullView alloc] initWithFrame:CGRectMake(0, self.view.height-20, self.view.width, 200)];
    [self.view addSubview:self.pullView];
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.pullView addGestureRecognizer:panRecognizer];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.titleView = view;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[GCDataManager sharedManager] authorize];
    [[GCDataManager sharedManager] getCalendarsOnSucess:^{
        self.activeCalendar = [GCDataManager sharedManager].calendars[0];
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

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataManager eventsForCalendarId:self.activeCalendar.identifier].items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GCEventCell *cell = [tableView dequeueReusableCellWithIdentifier:[GCEventCell reuseIdentifier]];
    
    return cell;
}

#pragma mark - UITableViewDelegate

#pragma mark - Handle Touches

- (void)handlePan:(UIPanGestureRecognizer *)recognizer
{
    CGPoint tr = [recognizer translationInView:self.pullView];
    
    if (recognizer.state == UIGestureRecognizerStateChanged) {
        
        if (self.pullView.state == GCPullViewStateClosed)
            self.pullView.top = self.view.height-20+tr.y;
        else
            self.pullView.top = self.view.height-100+tr.y;
        
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        
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
