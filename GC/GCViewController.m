//
//  GCViewController.m
//  GC
//
//  Created by Gennady Berezovsky on 24.06.13.
//  Copyright (c) 2013 Gennady Berezovsky. All rights reserved.
//

#import "GCViewController.h"
#import "GCPullView.h"

@interface GCViewController ()

@property (nonatomic, strong) GCPullView *pullView;

@end

@implementation GCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.pullView = [[GCPullView alloc] initWithFrame:CGRectMake(0, self.view.height-20, self.view.width, 200)];
    [self.view addSubview:self.pullView];
    
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.pullView addGestureRecognizer:panRecognizer];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.pullView.top = self.view.height-20;
}

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
