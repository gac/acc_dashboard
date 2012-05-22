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

@interface DetailViewController : UIViewController <UIPopoverControllerDelegate, UISplitViewControllerDelegate, RKObjectLoaderDelegate, UITableViewDelegate, UITableViewDataSource> {
    
    UIPopoverController *popoverController;
    
    NSMutableArray* _listofStakeholders;
    NSMutableArray* _listofResponsibles;
    NSMutableArray* _listofProcesses;
    
}

@property (strong, nonatomic) SBIAppDelegate *appDelegate;

@property (strong, nonatomic) id itemID;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)pushViewController:(id)sender;

- (void)popViewController;

@end