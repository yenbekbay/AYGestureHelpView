//
//  AYTouchView.h
//  AYGestureHelpView
//
//  Created by Ayan Yenbekbay on 10/22/15.
//  Copyright © 2015 Ayan Yenbekbay. All rights reserved.
//

extern NSTimeInterval const kTapAnimationDuration;
extern NSTimeInterval const kDoubleTapAnimationDuration;
extern NSTimeInterval const kSwipeAnimationDuration;
extern NSTimeInterval const kLongPressAnimationDuration;

@interface AYTouchView : UIView

#pragma mark Properties

@property (nonatomic) CGPoint startPoint;
@property (nonatomic) CGPoint endPoint;

#pragma mark Methods

/**
 *  Adds an animation resembling a tap gesture.
 */
- (void)addTapAnimation;
/**
 *  Adds an animation resembling a double tap gesture.
 */
- (void)addDoubleTapAnimation;
- (void)addSwipeAnimation;
- (void)addLongPressAnimation;

@end
