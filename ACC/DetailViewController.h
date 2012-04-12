//
//  DetailViewController.h
//  NavigatorSplitView
//
//  Created by Kshitiz Ghimire on 1/26/11.
//  Copyright 2011 Kshitiz Ghimire. All rights reserved.
//

#import "SBICatalog.h"
#import "SBIAppDelegate.h"
#import "Project.h"

@interface DetailViewController : UIViewController <UIPopoverControllerDelegate, UISplitViewControllerDelegate, RKObjectLoaderDelegate> {
    
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