//
//  SageStackableViewController.h
//  Sage
//
//  Created by Tommy Hanks on 7/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class THStackableContainerViewController;
@interface THStackableViewController : UIViewController
{
	THStackableContainerViewController* _parentStackViewController; //Parent |SageContainerViewController|
}
@property (assign) THStackableContainerViewController* parentStackViewController;
@property (assign) id rootController; //Root Controller
-(void)setContainerViewScrollable:(BOOL)enabled;

@end
