//
//  AYGestureHelpView.m
//  AYGestureHelpView
//
//  Created by Ayan Yenbekbay on 10/22/15.
//  Copyright © 2015 Ayan Yenbekbay. All rights reserved.
//

#import "AYGestureHelpView.h"
#import "AYTouchView.h"

static UIEdgeInsets const kHelpViewPadding = {
  20, 20, 20, 20
};
static CGFloat const kHelpViewDefaultTouchRadius = 25;

@interface AYGestureHelpView ()

@property (copy, nonatomic) AYGestureHelpViewDismissHandler dismissHandler;
@property (nonatomic) BOOL hideOnDismiss;
@property (nonatomic) AYTouchView *touchView;
@property (nonatomic) NSTimer *timer;
@property (nonatomic) UILabel *label;

@end

@implementation AYGestureHelpView

#pragma mark Initialization

- (instancetype)init {
  return [self initWithFrame:[UIScreen mainScreen].bounds labelFont:[UIFont systemFontOfSize:[UIFont labelFontSize]] touchRadius:kHelpViewDefaultTouchRadius];
}

- (instancetype)initWithFrame:(CGRect)frame {
  return [self initWithFrame:frame labelFont:[UIFont systemFontOfSize:[UIFont labelFontSize]] touchRadius:kHelpViewDefaultTouchRadius];
}

- (instancetype)initWithTouchRadius:(CGFloat)touchRadius {
  return [self initWithFrame:[UIScreen mainScreen].bounds labelFont:[UIFont systemFontOfSize:[UIFont labelFontSize]] touchRadius:touchRadius];
}

- (instancetype)initWithLabelFont:(UIFont *)labelFont {
  return [self initWithFrame:[UIScreen mainScreen].bounds labelFont:labelFont touchRadius:kHelpViewDefaultTouchRadius];
}

- (instancetype)initWithFrame:(CGRect)frame labelFont:(UIFont *)labelFont touchRadius:(CGFloat)touchRadius {
  self = [super initWithFrame:frame];
  if (!self) {
    return nil;
  }

  _labelFont = labelFont;
  _touchRadius = touchRadius;
  [self setUpViews];

  return self;
}

#pragma mark Setters

- (void)setLabelFont:(UIFont *)labelFont {
  _labelFont = labelFont;
  self.label.font = labelFont;
}

- (void)setTouchRadius:(CGFloat)touchRadius {
  _touchRadius = touchRadius;
  self.touchView.frame = CGRectMake(CGRectGetMinX(self.touchView.frame), CGRectGetMinY(self.touchView.frame), self.touchRadius * 2, self.touchRadius * 2);
}

#pragma mark Public

- (void)tapWithLabelText:(NSString *)labelText labelPoint:(CGPoint)labelPoint touchPoint:(CGPoint)touchPoint dismissHandler:(AYGestureHelpViewDismissHandler)dismissHandler hideOnDismiss:(BOOL)hideOnDismiss {
  [self tapWithLabelText:labelText labelPoint:labelPoint touchPoint:touchPoint dismissHandler:dismissHandler doubleTap:NO hideOnDismiss:hideOnDismiss];
}

- (void)doubleTapWithLabelText:(NSString *)labelText labelPoint:(CGPoint)labelPoint touchPoint:(CGPoint)touchPoint dismissHandler:(AYGestureHelpViewDismissHandler)dismissHandler hideOnDismiss:(BOOL)hideOnDismiss {
  [self tapWithLabelText:labelText labelPoint:labelPoint touchPoint:touchPoint dismissHandler:dismissHandler doubleTap:YES hideOnDismiss:hideOnDismiss];
}

- (void)swipeWithLabelText:(NSString *)labelText labelPoint:(CGPoint)labelPoint touchStartPoint:(CGPoint)touchStartPoint touchEndPoint:(CGPoint)touchEndPoint dismissHandler:(AYGestureHelpViewDismissHandler)dismissHandler hideOnDismiss:(BOOL)hideOnDismiss {
  [self prepareViewWithLabelText:labelText labelPoint:labelPoint touchStartPoint:touchStartPoint touchEndPoint:touchEndPoint dismissHandler:dismissHandler hideOnDismiss:hideOnDismiss];
  [self showIfNeededWithCompletionBlock:^{
    [self.touchView addSwipeAnimation];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:kSwipeAnimationDuration target:self.touchView selector:@selector(addSwipeAnimation) userInfo:nil repeats:YES];
  }];
}

