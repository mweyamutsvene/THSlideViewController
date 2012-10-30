//
//  SageContainerViewController.m
//  Sage
//
//  Created by Tommy Hanks on 7/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "THStackableContainerViewController.h"
#import "THStackableContainerView.h"

#import <QuartzCore/QuartzCore.h>

#define kLeftMargin .25
#define kShadowOpacity 0.2f
#define kLayerShadowTag 5000
#pragma mark -
#pragma mark Private Interface
@interface THStackableContainerViewController ()<UIScrollViewDelegate>
@end

#pragma mark -
@implementation THStackableContainerViewController

#pragma mark Constructors
- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self == nil)
    return nil;
  
  return self;
}

- (void) dealloc
{
  [_childStackViewController release];
  _childStackViewController = nil;
  [super dealloc];
}

#pragma mark -
#pragma mark Accessors
@synthesize delegate = _delegate;
@synthesize shadow = _shadow;
@synthesize stackContainer = _stackContainer;
@synthesize tableView = _tableView;
@synthesize swipeThreshhold = _swipeThreshhold;

-(THStackableContainerView*)contentView
{
	return (THStackableContainerView*)self.view;
}

#pragma mark - Public Methods
-(void)adjustShadow:(float)opacity{
  //Change the shadow and the parents shadow based on self's shadow
  if(opacity >=1)
    self.shadow.alpha = .9;
  else{
    self.shadow.alpha = opacity;
  }
  //adjust parent's shadow based on this shadow
  [_parentStackViewController adjustShadow:opacity + kShadowOpacity];  
}

-(void)pushViewController:(THStackableViewController*)controller animated:(BOOL)animated{
  //Resign all textfields before pushing
  [self.view endEditing:true];

  //assigns the |SageRootViewController| to new controller
  controller.rootController = self.rootController;
  controller.parentStackViewController = self;

  //If for some reason we already have a |_childStackViewController| remove its view
  //and release it
  if([_childStackViewController isKindOfClass:[THStackableContainerViewController class]]){
    [((THStackableContainerViewController*) _childStackViewController) popViewControllerAnimated:false];
  }
  [_childStackViewController.view removeFromSuperview];
  [_childStackViewController release];
  
  //If the |_stackContainer| already contains the sliver shadow, remove it
  [[_stackContainer viewWithTag:kLayerShadowTag] removeFromSuperview];

  //Set the |_stackContainer| delegate
  _stackContainer.delegate =self;

  //Create a new sliver shadow
  UIView* layerView = [[UIView alloc] initWithFrame:CGRectMake(_stackContainer.frame.size.width*kLeftMargin, 0, 10, _stackContainer.frame.size.height)];
  layerView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
  layerView.backgroundColor = [UIColor colorWithWhite:0 alpha:1];
  layerView.layer.shadowOpacity = 1;
  layerView.layer.shouldRasterize = true;
  layerView.layer.shadowRadius = 6;
  layerView.tag =kLayerShadowTag;
    
  //Add the new controller's view to the container
  _childStackViewController = [controller retain];
  [_stackContainer addSubview:layerView];
  [_stackContainer addSubview:_childStackViewController.view];
 
  //Set |_childStackViewController| view to fit inside |_stackContainer|
  _childStackViewController.view.frame =CGRectIntegral( CGRectMake(_stackContainer.frame.size.width*kLeftMargin, 0, _stackContainer.frame.size.width, _stackContainer.frame.size.height));
  _stackContainer.contentSize = CGSizeMake(_stackContainer.frame.size.width*(1+kLeftMargin), _stackContainer.frame.size.height);
  
  //Animate the transition if needed
  if(animated){
    [_stackContainer setContentOffset:CGPointMake(-_stackContainer.frame.size.width*1.5, 0)];
    
    [UIView animateWithDuration:.45 animations:^{
      [_stackContainer setContentOffset:CGPointMake(_stackContainer.frame.size.width*kLeftMargin-2, 0)];
      [self adjustShadow:kShadowOpacity];
    } completion:^(BOOL finished) {
      _childViewIsShowing = true;
    }];
  }
  else{
    [_stackContainer setContentOffset:CGPointMake(_stackContainer.frame.size.width*kLeftMargin-2, 0)];
    [self adjustShadow:kShadowOpacity];
    _childViewIsShowing = true;
    
  }
}

