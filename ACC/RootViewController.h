//
//  RootViewController.h
//  NavigatorSplitView
//
//  Created by Kshitiz Ghimire on 1/26/11.
//  Copyright 2011 Kshitiz Ghimire. All rights reserved.
//

#import "SBICatalog.h"
#import "SBIAppDelegate.h"
@class DetailViewController;

@interface RootViewController : UITableViewController <RKObjectLoaderDelegate>

@property (strong, nonatomic)  DetailViewController *detailViewController;

@property (strong, nonatomic) SBIAppDelegate *appDelegate;

@end
