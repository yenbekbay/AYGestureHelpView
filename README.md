# AYGestureHelpView

[![Version](https://img.shields.io/cocoapods/v/AYGestureHelpView.svg?style=flat)](http://cocoapods.org/pods/AYGestureHelpView)
[![License](https://img.shields.io/cocoapods/l/AYGestureHelpView.svg?style=flat)](http://cocoapods.org/pods/AYGestureHelpView)
[![Platform](https://img.shields.io/cocoapods/p/AYGestureHelpView.svg?style=flat)](http://cocoapods.org/pods/AYGestureHelpView)

A view that can show a tutorial for gestures in your app

<p align="center">
  <a href='https://appetize.io/app/d8khut8m036uz1dzu5y45y7rwc' alt='Live demo'>
    <img width="50" height="60" src="assets/demo.png"/>
  </a>
</p>

![AYGestureHelpView](https://raw.githubusercontent.com/yenbekbay/AYGestureHelpView/master/assets/demo.gif)

## Usage

You can show a tutorial for one gesture.

```objc
AYGestureHelpView *helpView = [AYGestureHelpView new];
    [helpView doubleTapWithLabelText:NSLocalizedString(@"Double tap to open the menu", nil) labelPoint:CGPointMake(self.view.center.x, self.view.center.y + 70) touchPoint:self.view.center dismissHandler:nil hideOnDismiss:YES];
```

Or you can chain gestures.

```objc
AYGestureHelpView *helpView = [AYGestureHelpView new];
    [helpView doubleTapWithLabelText:NSLocalizedString(@"Double tap to open the menu", nil) labelPoint:CGPointMake(self.view.center.x, self.view.center.y + 70) touchPoint:self.view.center dismissHandler:^{
        [helpView swipeWithLabelText:NSLocalizedString(@"Swipe to scroll through cards", nil) labelPoint:CGPointMake(self.view.center.x, self.view.center.y + 70) touchStartPoint:CGPointMake(self.view.center.x + 25, self.view.center.y) touchEndPoint:CGPointMake(self.view.center.x - 25, self.view.center.y) dismissHandler:^{
            [helpView swipeWithLabelText:NSLocalizedString(@"Pull down to refresh", nil) labelPoint:CGPointMake(self.view.center.x, self.view.center.y + 70) touchStartPoint:CGPointMake(self.view.center.x, self.view.center.y - 50)  touchEndPoint:self.view.center dismissHandler:^{
                    self.showHelpViewButton.hidden = NO;
                } hideOnDismiss:YES];
        } hideOnDismiss:NO];
    } hideOnDismiss:NO];
```

## Installation

AYGestureHelpView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "AYGestureHelpView"
```

## Author

Ayan Yenbekbay, ayan.yenb@gmail.com

## License

```
Copyright (c) 2015 Ayan Yenbekbay <ayan.yenb@gmail.com>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
```
