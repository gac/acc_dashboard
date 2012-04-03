//
//  DetailViewController.h
//  NavigatorSplitView
//
//  Created by Kshitiz Ghimire on 1/26/11.
//  Copyright 2011 Kshitiz Ghimire. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBIAppDelegate.h"
@interface DetailViewController : UIViewController <UIPopoverControllerDelegate, UISplitViewControllerDelegate> 

@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@property (strong, nonatomic) SBIAppDelegate *appDelegate;

- (IBAction)pushViewController:(id)sender;

- (void)popViewController;

@end