//
//Pops the stacked view controller
-(IBAction)popViewControllerAnimated:(BOOL)animated{
  //If no child no pop
  if(!_childStackViewController)
    return;
  
  if([_childStackViewController isKindOfClass:[THStackableContainerViewController class]]){
    [((THStackableContainerViewController*) _childStackViewController) popViewControllerAnimated:false];
  }
  
  //Animate pop if needed
  if(animated){
    [UIView animateWithDuration:.45 animations:^{
      [_stackContainer setContentOffset:CGPointMake(-_stackContainer.frame.size.width*1.5, 0)];
      [self adjustShadow:0];
      _childViewIsShowing = false;
      
    } completion:^(BOOL finished) {
      [_childStackViewController.view removeFromSuperview];
      [_childStackViewController release];
      _childStackViewController = nil;
      [_stackContainer.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
      [self childViewWasPoppedFromContainer:true];
    }];
  }
  else{
    [_stackContainer setContentOffset:CGPointMake(-_stackContainer.frame.size.width*1.5, 0)];
    [self adjustShadow:0];
    _childViewIsShowing = false;
    [_childStackViewController.view removeFromSuperview];
    [_childStackViewController release];
    _childStackViewController = nil;
    [_stackContainer.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self childViewWasPoppedFromContainer:true];

  }
}

-(void)childViewWasPoppedFromContainer:(BOOL)animated{
  //Override point for subclassing
}


#pragma mark - Private Methods
  

#pragma mark -
#pragma mark UIViewController Overrides
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
  [super viewWillAppear:animated];
}

-(void)viewDidAppear:(BOOL)animated{
  [super viewDidAppear:animated];
  
}

- (void)didReceiveMemoryWarning {
  // Releases the view if it doesn't have a superview.
  [super didReceiveMemoryWarning];
  
  // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
  [super viewDidUnload];
  // Release any retained subviews of the main view.
  // e.g. self.myOutlet = nil;
}

-(BOOL)shouldAutorotate{
  return [self shouldAutorotateToInterfaceOrientation:self.interfaceOrientation];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
  //Set |_childStackViewController| view to fit inside |_stackContainer|
  _childStackViewController.view.frame =CGRectIntegral( CGRectMake(_stackContainer.frame.size.width*kLeftMargin, 0, _stackContainer.frame.size.width, _stackContainer.frame.size.height));
  _stackContainer.contentSize = CGSizeMake(_stackContainer.frame.size.width*(1+kLeftMargin), _stackContainer.frame.size.height);
  if(_childStackViewController){
    [_childStackViewController shouldAutorotate];
  }
  return true;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
  if([scrollView isKindOfClass:[UITableView class]])
    return;
  if(scrollView.contentOffset.x <=0){
    [scrollView setContentOffset:CGPointMake(1, 0) animated:false];
  }
  if(scrollView.contentOffset.x >=_childStackViewController.view.frame.origin.x){
    [scrollView setContentOffset:CGPointMake(_childStackViewController.view.frame.origin.x-1, 0) animated:false];
  }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    
  //Save the current frame for the scrollview
  CGRect  scrollViewStartingFrame = scrollView.frame;
  float threshold = _swipeThreshhold;
  
  //Change the frame of the scroll view when the content offset reaches threshhold
  if(scrollView.contentOffset.x < (-200 * threshold)){
    
    //Only do this if we are currently showing the child view
    if(_childViewIsShowing){
      [UIView animateWithDuration:.35  animations:^{
        CGRect  scrollViewEndFrame = scrollViewStartingFrame;
        scrollViewEndFrame.origin.x = scrollViewEndFrame.size.width * 1.5;
        scrollView.frame = scrollViewEndFrame;
        [self adjustShadow:0];

      } completion:^(BOOL finished) {
        //Pop old view controller
        [self popViewControllerAnimated:false];
        [_stackContainer.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        scrollView.frame = scrollViewStartingFrame;
  
        //Reset scrollview
        [_stackContainer setContentOffset:CGPointMake(-_stackContainer.frame.size.width*1.5, 0)];
        _childViewIsShowing = false;
        
        //Inform all subclasses that the child was popped
        [self childViewWasPoppedFromContainer:true];
      }];
    }
  }
  else{
    if(scrollView.contentOffset.x <=0 )
      targetContentOffset->x = 1; 
    if(scrollView.contentOffset.x >=_childStackViewController.view.frame.origin.x)
      targetContentOffset->x = _childStackViewController.view.frame.origin.x-1; 

  }
}

@end
