//
//  DemoStackableViewController.m
//  THSlideViewControllerDemo
//
//  Created by Thomas Hanks on 10/16/12.
//  Copyright (c) 2012 Thomas Hanks. All rights reserved.
//

#import "DemoStackableViewController.h"

@interface DemoStackableViewController ()

@end

@implementation DemoStackableViewController
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
  [self pushViewController:controller animated:true];
  controller.swipeThreshhold = .5;

 }

#pragma mark - UIViewController Overrides
- (void)viewDidLoad
{
  [super viewDidLoad];
	// Do any additional setup after loading the view.
}




@end
