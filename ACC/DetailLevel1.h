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

- (IBAction)pushViewController:(id)sender;

@property (nonatomic, assign) SBIAppDelegate *appDelegate;

@end
