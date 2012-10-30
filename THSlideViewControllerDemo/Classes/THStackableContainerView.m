//
//  THStackableContainerView.m
//  
//
//  Created by Tommy Hanks on 7/11/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "THStackableContainerView.h"
#define kTHCloseButtonTag 500
#define kTHScrollViewTag 501
#define kTHTargetViewTag 502
#define kTHContainerViewTag 503

#pragma mark -
#pragma mark Private Interface
@interface THStackableContainerView ()
@end

#pragma mark -
@implementation THStackableContainerView

#pragma mark Constructors
- (id) initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
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
@synthesize delegate = _delegate;
@synthesize shadow = _shadow;
@synthesize scrollView = _scrollView;
@synthesize underView = _underView;

#pragma mark -
#pragma mark Override Methods

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {  
  _scrollView.tag = kTHScrollViewTag;
  _underView.tag = kTHTargetViewTag;

  UIButton* closeButton = (UIButton*)[self viewWithTag:kTHCloseButtonTag];
  CGRect rect = [closeButton.superview convertRect:closeButton.frame toView:self];
  if (CGRectContainsPoint(rect, point)) {
    return closeButton;
  }
   
  // create enumerator
  NSEnumerator* enumerator = [_scrollView.subviews reverseObjectEnumerator];
  UIView *view = nil;
  id item = nil;

  // enumarate pages in reverse order
  while ((item = [enumerator nextObject])) {
    if (item != [NSNull null]) {

      UIView* page = (UIView*)item;
      CGRect rect = [_scrollView convertRect:page.frame toView:self];

      //Check to see if |page| qualifies as a possible view that was touched
      if (CGRectContainsPoint(rect, point)) {
        
        //Covert point to an even more exact point in reference to |page|
        CGPoint newPoint = [self convertPoint:point toView:page];
        
        //Get the view that was touched
        view = [page hitTest:newPoint withEvent:event];
       
        //If view was the shadow return the targeted view underneath shadow
        if(view == _shadow){
          view= [[view.superview viewWithTag:kTHTargetViewTag] hitTest:point withEvent:event];

        }
        //If view was a scrollview return the targeted view underneath scrollview
        else if([view isKindOfClass:[UIScrollView class]] && view.tag == kTHContainerViewTag){
          view= [[view.superview viewWithTag:kTHTargetViewTag] hitTest:point withEvent:event];
        }
        break;
      }
    }
  } 

  //Return the selected view if found
  if (view != nil) {
    return view;
  }
  
  //if scrollview doesn't exist - meaning this isn't a |SageContainerViewController| view
  //return the parent's hitest
  if(!_scrollView){
    return [super hitTest:point withEvent:event];
  }
  
  //If we are hitting the shadow, return the Targeted view's parent hitTest 
  if (CGRectContainsPoint(_shadow.frame, point) || CGRectContainsPoint(_scrollView.frame, point)) {
    return [[self viewWithTag:kTHTargetViewTag] hitTest:point withEvent:event];
  }
  
  //Return parents hittest
  return [super hitTest:point withEvent:event];
}

@end
