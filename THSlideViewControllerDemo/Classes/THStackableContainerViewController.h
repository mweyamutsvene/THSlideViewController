//
//  THStackableContainerViewController.h
//
//
//  Created by Tommy Hanks on 7/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
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

