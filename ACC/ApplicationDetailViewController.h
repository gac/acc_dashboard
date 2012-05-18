//
//  ApplicationDetailViewController.h
//  ACC Center
//
//  Created by Juan M Galicia on 5/4/12.
//  Copyright (c) 2012 Scotiabank. All rights reserved.
//


#import "SBICatalog.h"
#import "SBIAppDelegate.h"
#import "Project.h"


@interface ApplicationDetailViewController : UIViewController <UIPopoverControllerDelegate, UISplitViewControllerDelegate, RKObjectLoaderDelegate> {
    
    UIPopoverController *popoverController;
    
}

@property (strong, nonatomic) SBIAppDelegate *appDelegate;

@property (strong, nonatomic) id itemID;

@property (strong, nonatomic) IBOutlet UILabel *projectTypeTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *projectSizeTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *focusTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *kptTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *descriptionTitleLabel;

@property (strong, nonatomic) IBOutlet UILabel *folioLabel;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *projectTypeLabel;
@property (strong, nonatomic) IBOutlet UILabel *projectSizeLabel;
@property (strong, nonatomic) IBOutlet UILabel *focusLabel;
@property (strong, nonatomic) IBOutlet UILabel *kptLabel;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;

- (IBAction)pushViewController:(id)sender;

- (void)popViewController;

@end