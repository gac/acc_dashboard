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


@implementation RootViewController

@synthesize detailViewController;
@synthesize appDelegate;

#pragma mark -
#pragma mark View lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        NSArray* items = [NSArray arrayWithObjects:@"By Portfolio", @"By Project Group", nil];
        _segmentedControl = [[UISegmentedControl alloc] initWithItems:items];
        _segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
        _segmentedControl.momentary = NO;
        [_segmentedControl addTarget:self action:@selector(updateTableView) forControlEvents:UIControlEventValueChanged];
        _segmentedControl.selectedSegmentIndex = 0;

    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.clearsSelectionOnViewWillAppear = NO;
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
	self.appDelegate = (SBIAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    _listofPortfolios = [[NSMutableArray alloc] init];
    
    if (self) {
        [RKObjectManager objectManagerWithBaseURL:gSBICatalogBaseURL];
    }
    
    RKObjectMapping* portfolioMapping = [RKObjectMapping mappingForClass:[Portfolio class]];
    [portfolioMapping mapKeyPath:@"id" toAttribute:@"portfolioID"];
    [portfolioMapping mapKeyPath:@"name" toAttribute:@"name"];
    
    RKObjectMapping* projectTypeMapping = [RKObjectMapping mappingForClass:[ProjectType class]];     
    [projectTypeMapping mapKeyPath:@"id" toAttribute:@"projectTypeID"];
    [projectTypeMapping mapKeyPath:@"description" toAttribute:@"description"];
    
    RKObjectMapping* projectSizeMapping = [RKObjectMapping mappingForClass:[ProjectSize class]];
    [projectSizeMapping mapKeyPath:@"id" toAttribute:@"projectSizeID"];
    [projectSizeMapping mapKeyPath:@"size" toAttribute:@"size"];
    
    RKObjectMapping* projectMapping = [RKObjectMapping mappingForClass:[Project class]];
    [projectMapping mapRelationship:@"portfolio" withMapping:portfolioMapping];     
    [projectMapping mapRelationship:@"project_type" withMapping:projectTypeMapping];
    [projectMapping mapRelationship:@"project_size" withMapping:projectSizeMapping];
    [projectMapping mapKeyPath:@"folio" toAttribute:@"folio"];
    [projectMapping mapKeyPath:@"name" toAttribute:@"name"];
    [projectMapping mapKeyPath:@"description" toAttribute:@"description"];
    [projectMapping mapKeyPath:@"is_focus" toAttribute:@"is_focus"];
    [projectMapping mapKeyPath:@"is_kpt" toAttribute:@"is_kpt"];  
    
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:@"projects/resources/projects/" objectMapping:projectMapping delegate:self];

}


 - (void)viewWillAppear:(BOOL)animated {
     [super viewWillAppear:animated];
 }

- (void)objectLoader:(RKObjectLoader*)objectLoader didLoadObjects:(NSArray*)objects {
    
    _projects = objects;
    [self.tableView reloadData];

}


- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error {

    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Rats!" otherButtonTitles:nil];
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
    return 1;
}


- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [_projects count];
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
    
    Portfolio* portfolio = nil;    
    Project* project = nil;

    
    switch (_segmentedControl.selectedSegmentIndex) {
        // All
        case 0:
            project = (Project*) [_projects objectAtIndex:indexPath.row];
            cell.textLabel.text = project.name;
            cell.textLabel.font = [UIFont systemFontOfSize:12];
            cell.detailTextLabel.text = project.folio;
            break;
            
        // By Portfolio
        case 1:;
            portfolio = (Portfolio*) [_projects objectAtIndex:indexPath.row];
            cell.textLabel.text = portfolio.name;
            break;
            
        // By Project Group
        case 2:
            break;
            
        default:            
            break;
    }

    
    
    
    
    return cell;    
    
}

- (void)updateTableView {
//    [_articles release];
//    NSFetchRequest* fetchRequest = [self fetchRequestForSelectedSegment];
//    _articles = [[Article objectsWithFetchRequest:fetchRequest] retain];
    
    switch (_segmentedControl.selectedSegmentIndex) {
        // All
        case 0:
            break;
            
        // By Portfolio
        case 1:;
            break;
            
        // By Project Group
        case 2:
            break;
            
        default:            
            break;
    }
    
    
    [self.tableView reloadData];
}

- (void)requestForSelectedSegment {
    
    RKObjectMapping* portfolioMapping = nil;

    switch (_segmentedControl.selectedSegmentIndex) {
        // All
        case 0:
            break;
                        
        // By Portfolio
        case 1:;
            NSLog(@"test");
            portfolioMapping = [RKObjectMapping mappingForClass:[Portfolio class]];
            [portfolioMapping mapKeyPath:@"name" toAttribute:@"name"];
            [[RKObjectManager sharedManager] loadObjectsAtResourcePath:@"projects/resources/portfolios/" objectMapping:portfolioMapping delegate:self];
            break;

        // By Project Group
        case 2:
                        NSLog(@"test");
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
    
    _selectedProject = [_projects objectAtIndex:indexPath.row];
    
    [self.tableView reloadData];    
    UITableViewCell* cell = [aTableView cellForRowAtIndexPath:indexPath];
    //cell.accessoryType = UITableViewCellAccessoryCheckmark;
    //cell.textLabel.font = [UIFont boldSystemFontOfSize:12];
    cell.textLabel.textColor = [UIColor blueColor];
    cell.backgroundColor = [UIColor colorWithRed:0.95f green:0.95f blue:0.95f alpha:1.0f];
    
    /*
     When a row is selected, set the detail view controller's detail item to the item associated with the selected row.
     */
	self.detailViewController=(DetailViewController *)[[self.appDelegate.splitViewController.viewControllers objectAtIndex:1] visibleViewController];

    self.detailViewController.name = [NSString stringWithFormat:@"%@", _selectedProject.name];
    self.detailViewController.folio = [NSString stringWithFormat:@"%@", _selectedProject.folio];
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {    
    return _segmentedControl;
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


@end

