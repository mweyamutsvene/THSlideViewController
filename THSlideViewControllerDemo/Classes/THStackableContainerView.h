//
//  THStackableContainerView.h
//
//  Created by Tommy Hanks on 7/11/12.
//  Copyright 2012 tommymaxhanks.com All rights reserved.
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