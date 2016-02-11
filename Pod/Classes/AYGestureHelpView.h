//
//  AYGestureHelpView.h
//  AYGestureHelpView
//
//  Created by Ayan Yenbekbay on 10/22/15.
//  Copyright © 2015 Ayan Yenbekbay. All rights reserved.
//

typedef void (^AYGestureHelpViewDismissHandler)(void);

@interface AYGestureHelpView : UIView

#pragma mark Properties

/**
 *  Font for the help label. Default is [UIFont systemFontOfSize:[UIFont labelFontSize]].
 */
@property (nonatomic) UIFont *labelFont;
/**
 *  Radius for the touch view used for gesture animations. Default is 25.
 */
@property (nonatomic) CGFloat touchRadius;

#pragma mark Methods

/**
 *  Initializes and returns a newly allocated gesture help view object with the specified touch radius and a fullscreen frame.
 *
 *  @param touchRadius Radius for the touch view used for gesture animations.
 *
 *  @return A newly created gesture help view object.
 */
- (instancetype)initWithTouchRadius:(CGFloat)touchRadius;
/**
 *  Initializes and returns a newly allocated gesture help view object with the specified font for the description label
 *  and a fullscreen frame.
 *
 *  @param labelFont Font for the description label.
 *
 *  @return A newly created gesture help view object.
 */
- (instancetype)initWithLabelFont:(UIFont *)labelFont;
/**
 *  Initializes and returns a newly allocated gesture help view object with the specified frame rectangle and
 *  the specified font for the description label.
 *
 *  @param frame       The frame rectangle for the gesture help view.
 *  @param labelFont   Font for the description label.
 *  @param touchRadius Radius for the touch view used for gesture animations.
 *
 *  @return A newly created gesture help view object.
 */
- (instancetype)initWithFrame:(CGRect)frame labelFont:(UIFont *)labelFont touchRadius:(CGFloat)touchRadius;
/**
 *  Performs a repeating tap gesture animation at the specified point with the specified description text.
 *
 *  @param labelText      Text for the description label.
 *  @param labelPoint     Position for the description label relative to the view frame.
 *  @param touchPoint     Position for the touch view relative to the view frame.
 *  @param dismissHandler Action performed when the user taps on the view.
 *  @param hideOnDismiss  Whether or not the view should be dismissed on tap. Set NO if you would like to
 *  chain other animations.
 */
- (void)tapWithLabelText:(NSString *)labelText labelPoint:(CGPoint)labelPoint touchPoint:(CGPoint)touchPoint dismissHandler:(AYGestureHelpViewDismissHandler)dismissHandler hideOnDismiss:(BOOL)hideOnDismiss;
/**
 *  Performs a repeating double tap gesture animation at the specified point with the specified description text.
 *
 *  @param labelText      Text for the description label.
 *  @param labelPoint     Position for the description label relative to the view frame.
 *  @param touchPoint     Position for the touch view relative to the view frame.
 *  @param dismissHandler Action performed when the user taps on the view.
 *  @param hideOnDismiss  Whether or not the view should be dismissed on tap. Set NO if you would like to
 *  chain other animations.
 */
- (void)doubleTapWithLabelText:(NSString *)labelText labelPoint:(CGPoint)labelPoint touchPoint:(CGPoint)touchPoint dismissHandler:(AYGestureHelpViewDismissHandler)dismissHandler hideOnDismiss:(BOOL)hideOnDismiss;
/**
 *  Performs a repeating swipe gesture animation between specified points with the specified description text.
 *
 *  @param labelText       Text for the description label.
 *  @param labelPoint      Position for the description label relative to the view frame.
 *  @param touchStartPoint Position for the starting point of the touch view animation relative to the view frame.
 *  @param touchEndPoint   Position for the ending point of the touch view animation relative to the view frame.
 *  @param direction direction of swipe on the view.
 *  @param dismissHandler  Action performed when the user taps on the view.
 *  @param hideOnDismiss   Whether or not the view should be dismissed on tap. Set NO if you would like to
 *  chain other animations.
 */

- (void)swipeWithLabelText:(NSString *)labelText
                labelPoint:(CGPoint)labelPoint
           touchStartPoint:(CGPoint)touchStartPoint
             touchEndPoint:(CGPoint)touchEndPoint
                 direction:(UISwipeGestureRecognizerDirection)direction
            dismissHandler:(AYGestureHelpViewDismissHandler)dismissHandler
             hideOnDismiss:(BOOL)hideOnDismiss;

/**
 *  Performs a repeating long press gesture animation at the specified point with the specified description text.
 *
 *  @param labelText      Text for the description label.
 *  @param labelPoint     Position for the description label relative to the view frame.
 *  @param touchPoint     Position for the touch view relative to the view frame.
 *  @param dismissHandler Action performed when the user taps on the view.
 *  @param hideOnDismiss  Whether or not the view should be dismissed on tap. Set NO if you would like to
 *  chain other animations.
 */
- (void)longPressWithLabelText:(NSString *)labelText labelPoint:(CGPoint)labelPoint touchPoint:(CGPoint)touchPoint dismissHandler:(AYGestureHelpViewDismissHandler)dismissHandler hideOnDismiss:(BOOL)hideOnDismiss;

- (void)dismiss;

@end
