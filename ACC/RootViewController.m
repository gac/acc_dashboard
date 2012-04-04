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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.clearsSelectionOnViewWillAppear = NO;
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
	self.appDelegate = (SBIAppDelegate *)[[UIApplication sharedApplication] delegate];
    
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
    
    _objects = objects;
    [self.tableView reloadData];

//    Project* project = [objects objectAtIndex:0];    
//    NSLog(@"Project: portfolioID->%@, portfolio->%@, projectTypeID->%@, projectType->%@, projectSizeID->%@, projectSize->%@ folio->%@, name->%@, description->%@, isFocus->%@, isKPT->%@", project.portfolio.portfolioID, project.portfolio.name, project.project_type.projectTypeID, project.project_type.description, project.project_size.projectSizeID, project.project_size.size, project.folio, project.name, project.description, project.is_focus, project.is_kpt);
    
//    ProjectType* obj = [objects objectAtIndex:0];    
//    NSLog(@"Obj: %@", obj);


    /*
    NSString* info = [NSString stringWithFormat:
                      @"The count is %@\n"
                      @"The average transaction amount is %@\n"
                      @"The distinct list of payees is: %@",
                      [account transactionsCount],
                      [account averageTransactionAmount],
                      [[account distinctPayees] componentsJoinedByString:@", "]];
    _infoLabel.text = info;
     */
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error {
    NSLog(@"%@", error);
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Rats!" otherButtonTitles:nil];
    [alert show];
 
}


 - (void)viewDidAppear:(BOOL)animated {
     [super viewDidAppear:animated];
     
     self.title = @"Projects";
     
     
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
    return [_objects count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    static NSString *CellIdentifier = @"CellIdentifier";
//    
//    // Dequeue or create a cell of the appropriate type.
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        //cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        cell.accessoryType = UITableViewCellAccessoryNone;
//    }
//    
//    // Configure the cell.
//    cell.textLabel.text = [NSString stringWithFormat:@"Row %d", indexPath.row];
//    return cell;
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    Project* project = (Project*) [_objects objectAtIndex:indexPath.row];
    cell.textLabel.text = project.folio;
    cell.detailTextLabel.text = project.name;
    
    return cell;    
    
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
    
    /*
     When a row is selected, set the detail view controller's detail item to the item associated with the selected row.
     */
	self.detailViewController=(DetailViewController *)[[self.appDelegate.splitViewController.viewControllers objectAtIndex:1] visibleViewController];
    self.detailViewController.detailItem = [NSString stringWithFormat:@"Row %d", indexPath.row];
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

