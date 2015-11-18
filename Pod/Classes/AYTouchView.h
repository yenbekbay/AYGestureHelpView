//
//  AYTouchView.h
//  AYGestureHelpView
//
//  Created by Ayan Yenbekbay on 10/22/15.
//  Copyright © 2015 Ayan Yenbekbay. All rights reserved.
//

@interface AYTouchView : UIView

#pragma mark Properties

@property (nonatomic) CGPoint startPoint;
@property (nonatomic) CGPoint endPoint;

#pragma mark Methods

- (void)addTapAnimation;
- (void)addDoubleTapAnimation;
- (void)addSwipeAnimation;
- (void)addLongPressAnimation;
- (void)addLPressAnimation;

@end
