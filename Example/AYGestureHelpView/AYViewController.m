//
//  AYViewController.m
//  AYGestureHelpView
//
//  Created by Ayan Yenbekbay on 11/05/2015.
//  Copyright (c) 2015 Ayan Yenbekbay. All rights reserved.
//

#import "AYViewController.h"

#import <AYGestureHelpView/AYGestureHelpView.h>

@interface AYViewController ()

@property (weak, nonatomic) IBOutlet UIButton *showHelpViewButton;

@end

@implementation AYViewController

- (IBAction)showHelpView:(id)sender {
  self.showHelpViewButton.hidden = YES;
  AYGestureHelpView *helpView = [AYGestureHelpView new];
  [helpView doubleTapWithLabelText:NSLocalizedString(@"Double tap to open the menu", nil)
   labelPoint:CGPointMake(self.view.center.x, self.view.center.y + 70) touchPoint:self.view.center dismissHandler:^{
    [helpView swipeWithLabelText:NSLocalizedString(@"Swipe to scroll through cards", nil)
     labelPoint:CGPointMake(self.view.center.x, self.view.center.y + 70) touchStartPoint:CGPointMake(self.view.center.x + 25, self.view.center.y) touchEndPoint:CGPointMake(self.view.center.x - 25, self.view.center.y) dismissHandler:^{
      [helpView swipeWithLabelText:NSLocalizedString(@"Pull down to refresh", nil)
       labelPoint:CGPointMake(self.view.center.x, self.view.center.y + 70) touchStartPoint:CGPointMake(self.view.center.x, self.view.center.y - 50)  touchEndPoint:self.view.center dismissHandler:^{
        self.showHelpViewButton.hidden = NO;
      } hideOnDismiss:YES];
    } hideOnDismiss:NO];
  } hideOnDismiss:NO];
}

@end
