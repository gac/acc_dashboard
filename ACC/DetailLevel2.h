//
//  DetailLevel2.h
//  SplitView
//
//  Created by Kshitiz Ghimire on 1/24/11.
//  Copyright 2011 Javra Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SBIAppDelegate;

@interface DetailLevel2 : UIViewController<UISplitViewControllerDelegate> 

/*
{
    
	UIPopoverController *popoverController;
	NavigatorSplitViewAppDelegate *appDelegate;
}
 */
@property(nonatomic ,retain) UIPopoverController *popoverController;

@property (nonatomic, assign) SBIAppDelegate *appDelegate;

@end
