//
//  DemoRootViewController.m
//  THSlideViewControllerDemo
//
//  Created by Thomas Hanks on 10/16/12.
//  Copyright (c) 2012 Thomas Hanks. All rights reserved.
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

#import "DemoRootViewController.h"
#import "DemoStackableViewController.h"
@interface DemoRootViewController ()

@end

@implementation DemoRootViewController

#pragma mark - Constructors
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)dealloc{
  [super dealloc];
}

#pragma mark - IBActions
-(IBAction)buttonPushed:(id)sender{
  
  if(_childStackViewController){
    [((THStackableContainerViewController*)_childStackViewController) popViewControllerAnimated:true];
    //reload |_childStackViewController| here
    return;
  }
  DemoStackableViewController* controller = [[[DemoStackableViewController alloc] initWithNibName:@"DemoStackableView" bundle:nil] autorelease];
  controller.swipeThreshhold = .5;

  [self pushViewController:controller animated:true];
}

#pragma mark - UIViewController Overrides
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}



@end
