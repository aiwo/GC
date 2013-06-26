//
//  UIViewController(additions).h
//  Tykoon
//
//  Created by ziryanov on 12/19/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTLObject.h"

@interface UIViewController(additions)

typedef void (^ActionBlock)();
typedef void (^ActionBlockWithObject)(GTLObject *object);
typedef void (^FailureBlock)(NSError *error);

- (UIViewController*)topSubcontroller;
+ (UIViewController*)topViewController;

- (UINavigationController*)wrapInNavigationControllerWithBarStyle:(UIBarStyle)barStyle;

- (void)showError:(NSError *)error;
- (void)showErrorMessage:(NSString *)errorMessage;
- (void)showMessage:(NSString *)message withTitle:(NSString *)title;
- (UIAlertView *)showMessage:(NSString *)message
                   withTitle:(NSString *)title
                buttonTitles:(NSArray *)buttonTitles
           cancelButtonTitle:(NSString *)cancelButtonTitle
                    delegate:(id<UIAlertViewDelegate>)delegate;

- (FailureBlock)defaultFailureBlock;

@end
