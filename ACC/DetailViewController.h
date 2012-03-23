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

/*
{
    
    UIPopoverController *popoverController;
    
    
    id detailItem;
    UILabel *detailDescriptionLabel;
	SBIAppDelegate *appDelegate;
}
 */



@property (nonatomic, retain) id detailItem;

@property (nonatomic, retain) IBOutlet UILabel *detailDescriptionLabel;

@property (nonatomic, assign) SBIAppDelegate *appDelegate;

- (IBAction)pushViewController:(id)sender;

-(void)popViewController;

@end
