//
//  AYTouchView.m
//  AYGestureHelpView
//
//  Created by Ayan Yenbekbay on 10/22/15.
//  Copyright © 2015 Ayan Yenbekbay. All rights reserved.
//

#import "AYTouchView.h"

#import <pop/POP.h>

NSTimeInterval const kTapAnimationDuration = 1.5f;
NSTimeInterval const kDoubleTapAnimationDuration = 2;
NSTimeInterval const kSwipeAnimationDuration = 1.5f;
NSTimeInterval const kLongPressAnimationDuration = 2;

@interface AYTouchViewInnerCircle : UIView

@property (nonatomic) CGPoint startPoint;
@property (nonatomic) CGPoint endPoint;

@end

@implementation AYTouchViewInnerCircle

#pragma mark Initialization

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (!self) {
    return nil;
  }

  self.layer.backgroundColor = [UIColor colorWithWhite:1 alpha:0.8f].CGColor;
  self.layer.cornerRadius = CGRectGetHeight(self.bounds) / 2;
  self.layer.borderColor = [UIColor colorWithWhite:1 alpha:0.7f].CGColor;
  self.layer.borderWidth = 3;

  return self;
}

#pragma mark Animations

- (void)addAlphaAnimationWithDuration:(NSTimeInterval)duration {
  POPBasicAnimation *opacityAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
  opacityAnimation.fromValue = @(1);
  opacityAnimation.toValue = @(0.3f);
  opacityAnimation.duration = duration;
  [self pop_addAnimation:opacityAnimation forKey:@"alpha"];
}

- (void)addCenterAnimationWithDuration:(NSTimeInterval)duration {
  POPBasicAnimation *centerAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
  centerAnimation.fromValue = [NSValue valueWithCGPoint:[self.superview.superview convertPoint:self.startPoint toView:self.superview]];
  centerAnimation.toValue = [NSValue valueWithCGPoint:[self.superview.superview convertPoint:self.endPoint toView:self.superview]];
  centerAnimation.duration = duration;
  [self pop_addAnimation:centerAnimation forKey:@"center"];
}

@end


@interface AYTouchViewOuterCircle : UIView
@end

@implementation AYTouchViewOuterCircle

#pragma mark Initialization

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (!self) {
    return nil;
  }

  self.layer.cornerRadius = CGRectGetHeight(self.bounds) / 2;
  self.layer.borderColor = [UIColor whiteColor].CGColor;
  self.layer.borderWidth = 2;
  self.alpha = 0;

  return self;
}

#pragma mark Animations

- (void)addTouchAnimation {
  POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
  scaleAnimation.fromValue = [NSValue valueWithCGSize:CGSizeMake(1, 1)];
  scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(2.5f, 2.5f)];

  POPBasicAnimation *alphaAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
  alphaAnimation.fromValue = @(1);
  alphaAnimation.toValue = @(0);

  for (POPBasicAnimation *animation in @[scaleAnimation, alphaAnimation]) {
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    animation.duration = 1;
  }
  [self.layer pop_addAnimation:scaleAnimation forKey:@"scale"];
  [self pop_addAnimation:alphaAnimation forKey:@"alpha"];
}

@end


@interface AYTouchView ()

@property (nonatomic) AYTouchViewInnerCircle *innerCircle;
@property (nonatomic) AYTouchViewOuterCircle *firstOuterCircle;
@property (nonatomic) AYTouchViewOuterCircle *secondOuterCircle;

@end

@implementation AYTouchView

#pragma mark Initialization

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (!self) {
    return nil;
  }

  self.innerCircle = [[AYTouchViewInnerCircle alloc] initWithFrame:self.bounds];
  [self addSubview:self.innerCircle];
  self.firstOuterCircle = [[AYTouchViewOuterCircle alloc] initWithFrame:self.bounds];
  [self addSubview:self.firstOuterCircle];
  self.secondOuterCircle = [[AYTouchViewOuterCircle alloc] initWithFrame:self.bounds];
  [self addSubview:self.secondOuterCircle];

  return self;
}

#pragma mark Setters

- (void)setStartPoint:(CGPoint)startPoint {
  _startPoint = startPoint;
  self.innerCircle.startPoint = startPoint;
}

- (void)setEndPoint:(CGPoint)endPoint {
  _endPoint = endPoint;
  self.innerCircle.endPoint = endPoint;
}

#pragma mark Public

- (void)addTapAnimation {
  [self.innerCircle addAlphaAnimationWithDuration:kTapAnimationDuration];
  [self.firstOuterCircle addTouchAnimation];
}

- (void)addDoubleTapAnimation {
  [self.innerCircle addAlphaAnimationWithDuration:kTapAnimationDuration];
  [self.firstOuterCircle addTouchAnimation];
  [self.secondOuterCircle performSelector:@selector(addTouchAnimation) withObject:nil afterDelay:0.5f];
}

- (void)addSwipeAnimation {
  [self.innerCircle addAlphaAnimationWithDuration:kSwipeAnimationDuration];
  [self.innerCircle addCenterAnimationWithDuration:kSwipeAnimationDuration];
}

- (void)addLongPressAnimation {
  [self.innerCircle addAlphaAnimationWithDuration:kLongPressAnimationDuration];
  [self.firstOuterCircle performSelector:@selector(addTouchAnimation) withObject:nil afterDelay:kLongPressAnimationDuration - 1];
}

@end
