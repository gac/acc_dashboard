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

@interface RootViewController : UITableViewController <RKObjectLoaderDelegate, UITableViewDelegate> {
    Project* _selectedProject;
    NSArray* _projects;
    NSMutableArray* _listofPortfolios;
    UISegmentedControl* _segmentedControl;
}

@property (strong, nonatomic)  DetailViewController *detailViewController;

@property (strong, nonatomic) SBIAppDelegate *appDelegate;

@end