- (void)longPressWithLabelText:(NSString *)labelText labelPoint:(CGPoint)labelPoint touchPoint:(CGPoint)touchPoint dismissHandler:(AYGestureHelpViewDismissHandler)dismissHandler hideOnDismiss:(BOOL)hideOnDismiss {
  [self prepareViewWithLabelText:labelText labelPoint:labelPoint touchStartPoint:touchPoint touchEndPoint:CGPointZero dismissHandler:dismissHandler hideOnDismiss:hideOnDismiss];
  [self showIfNeededWithCompletionBlock:^{
    [self.touchView addLongPressAnimation];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:kLongPressAnimationDuration target:self.touchView selector:@selector(addLongPressAnimation) userInfo:nil repeats:YES];
  }];
}

#pragma mark Private

- (void)setUpViews {
  self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.75f];
  self.alpha = 0;

  UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap:)];
  [self addGestureRecognizer:tapGestureRecognizer];

  self.touchView = [[AYTouchView alloc] initWithFrame:CGRectMake(0, 0, self.touchRadius * 2, self.touchRadius * 2)];
  [self addSubview:self.touchView];

  self.label = [[UILabel alloc] initWithFrame:CGRectMake(kHelpViewPadding.left, 0, CGRectGetWidth(self.bounds) - kHelpViewPadding.left - kHelpViewPadding.right, 0)];
  self.label.font = self.labelFont;
  self.label.textColor = [UIColor whiteColor];
  self.label.numberOfLines = 0;
  self.label.textAlignment = NSTextAlignmentCenter;
  [self addSubview:self.label];
}

- (void)tapWithLabelText:(NSString *)labelText labelPoint:(CGPoint)labelPoint touchPoint:(CGPoint)touchPoint dismissHandler:(AYGestureHelpViewDismissHandler)dismissHandler doubleTap:(BOOL)doubleTap hideOnDismiss:(BOOL)hideOnDismiss {
  [self prepareViewWithLabelText:labelText labelPoint:labelPoint touchStartPoint:touchPoint touchEndPoint:CGPointZero dismissHandler:dismissHandler hideOnDismiss:hideOnDismiss];
  [self showIfNeededWithCompletionBlock:^{
    if (doubleTap) {
      [self.touchView addDoubleTapAnimation];
      self.timer = [NSTimer scheduledTimerWithTimeInterval:kDoubleTapAnimationDuration target:self.touchView selector:@selector(addDoubleTapAnimation) userInfo:nil repeats:YES];
    } else {
      [self.touchView addTapAnimation];
      self.timer = [NSTimer scheduledTimerWithTimeInterval:kTapAnimationDuration target:self.touchView selector:@selector(addTapAnimation) userInfo:nil repeats:YES];
    }
  }];
}

- (void)prepareViewWithLabelText:(NSString *)labelText labelPoint:(CGPoint)labelPoint touchStartPoint:(CGPoint)touchStartPoint touchEndPoint:(CGPoint)touchEndPoint dismissHandler:(AYGestureHelpViewDismissHandler)dismissHandler hideOnDismiss:(BOOL)hideOnDismiss {
  self.touchView.center = touchStartPoint;
  if (!CGPointEqualToPoint(touchStartPoint, CGPointZero)) {
    self.touchView.startPoint = touchStartPoint;
    self.touchView.endPoint = touchEndPoint;
  }
  self.label.text = labelText;
  [self.label sizeToFit];
  self.label.center = labelPoint;
  self.dismissHandler = dismissHandler;
  self.hideOnDismiss = hideOnDismiss;
}

- (void)showIfNeededWithCompletionBlock:(void (^_Nonnull)(void))completionBlock {
  completionBlock = ^{
    if (self.timer) {
      [self.timer invalidate];
    }
    completionBlock();
  };
  if (!self.superview) {
    [[[UIApplication sharedApplication] delegate].window addSubview:self];
  }
  if (self.alpha == 0) {
    [UIView animateWithDuration:0.5f animations:^{
      self.alpha = 1;
    } completion:^(BOOL finished) {
      completionBlock();
    }];
  } else {
    completionBlock();
  }
}

- (void)didTap:(UITapGestureRecognizer *)gestureRecognizer {
  if (self.hideOnDismiss) {
    [self.timer invalidate];
    [UIView animateWithDuration:0.5f animations:^{
      self.alpha = 0;
    } completion:^(BOOL finished) {
      [self removeFromSuperview];
    }];
  }
  if (self.dismissHandler) {
    self.dismissHandler();
  }
}

@end
