//
//  THStackableContainerViewController.h
//
//
//  Created by Tommy Hanks on 7/11/12.
//  Copyright 2012 www.tommymaxhanks.com All rights reserved.
//
//
// This code is distributed under the terms and conditions of the MIT license.
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import <UIKit/UIKit.h>
#import "THStackableViewController.h"
@class THStackableContainerViewController;
@protocol THStackableContainerViewControllerDelegate
@required
@optional
@end
@interface THStackableContainerViewController : THStackableViewController
{
	UIScrollView* _stackContainer;
  UITableView* _tableView;
  
  BOOL _childViewIsShowing;
  THStackableViewController* _childStackViewController;
	NSObject<THStackableContainerViewControllerDelegate>* _delegate;
}

@property (assign) NSObject<THStackableContainerViewControllerDelegate>* delegate;
@property (assign) IBOutlet UIView* shadow; //Shadow when the container view contains content

//Every |THStackableContainerViewController| subclass can implement a |UITableView|
//and must implement a |UIScrollView| for containing content
@property (assign) IBOutlet UIScrollView* stackContainer;
@property (assign) IBOutlet UITableView* tableView;

//Threashold for swiping scale property - 0(lowest) - 1(highest)
@property (assign) float swipeThreshhold;

//Changes the current shadow's opacity
-(void)adjustShadow:(float)opacity;

//Pushes new controller's view into the |_stackContainer| scroller
-(void)pushViewController:(THStackableViewController*)controller animated:(BOOL)animated;

//The controller's child controller's view was just popped
-(void)childViewWasPoppedFromContainer:(BOOL)animated;

//Causes the controller to pop
-(IBAction)popViewControllerAnimated:(BOOL)animated;
@end

