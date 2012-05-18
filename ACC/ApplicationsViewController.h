//
//  ApplicationsViewController.h
//  ACC Center
//
//  Created by Juan M Galicia on 5/4/12.
//  Copyright (c) 2012 Scotiabank. All rights reserved.
//

#import "SBICatalog.h"
#import "SBIAppDelegate.h"
#import "Project.h"
#import "EGORefreshTableHeaderView.h"

@class ApplicationDetailViewController;

@interface ApplicationsViewController : UIViewController <RKObjectLoaderDelegate, UITableViewDelegate, UITableViewDataSource, EGORefreshTableHeaderDelegate> {
    
    Project* _selectedProject;
    
    NSMutableArray* _listofGroups;
    NSMutableArray* _listofItems;
    
    EGORefreshTableHeaderView *_refreshHeaderView;
    
    //  Reloading var should really be your tableviews datasource
	//  Putting it here for demo purposes 
	BOOL _reloading;
    
}

@property (strong, nonatomic) SBIAppDelegate *appDelegate;

@property (strong, nonatomic) ApplicationDetailViewController *applicationDetailViewController;

@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

-(IBAction)updateTableView:(id)sender;

- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;

@end
