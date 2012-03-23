//
//  DetailLevel1.h
//  SplitView
//
//  Created by Kshitiz Ghimire on 1/24/11.
//  Copyright 2011 Javra Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SBIAppDelegate;
@interface DetailLevel1 : UIViewController <UISplitViewControllerDelegate>
/*
{
    
	UIPopoverController *popoverController;
	NavigatorSplitViewAppDelegate *appDelegate;
}
 */
@property (nonatomic, retain) UIPopoverController *popoverController;

- (IBAction)pushViewController:(id)sender;

-(void)popViewController;

@property (nonatomic, assign) SBIAppDelegate *appDelegate;

@end
