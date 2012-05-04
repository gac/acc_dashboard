//
//  RootViewController.m
//  NavigatorSplitView
//
//  Created by Kshitiz Ghimire on 1/26/11.
//  Copyright 2011 Kshitiz Ghimire. All rights reserved.
//


#import <RestKit/RestKit.h>
#import "RootViewController.h"
#import "DetailViewController.h"
#import "Project.h"
#import "ProjectGroup.h"


@implementation RootViewController


@synthesize appDelegate;
@synthesize detailViewController;
@synthesize tableView = _tableView;
@synthesize segmentedControl = _segmentedControl;


#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {

    [super viewDidLoad];

    self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
	self.appDelegate = (SBIAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    _listofGroups = [[NSMutableArray alloc] init];
    _listofItems = [[NSMutableArray alloc] init];    
    
    if (self) {
        [RKObjectManager objectManagerWithBaseURL:gSBICatalogBaseURL];
    }
    
    RKObjectMapping* portfolioMapping = [RKObjectMapping mappingForClass:[Portfolio class]];
    [portfolioMapping mapKeyPath:@"id" toAttribute:@"portfolioID"];
    [portfolioMapping mapKeyPath:@"name" toAttribute:@"name"];
    
    RKObjectMapping* projectMapping = [RKObjectMapping mappingForClass:[Project class]];
    [projectMapping mapKeyPath:@"id" toAttribute:@"projectID"];
    [projectMapping mapRelationship:@"portfolio" withMapping:portfolioMapping];     
    [projectMapping mapKeyPath:@"folio" toAttribute:@"folio"];
    [projectMapping mapKeyPath:@"name" toAttribute:@"name"];
    
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:@"projects/resources/projects/" objectMapping:projectMapping delegate:self];
    
    if (_refreshHeaderView == nil) {
		
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height)];
		view.delegate = self;
		[self.tableView addSubview:view];
		_refreshHeaderView = view;
		
	}
	
	//  update the last update date
	[_refreshHeaderView refreshLastUpdatedDate];

}


 - (void)viewWillAppear:(BOOL)animated {
     
     [super viewWillAppear:animated];

 }


- (void)objectLoader:(RKObjectLoader*)objectLoader didLoadObjects:(NSArray*)objects {
    
    [_listofGroups removeAllObjects];
    [_listofItems removeAllObjects];
    
    if (_segmentedControl.selectedSegmentIndex == 0) {
        
        // By Portfolio
        
        NSMutableDictionary* portfolios = [[NSMutableDictionary alloc] init];
        
        for (id object in objects) {
            
            Project* project = (Project*) object;
            NSMutableArray* projects = nil;
            
            if (![portfolios objectForKey:project.portfolio.name]) {
                
                projects = [[NSMutableArray alloc] init];
                
            } else {
                
                projects = [portfolios objectForKey:project.portfolio.name];
                
            }
            
            [projects addObject:project];
            [portfolios setValue:projects forKey:project.portfolio.name];
            
        }

        NSMutableArray* unorderPortfolioNames = [[NSMutableArray alloc] init];
        
        NSEnumerator* enumerator = [portfolios keyEnumerator];
        id key;
        while ((key = [enumerator nextObject])) {
            
            [unorderPortfolioNames addObject:key];
            
        }

        NSArray* orderPortfolioNames = [unorderPortfolioNames sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
                               
        for (id portfolioName in orderPortfolioNames) {
            
            NSArray* array = (NSArray*) [portfolios objectForKey:portfolioName];
          
            [_listofGroups addObject:portfolioName];
            [_listofItems addObject:array];
            
        }

    } else {
        
        // By Project Group

        for (id object in objects) {
            
            ProjectGroup* projectGroup = (ProjectGroup*) object;
            
            NSMutableArray* projects = [[NSMutableArray alloc] init];
            
            for (id obj in projectGroup.projects) {
                
                Project* project = (Project*) obj;
                [projects addObject:project];
                
            }
            
            NSArray* array = (NSArray*) projects;
            [_listofGroups addObject:projectGroup.name];
            [_listofItems addObject:array];
            
        }
        
    }
    
  	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil];
    
    [self.tableView reloadData];

}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error {

    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Cancel!" otherButtonTitles:nil];
    [alert show];
 
}


 - (void)viewDidAppear:(BOOL)animated {
     
     [super viewDidAppear:animated];

     self.title = @"IT Projects";

 }
 

 - (void)viewWillDisappear:(BOOL)animated {
     
     [super viewWillDisappear:animated];
     
 }
 

 - (void)viewDidDisappear:(BOOL)animated {
     
     [super viewDidDisappear:animated];
     
 }
 

// Ensure that the view controller supports rotation and that the split view can therefore show in both portrait and landscape.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    return YES;
    
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView {
    
    // Return the number of sections.
    return [_listofGroups count];
    
}


- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.    
    return [[_listofItems objectAtIndex:section] count];

}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {

    return [_listofGroups objectAtIndex:section];

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CellIdentifier";

    // Dequeue or create a cell of the appropriate type.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.textLabel.textColor = [UIColor blackColor];
    
    Project* project = (Project*) [[_listofItems objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];

    cell.textLabel.text = project.name;
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    cell.detailTextLabel.text = project.folio;
    
    return cell;    
    
}


- (IBAction)updateTableView:(id)sender {
    
    RKObjectMapping* portfolioMapping = [RKObjectMapping mappingForClass:[Portfolio class]];
    [portfolioMapping mapKeyPath:@"id" toAttribute:@"portfolioID"];
    [portfolioMapping mapKeyPath:@"name" toAttribute:@"name"];
        
    RKObjectMapping* projectMapping = [RKObjectMapping mappingForClass:[Project class]];
    [projectMapping mapKeyPath:@"id" toAttribute:@"projectID"];
    [projectMapping mapRelationship:@"portfolio" withMapping:portfolioMapping];     
    [projectMapping mapKeyPath:@"folio" toAttribute:@"folio"];
    [projectMapping mapKeyPath:@"name" toAttribute:@"name"];
    
    RKObjectMapping* projectGroupMapping = [RKObjectMapping mappingForClass:[ProjectGroup class]];
    [projectGroupMapping mapKeyPath:@"id" toAttribute:@"projectGroupID"];
    [projectGroupMapping mapKeyPath:@"name" toAttribute:@"name"];
    [projectGroupMapping addRelationshipMapping:[RKObjectRelationshipMapping mappingFromKeyPath:@"projects" toKeyPath:@"projects" withMapping:projectMapping]];
    
    switch (_segmentedControl.selectedSegmentIndex) {
        // By Portfolio
        case 0:
            
            [[RKObjectManager sharedManager] loadObjectsAtResourcePath:@"projects/resources/projects/" objectMapping:projectMapping delegate:self];
            break;
            
        // By Project Group
        case 1:;

            [[RKObjectManager sharedManager] loadObjectsAtResourcePath:@"projects/resources/project/groups/" objectMapping:projectGroupMapping delegate:self];
            break;

        default:            
            break;
    }

}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */


/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    _selectedProject = [[_listofItems objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    /*
     When a row is selected, set the detail view controller's detail item to the item associated with the selected row.
     */
	self.detailViewController=(DetailViewController *)[[self.appDelegate.splitViewController.viewControllers objectAtIndex:1] visibleViewController];
    self.detailViewController.itemID = [NSString stringWithFormat:@"%@", _selectedProject.projectID];
    
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    //[detailViewController release];
    //[super dealloc];
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
	
	//  should be calling your tableviews data source model to reload
	//  put here just for demo
	_reloading = YES;
	
}

- (void)doneLoadingTableViewData{
	
	//  model should call this when its done loading
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
	
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{	
	
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
	
}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
	[self reloadTableViewDataSource];
    
    RKObjectMapping* portfolioMapping = [RKObjectMapping mappingForClass:[Portfolio class]];
    [portfolioMapping mapKeyPath:@"id" toAttribute:@"portfolioID"];
    [portfolioMapping mapKeyPath:@"name" toAttribute:@"name"];
    
    RKObjectMapping* projectMapping = [RKObjectMapping mappingForClass:[Project class]];
    [projectMapping mapKeyPath:@"id" toAttribute:@"projectID"];
    [projectMapping mapRelationship:@"portfolio" withMapping:portfolioMapping];     
    [projectMapping mapKeyPath:@"folio" toAttribute:@"folio"];
    [projectMapping mapKeyPath:@"name" toAttribute:@"name"];
    
    RKObjectMapping* projectGroupMapping = [RKObjectMapping mappingForClass:[ProjectGroup class]];
    [projectGroupMapping mapKeyPath:@"id" toAttribute:@"projectGroupID"];
    [projectGroupMapping mapKeyPath:@"name" toAttribute:@"name"];
    [projectGroupMapping addRelationshipMapping:[RKObjectRelationshipMapping mappingFromKeyPath:@"projects" toKeyPath:@"projects" withMapping:projectMapping]];
    
    switch (_segmentedControl.selectedSegmentIndex) {
            // By Portfolio
        case 0:
            
            [[RKObjectManager sharedManager] loadObjectsAtResourcePath:@"projects/resources/projects/" objectMapping:projectMapping delegate:self];
            break;
            
            // By Project Group
        case 1:;
            
            [[RKObjectManager sharedManager] loadObjectsAtResourcePath:@"projects/resources/project/groups/" objectMapping:projectGroupMapping delegate:self];
            break;
            
        default:            
            break;
    }
	
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _reloading; // should return if data source model is reloading
	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}



@end