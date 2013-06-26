//
//  UIViewController(additions).m
//  Tykoon
//
//  Created by ziryanov on 12/19/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "UIViewController(additions).h"

@implementation UIViewController(additions)

- (UIViewController*)topSubcontroller
{
    UIViewController* next = 0;
    if ([self isKindOfClass:[UINavigationController class]])
        next = ((UINavigationController*)self).topViewController;
    else if ([self isKindOfClass:[UITabBarController class]])
        next = ((UITabBarController*)self).selectedViewController;
    else if (self.presentedViewController)
        next = self.presentedViewController;
    if (next)
        return [next topSubcontroller];
    return self;
}

+ (UIViewController*)topViewController
{
    return [((UIWindow*)[[UIApplication sharedApplication].windows objectAtIndex:0]).rootViewController topSubcontroller];
}

- (UINavigationController*)wrapInNavigationControllerWithBarStyle:(UIBarStyle)barStyle
{
    UINavigationController* navigationController = [[UINavigationController alloc] initWithRootViewController:self];
    navigationController.navigationBar.barStyle = barStyle;
    return navigationController;
}

#pragma mark - Error Show

- (void)showError:(NSError *)error
{
    [self showErrorMessage:error.localizedDescription];
}

- (void)showErrorMessage:(NSString *)errorMessage
{
    [self showMessage:errorMessage withTitle:@"Error" buttonTitles:nil cancelButtonTitle:@"Dismiss" delegate:nil];
}

- (void)showMessage:(NSString *)message withTitle:(NSString *)title
{
    [self showMessage:message withTitle:title buttonTitles:nil cancelButtonTitle:@"Dismiss" delegate:nil];
}

- (UIAlertView *)showMessage:(NSString *)message
                   withTitle:(NSString *)title
                buttonTitles:(NSArray *)buttonTitles
           cancelButtonTitle:(NSString *)cancelButtonTitle
                    delegate:(id<UIAlertViewDelegate>)delegate
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:delegate
                                              cancelButtonTitle:cancelButtonTitle
                                              otherButtonTitles:nil];
    for (NSString *buttonTitle in buttonTitles)
        [alertView addButtonWithTitle:buttonTitle];
    [alertView show];
    return alertView;
}

- (FailureBlock)defaultFailureBlock
{
    return ^(NSError *error) {
        [self showError:error];
    };
}

@end
