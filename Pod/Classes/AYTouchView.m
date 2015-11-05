//
//  AYTouchView.m
//  AYGestureHelpView
//
//  Created by Ayan Yenbekbay on 10/22/15.
//  Copyright © 2015 Ayan Yenbekbay. All rights reserved.
//

#import "AYTouchView.h"

#import <pop/POP.h>

@interface AYTouchView ()

@property (nonatomic) UIView *innerCircle;
@property (nonatomic) UIView *firstOuterCircle;
@property (nonatomic) UIView *secondOuterCircle;

@end

@implementation AYTouchView

#pragma mark Lifecycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    self.innerCircle = [[UIView alloc] initWithFrame:self.bounds];
    self.innerCircle.layer.backgroundColor = [UIColor colorWithWhite:1 alpha:0.8f].CGColor;
    self.innerCircle.layer.cornerRadius = CGRectGetHeight(self.innerCircle.bounds) / 2;
    self.innerCircle.layer.borderColor = [UIColor colorWithWhite:1 alpha:0.7f].CGColor;
    self.innerCircle.layer.borderWidth = 3;
    [self addSubview:self.innerCircle];
    
    self.firstOuterCircle = [[UIView alloc] initWithFrame:self.bounds];
    self.secondOuterCircle = [[UIView alloc] initWithFrame:self.bounds];
    for (UIView *outerCircle in @[self.firstOuterCircle, self.secondOuterCircle]) {
        outerCircle.layer.cornerRadius = CGRectGetHeight(outerCircle.bounds) / 2;
        outerCircle.layer.borderColor = [UIColor whiteColor].CGColor;
        outerCircle.layer.borderWidth = 2;
        outerCircle.alpha = 0;
        [self addSubview:outerCircle];
    }
    
    return self;
}

#pragma mark Public

- (void)addTapAnimation {
    [self addAlphaAnimation];
    [self addTapAnimationToOuterCircle:self.firstOuterCircle];
}

- (void)addDoubleTapAnimation {
    [self addTapAnimation];
    [self performSelector:@selector(addTapAnimationToOuterCircle:) withObject:self.secondOuterCircle afterDelay:0.5f];
    [self performSelector:@selector(addAlphaAnimation) withObject:self.secondOuterCircle afterDelay:0.5f];
}

- (void)addSwipeAnimation {
    [self addAlphaAnimation];
    [self addCenterAnimation];
}

#pragma mark Private

- (void)addAlphaAnimation {
    POPBasicAnimation *opacityAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    opacityAnimation.fromValue = @(1);
    opacityAnimation.toValue = @(0.3f);
    opacityAnimation.duration = 1.5f;
    [self.innerCircle pop_addAnimation:opacityAnimation forKey:@"alpha"];
}

- (void)addCenterAnimation {
    POPBasicAnimation *centerAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
    centerAnimation.fromValue = [NSValue valueWithCGPoint:[self.superview convertPoint:self.startPoint toView:self]];
    centerAnimation.toValue = [NSValue valueWithCGPoint:[self.superview convertPoint:self.endPoint toView:self]];
    centerAnimation.duration = 1.5f;
    [self.innerCircle pop_addAnimation:centerAnimation forKey:@"center"];
}

- (void)addTapAnimationToOuterCircle:(UIView *)outerCircle {
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
    [outerCircle.layer pop_addAnimation:scaleAnimation forKey:@"scale"];
    [outerCircle pop_addAnimation:alphaAnimation forKey:@"alpha"];
}

@end
