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
    
    _listofPortfolios = [[NSMutableDictionary alloc] init];
    _listofProjectGroups = [[NSMutableDictionary alloc] init];
    
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
    [projectMapping mapKeyPath:@"id" toAttribute:@"projectID"];
    [projectMapping mapRelationship:@"portfolio" withMapping:portfolioMapping];     
    [projectMapping mapRelationship:@"project_type" withMapping:projectTypeMapping];
    [projectMapping mapRelationship:@"project_size" withMapping:projectSizeMapping];
    [projectMapping mapKeyPath:@"folio" toAttribute:@"folio"];
    [projectMapping mapKeyPath:@"name" toAttribute:@"name"];
    [projectMapping mapKeyPath:@"description" toAttribute:@"description"];
    [projectMapping mapKeyPath:@"is_focus" toAttribute:@"is_focus"];
    [projectMapping mapKeyPath:@"is_kpt" toAttribute:@"is_kpt"];
    [projectMapping mapKeyPath:@"url" toAttribute:@"url"];
    
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:@"projects/resources/projects/" objectMapping:projectMapping delegate:self];

}


 - (void)viewWillAppear:(BOOL)animated {
     
     [super viewWillAppear:animated];

 }


- (void)objectLoader:(RKObjectLoader*)objectLoader didLoadObjects:(NSArray*)objects {

    NSMutableDictionary* portfolios = [[NSMutableDictionary alloc] init];
    
    switch (_segmentedControl.selectedSegmentIndex) {
        // By Portfolio
        case 0:
            
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
            
            break;
            
        // By Project Group
        case 1:
            
            [_listofProjectGroups removeAllObjects];
            
            for (id object in objects) {
                ProjectGroup* projectGroup = (ProjectGroup*) object;
                
                NSMutableArray* projects = [[NSMutableArray alloc] init];

                for (id obj in projectGroup.projects) {
                    
                    Project* project = (Project*) obj;
                    [projects addObject:project];

                }
                
                NSArray* array = (NSArray*) projects;
                [_listofProjectGroups setValue:array forKey:projectGroup.name];
                
            }

            break;
            
        default:            
            break;
    }
    
    if (_segmentedControl.selectedSegmentIndex == 0) {
    
        [_listofPortfolios removeAllObjects];
    
        NSEnumerator* enumerator = [portfolios keyEnumerator];
        id key;
        while ((key = [enumerator nextObject])) {
        
            NSMutableArray* projects = [portfolios objectForKey:key];
            NSArray* array = (NSArray*) projects;
            NSString* str = (NSString*) key;
            [_listofPortfolios setValue:array forKey:str];

        }   

    } 
    
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
    
    if (_segmentedControl.selectedSegmentIndex == 0) {
            return [_listofPortfolios count];
    } else {
            return [_listofProjectGroups count];
    }
    
}


- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    NSArray* projects = nil;
    
    if (_segmentedControl.selectedSegmentIndex == 0) {
        
        NSArray* keys = [_listofPortfolios allKeys];
        id aKey = [keys objectAtIndex:section];
        projects = [_listofPortfolios objectForKey:aKey];
        
    } else {
        
        NSArray* keys = [_listofProjectGroups allKeys];
        id aKey = [keys objectAtIndex:section];
        projects = [_listofProjectGroups objectForKey:aKey];
        
    }
    
    return [projects count];


}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    id aKey = nil;

    if (_segmentedControl.selectedSegmentIndex == 0) {
    
        NSArray *keys = [_listofPortfolios allKeys];
        aKey = [keys objectAtIndex:section];
        
    } else {
        
        NSArray *keys = [_listofProjectGroups allKeys];
        aKey = [keys objectAtIndex:section];

    }
    
    return aKey;

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
    
    NSArray* projects = nil;
    
    if (_segmentedControl.selectedSegmentIndex == 0) {    
    
        NSArray* keys = [_listofPortfolios allKeys];
        id aKey = [keys objectAtIndex:indexPath.section];
        projects = [_listofPortfolios objectForKey:aKey];
        
    } else {
        
        NSArray* keys = [_listofProjectGroups allKeys];
        id aKey = [keys objectAtIndex:indexPath.section];
        projects = [_listofProjectGroups objectForKey:aKey];
        
    }

    Project* project = (Project*) [projects objectAtIndex:indexPath.row];

    cell.textLabel.text = project.name;
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    cell.detailTextLabel.text = project.folio;
    
    return cell;    
    
}


- (IBAction)updateTableView:(id)sender {
    
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
    [projectMapping mapKeyPath:@"id" toAttribute:@"projectID"];
    [projectMapping mapRelationship:@"portfolio" withMapping:portfolioMapping];     
    [projectMapping mapRelationship:@"project_type" withMapping:projectTypeMapping];
    [projectMapping mapRelationship:@"project_size" withMapping:projectSizeMapping];
    [projectMapping mapKeyPath:@"folio" toAttribute:@"folio"];
    [projectMapping mapKeyPath:@"name" toAttribute:@"name"];
    [projectMapping mapKeyPath:@"description" toAttribute:@"description"];
    [projectMapping mapKeyPath:@"is_focus" toAttribute:@"is_focus"];
    [projectMapping mapKeyPath:@"is_kpt" toAttribute:@"is_kpt"];
    [projectMapping mapKeyPath:@"url" toAttribute:@"url"];
    
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
    
    NSArray* projects = nil;
    
    if (_segmentedControl.selectedSegmentIndex == 0) {
    
        NSArray* keys = [_listofPortfolios allKeys];
        id aKey = [keys objectAtIndex:indexPath.section];
        projects = [_listofPortfolios objectForKey:aKey];
        
    } else {
        
        NSArray* keys = [_listofProjectGroups allKeys];
        id aKey = [keys objectAtIndex:indexPath.section];
        projects = [_listofProjectGroups objectForKey:aKey];
        
    }
    
    _selectedProject = [projects objectAtIndex:indexPath.row];
    
    /*
     When a row is selected, set the detail view controller's detail item to the item associated with the selected row.
     */
	self.detailViewController=(DetailViewController *)[[self.appDelegate.splitViewController.viewControllers objectAtIndex:1] visibleViewController];
    
    if (_segmentedControl.selectedSegmentIndex == 0) {    
        
        self.detailViewController.itemUrl = [NSString stringWithFormat:@"%@", _selectedProject.url];
        
    } else {
        
        self.detailViewController.itemID = [NSString stringWithFormat:@"%@", _selectedProject.projectID];
        
    }
    
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

