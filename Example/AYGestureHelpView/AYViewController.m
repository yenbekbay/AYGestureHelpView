//
//  AYViewController.m
//  AYGestureHelpView
//
//  Created by Ayan Yenbekbay on 11/05/2015.
//  Copyright (c) 2015 Ayan Yenbekbay. All rights reserved.
//

#import "AYViewController.h"



@interface AYViewController ()

@property (weak, nonatomic) IBOutlet UIButton *showHelpViewButton;

@end

@implementation AYViewController

- (IBAction)showHelpView:(id)sender {
    self.showHelpViewButton.hidden = YES;
    AYGestureHelpView *helpView = [AYGestureHelpView new];
    helpView.delegate = self;
                
    [helpView longPressWithLabelText:NSLocalizedString(@"Tap and hold to open the menu", nil) labelPoint:CGPointMake(self.view.center.x, self.view.center.y + 70) touchPoint:self.view.center dismissHandler:^{
        self.showHelpViewButton.hidden = NO;
    } hideOnDismiss:YES];
    
                
    self.showHelpViewButton.hidden = NO;
 
}

/**
 *  Long press started.
 */
-(void)longPressStateBegan{
    
    NSLog(@"Long press started");
    
}

/**
 *  Long press event changed its state.
 */
-(void)longPressStateChanged{
    
    NSLog(@"Long press state changed");
    
}

/**
 *  Long press ended.
 */
-(void)longPressStateEnded{
    
    NSLog(@"Long press state ended");
    
}
@end
