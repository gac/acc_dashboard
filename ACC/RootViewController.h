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
@class DetailViewController;

@interface RootViewController : UIViewController <RKObjectLoaderDelegate, UITableViewDelegate, UITableViewDataSource> {

    Project* _selectedProject;
    NSMutableArray* _listofPortfolios;

}

@property (strong, nonatomic) SBIAppDelegate *appDelegate;

@property (strong, nonatomic)  DetailViewController *detailViewController;

@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

-(IBAction)updateTableView:(id)sender;

@end
