//
//  SageStackableViewController.m
//  Sage
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
