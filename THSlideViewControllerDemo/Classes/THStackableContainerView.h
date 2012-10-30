//
//  THStackableContainerView.h
//
//  Created by Tommy Hanks on 7/11/12.
//  Copyright 2012 tommymaxhanks.com All rights reserved.
//

#import <UIKit/UIKit.h>

@class THStackableContainerView;

@protocol THStackableContainerViewDelegate
@required
@optional
@end

@interface THStackableContainerView : UIView  
{
  UIScrollView* _scrollView; //Container must contain scrollView
  UIView* _shadow;           //Not necessary, but adds cool effect
  UIView* _underView;
	NSObject<THStackableContainerViewDelegate>* _delegate;
}
@property (assign) NSObject<THStackableContainerViewDelegate>* delegate;
@property (assign) IBOutlet UIScrollView* scrollView;
@property (assign) IBOutlet UIView* shadow;
@property (assign) IBOutlet UIView* underView;

@end