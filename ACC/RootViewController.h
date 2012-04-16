//
//  RootViewController.h
//  NavigatorSplitView
//
//  Created by Kshitiz Ghimire on 1/26/11.
//  Copyright 2011 Kshitiz Ghimire. All rights reserved.
//

#import "SBICatalog.h"
#import "SBIAppDelegate.h"
#import "Project.h"
#import "EGORefreshTableHeaderView.h"


@class DetailViewController;

@interface RootViewController : UIViewController <RKObjectLoaderDelegate, UITableViewDelegate, UITableViewDataSource, EGORefreshTableHeaderDelegate> {

    Project* _selectedProject;
    NSMutableDictionary* _listofPortfolios;
    NSMutableDictionary* _listofProjectGroups;
    
    EGORefreshTableHeaderView *_refreshHeaderView;
    
    //  Reloading var should really be your tableviews datasource
	//  Putting it here for demo purposes 
	BOOL _reloading;

}

@property (strong, nonatomic) SBIAppDelegate *appDelegate;

@property (strong, nonatomic)  DetailViewController *detailViewController;

@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

-(IBAction)updateTableView:(id)sender;

- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;

@end
