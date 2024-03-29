//
// Copyright 2009-2011 Facebook
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#import "UIView+Additions.h"
#import <QuartzCore/QuartzCore.h>

const CGFloat ttkDefaultPortraitKeyboardHeight = 216;

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
/**
 * Additions.
 */

@implementation UIView (TTCategory)


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)left {
  return self.frame.origin.x;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setLeft:(CGFloat)x {
  CGRect frame = self.frame;
  frame.origin.x = x;
  self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)top {
  return self.frame.origin.y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setTop:(CGFloat)y {
  CGRect frame = self.frame;
  frame.origin.y = y;
  self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)right {
  return self.frame.origin.x + self.frame.size.width;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setRight:(CGFloat)right {
  CGRect frame = self.frame;
  frame.origin.x = right - frame.size.width;
  self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)bottom {
  return self.frame.origin.y + self.frame.size.height;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setBottom:(CGFloat)bottom {
  CGRect frame = self.frame;
  frame.origin.y = bottom - frame.size.height;
  self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)centerX {
  return self.center.x;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setCenterX:(CGFloat)centerX {
  self.center = CGPointMake(centerX, self.center.y);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)centerY {
  return self.center.y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setCenterY:(CGFloat)centerY {
  self.center = CGPointMake(self.center.x, centerY);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)width {
  return self.frame.size.width;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setWidth:(CGFloat)width {
  CGRect frame = self.frame;
  frame.size.width = width;
  self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)height {
  return self.frame.size.height;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setHeight:(CGFloat)height {
  CGRect frame = self.frame;
  frame.size.height = height;
  self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)ttScreenX {
  CGFloat x = 0;
  for (UIView* view = self; view; view = view.superview) {
    x += view.left;
  }
  return x;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)ttScreenY {
  CGFloat y = 0;
  for (UIView* view = self; view; view = view.superview) {
    y += view.top;
  }
  return y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)screenViewX {
  CGFloat x = 0;
  for (UIView* view = self; view; view = view.superview) {
      x += view.left;

    if ([view isKindOfClass:[UIScrollView class]]) {
      UIScrollView* scrollView = (UIScrollView*)view;
      x -= scrollView.contentOffset.x;
    }
  }

  return x;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)screenViewY {
  CGFloat y = 0;
  for (UIView* view = self; view; view = view.superview) {
    y += view.top;

    if ([view isKindOfClass:[UIScrollView class]]) {
      UIScrollView* scrollView = (UIScrollView*)view;
      y -= scrollView.contentOffset.y;
    }
  }
  return y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGRect)screenFrame {
  return CGRectMake(self.screenViewX, self.screenViewY, self.width, self.height);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGPoint)origin {
  return self.frame.origin;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setOrigin:(CGPoint)origin {
  CGRect frame = self.frame;
  frame.origin = origin;
  self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGSize)size {
  return self.frame.size;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setSize:(CGSize)size {
  CGRect frame = self.frame;
  frame.size = size;
  self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIView*)descendantOrSelfWithClass:(Class)cls {
  if ([self isKindOfClass:cls])
    return self;

  for (UIView* child in self.subviews) {
    UIView* it = [child descendantOrSelfWithClass:cls];
    if (it)
      return it;
  }

  return nil;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIView*)ancestorOrSelfWithClass:(Class)cls {
  if ([self isKindOfClass:cls]) {
    return self;

  } else if (self.superview) {
    return [self.superview ancestorOrSelfWithClass:cls];

  } else {
    return nil;
  }
}

- (void)addSubviews:(NSArray *)subviews {

    for (UIView *subview in subviews) {
        [self addSubview:subview];
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)removeAllSubviews {
  while (self.subviews.count) {
    UIView* child = self.subviews.lastObject;
    [child removeFromSuperview];
  }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGPoint)offsetFromView:(UIView*)otherView {
  CGFloat x = 0, y = 0;
  for (UIView* view = self; view && view != otherView; view = view.superview) {
    x += view.left;
    y += view.top;
  }
  return CGPointMake(x, y);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIView*)findSubviewWithTag:(NSInteger)tag
{
    if (self.tag == tag)
        return self;
    
    for (UIView* subView in self.subviews)
    {
        if (subView.tag == tag)
            return subView;
        
        UIView* subviewWithTagCheck = [subView findSubviewWithTag:tag];
        if (subviewWithTagCheck)
            return subviewWithTagCheck;
    }
    return 0;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIView*)findFirstResponder
{
    if ([self isFirstResponder])
        return self;
    
    for (UIView* subView in self.subviews)
    {
        if ([subView isFirstResponder])
            return subView;
        
        UIView* firstResponderCheck = [subView findFirstResponder];
        if (firstResponderCheck)
            return firstResponderCheck;
    }
    return 0;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#define WrapSubviewTag 4236

- (UIView*)wrapSubview
{
    return (self.superview && [self.superview.subviews count] == 1 && self.superview.tag == WrapSubviewTag)?self.superview:self;
}

- (UIView*)createWrapSubview
{
    UIView* view = [[UIView alloc] initWithFrame:self.frame];
    view.tag = WrapSubviewTag;
    view.backgroundColor = [UIColor clearColor];
    view.autoresizingMask = self.autoresizingMask;
    [self.superview insertSubview:view aboveSubview:self];
    
    self.origin = CGPointZero;
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [view addSubview:self];

    return view;
}

- (CGImageRef)imageByRenderingView
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    CGImageRef imageRef = CGBitmapContextCreateImage(UIGraphicsGetCurrentContext());
    UIGraphicsEndImageContext();
    return imageRef;
}

@end


@implementation UIScrollView(scrollToBottom)

- (void)scrollToBottomAnimated:(BOOL)animated
{
    [self setContentOffset:CGPointMake(0, self.contentSize.height - self.height) animated:animated];
}

@end