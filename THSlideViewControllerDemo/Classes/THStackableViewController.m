//
//  SageStackableViewController.m
//  Sage
//
//  Created by Tommy Hanks on 7/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "THStackableViewController.h"
#import "THStackableContainerViewController.h"
#pragma mark -
#pragma mark Private Interface
@interface THStackableViewController ()
@end

#pragma mark -
@implementation THStackableViewController

#pragma mark Constructors
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self == nil)
    return nil;

  return self;
}

- (void) dealloc
{
  [super dealloc];
}

#pragma mark -
#pragma mark Accessors
@synthesize parentStackViewController = _parentStackViewController;
@synthesize rootController = _rootController;
-(UIView*)contentView
{
	return (UIView*)self.view;
}
#pragma mark - Public Methods
-(void)setContainerViewScrollable:(BOOL)enabled{
  [_parentStackViewController setContainerViewScrollable:enabled];
  _parentStackViewController.stackContainer.scrollEnabled = enabled;
  for (UIView* subview in self.view.subviews) {
    subview.userInteractionEnabled = enabled;
  }
  self.view.userInteractionEnabled = enabled;
}

-(IBAction)popViewController{
  [_parentStackViewController popViewControllerAnimated:true];
}


#pragma mark - Private Methods
-(UIViewController*)rootContainingController{
  THStackableViewController* controller = (THStackableViewController*)self.parentStackViewController;
  
  while (controller.parentStackViewController){
    controller = (THStackableViewController*)controller.parentStackViewController;
  }
  
  return nil;
}

@end
