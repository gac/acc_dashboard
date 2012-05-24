//
//  DetailViewController.m
//  NavigatorSplitView
//
//  Created by Kshitiz Ghimire on 1/26/11.
//  Copyright 2011 Kshitiz Ghimire. All rights reserved.
//

#import "DetailViewController.h"
#import "RootViewController.h"
#import "DetailLevel1.h"
#import "Project.h"

@interface DetailViewController ()

@property (strong, nonatomic) UIPopoverController *popoverController;

- (void)configureView;

@end

@implementation DetailViewController

@synthesize popoverController;
@synthesize appDelegate;
@synthesize itemID;
@synthesize scrollView = _scrollView;

#pragma mark -
#pragma mark Managing the detail item

-(id) init {
    
	if (self=[super init]) {
        
		self.appDelegate = (SBIAppDelegate *)[[UIApplication sharedApplication] delegate];
        
	}
    
	return self;
}

/*
 When setting the detail item, update the view and dismiss the popover controller if it's showing.
 */

- (void) setItemID:(id)newItemID {
    
    if (itemID != newItemID) {
        
        itemID = newItemID;
        
        // Update the view.
        [self configureView];
        
    }
    
    if (popoverController != nil) {
        [popoverController dismissPopoverAnimated:YES];
    }
    
}

- (void)configureView {
    
    // Update the user interface for the detail item.
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
    
    RKObjectMapping* userMapping = [RKObjectMapping mappingForClass:[User class]];
    [userMapping mapKeyPath:@"first_name" toAttribute:@"first_name"];
    [userMapping mapKeyPath:@"last_name" toAttribute:@"last_name"];
    
    RKObjectMapping* roleMapping = [RKObjectMapping mappingForClass:[Role class]];
    [roleMapping mapKeyPath:@"name" toAttribute:@"name"];
    
    RKObjectMapping* subareaMapping = [RKObjectMapping mappingForClass:[SubArea class]];
    [subareaMapping mapKeyPath:@"name" toAttribute:@"name"];
    
    RKObjectMapping* employeeMapping = [RKObjectMapping mappingForClass:[Employee class]];
    [employeeMapping mapRelationship:@"user" withMapping:userMapping];
    [employeeMapping mapRelationship:@"subarea" withMapping:subareaMapping];
    
    RKObjectMapping* employeeRolesMapping = [RKObjectMapping mappingForClass:[EmployeeRoles class]];
    [employeeRolesMapping mapRelationship:@"employee" withMapping:employeeMapping];
    [employeeRolesMapping mapRelationship:@"role" withMapping:roleMapping];
    
    RKObjectMapping* projectMapping = [RKObjectMapping mappingForClass:[Project class]];
    [projectMapping mapRelationship:@"portfolio" withMapping:portfolioMapping];     
    [projectMapping mapRelationship:@"project_type" withMapping:projectTypeMapping];
    [projectMapping mapRelationship:@"project_size" withMapping:projectSizeMapping];
    [projectMapping mapKeyPath:@"folio" toAttribute:@"folio"];
    [projectMapping mapKeyPath:@"name" toAttribute:@"name"];
    [projectMapping mapKeyPath:@"description" toAttribute:@"description"];
    [projectMapping mapKeyPath:@"is_focus" toAttribute:@"is_focus"];
    [projectMapping mapKeyPath:@"is_kpt" toAttribute:@"is_kpt"];
    
    [projectMapping mapRelationship:@"relationship_manager" withMapping:employeeRolesMapping];
    [projectMapping mapRelationship:@"delivery_manager" withMapping:employeeRolesMapping];
    [projectMapping mapRelationship:@"portfolio_manager" withMapping:employeeRolesMapping];
    [projectMapping mapRelationship:@"sponsor" withMapping:employeeRolesMapping];
    
    [projectMapping mapRelationship:@"dps_resp" withMapping:employeeMapping];
    [projectMapping mapRelationship:@"is_resp" withMapping:employeeMapping];
    
    [projectMapping mapRelationship:@"qc_resp" withMapping:employeeMapping];
    [projectMapping mapRelationship:@"qa_resp" withMapping:employeeMapping];
    [projectMapping mapRelationship:@"nft_resp" withMapping:employeeMapping];
    [projectMapping mapRelationship:@"env_resp" withMapping:employeeMapping];
    
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:[NSString stringWithFormat:@"projects/resources/projects/%@/", self.itemID] objectMapping:projectMapping delegate:self];

}

- (void)objectLoader:(RKObjectLoader*)objectLoader didLoadObjects:(NSArray*)objects {
    
    [_listofStakeholders removeAllObjects];
    [_listofResponsibles removeAllObjects];
    [_listofProcesses removeAllObjects];

    for (id object in objects) {
                
        Project* project = (Project*) object;
        
        for (UIView *subView in self.view.subviews) {
            if([subView isKindOfClass:[UILabel class]]) {
                [subView removeFromSuperview];
            }
        }

        //Folio
        UILabel *label1 = [[UILabel alloc] init];
        [label1 setFrame:CGRectMake(20, 5, 650, 30)];
        [label1 setText:project.folio];
        label1.font = [UIFont systemFontOfSize:27];
        [self.view addSubview:label1];
        
        //Name
        UILabel *label2 = [[UILabel alloc] init];
        [label2 setFrame:CGRectMake(20, 30, 650, 30)];
        [label2 setText:project.name];
        label2.textColor = [UIColor grayColor];
        [self.view addSubview:label2];
        
        for (UIView *subView in self.scrollView.subviews) {
            [subView removeFromSuperview];
        }
        
        //Type
        UILabel *label3 = [[UILabel alloc] init];
        [label3 setFrame:CGRectMake(100, 0, 140, 30)];
        [label3 setText:@"Type"];
        label3.textColor = [UIColor grayColor];
        label3.textAlignment = UITextAlignmentRight;
        [self.scrollView addSubview:label3];
        
        UILabel *label4 = [[UILabel alloc] init];
        [label4 setFrame:CGRectMake(250, 0, 300, 30)];
        [label4 setText:project.project_type.description];
        [self.scrollView addSubview:label4];
        
        //Size
        UILabel *label5 = [[UILabel alloc] init];
        [label5 setFrame:CGRectMake(100, 30, 140, 30)];
        [label5 setText:@"Size"];
        label5.textColor = [UIColor grayColor];
        label5.textAlignment = UITextAlignmentRight;
        [self.scrollView addSubview:label5];
        
        UILabel *label6 = [[UILabel alloc] init];
        [label6 setFrame:CGRectMake(250, 30, 300, 30)];
        [label6 setText:project.project_size.size];
        [self.scrollView addSubview:label6];

        //Focus
        UILabel *label7 = [[UILabel alloc] init];
        [label7 setFrame:CGRectMake(100, 60, 140, 30)];
        [label7 setText:@"Focus"];
        label7.textColor = [UIColor grayColor];
        label7.textAlignment = UITextAlignmentRight;
        [self.scrollView addSubview:label7];
        
        UILabel *label8 = [[UILabel alloc] init];
        [label8 setFrame:CGRectMake(250, 60, 300, 30)];
        if ([project.is_focus isEqualToNumber:[NSNumber numberWithInt:0]]) {
            [label8 setText:@"No"];            
        } else {
            [label8 setText:@"Si"];
        }
        [self.scrollView addSubview:label8];
        
        //KPT
        UILabel *label9 = [[UILabel alloc] init];
        [label9 setFrame:CGRectMake(100, 90, 140, 30)];
        [label9 setText:@"KPT"];
        label9.textColor = [UIColor grayColor];
        label9.textAlignment = UITextAlignmentRight;
        [self.scrollView addSubview:label9];
        
        UILabel *label10 = [[UILabel alloc] init];
        [label10 setFrame:CGRectMake(250, 90, 300, 30)];
        if ([project.is_kpt isEqualToNumber:[NSNumber numberWithInt:0]]) {
            [label10 setText:@"No"];            
        } else {
            [label10 setText:@"Si"];
        }
        [self.scrollView addSubview:label10];

        //Description
        UILabel *label11 = [[UILabel alloc] init];
        [label11 setFrame:CGRectMake(100, 120, 140, 30)];
        [label11 setText:@"Description"];
        label11.textColor = [UIColor grayColor];
        label11.textAlignment = UITextAlignmentRight;
        [self.scrollView addSubview:label11];
        
        UILabel *label12 = [[UILabel alloc] init];
        [label12 setFrame:CGRectMake(250, 120, 400, 100)];
        [label12 setText:project.description];
        label12.numberOfLines = 5;
        //[label12 sizeToFit];
        [self.scrollView addSubview:label12];
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(100, 220, 490, 700) style:UITableViewStyleGrouped];
        tableView.delegate = self;
        tableView.dataSource = self;
        [tableView setBackgroundView:nil];
        [self.scrollView addSubview:tableView];

        [_listofStakeholders addObject:project.relationship_manager];
        [_listofStakeholders addObject:project.delivery_manager];
        [_listofStakeholders addObject:project.portfolio_manager];
        [_listofStakeholders addObject:project.sponsor];
        
        [_listofResponsibles addObject:project.dps_resp];
        [_listofResponsibles addObject:project.is_resp];
        
        [_listofResponsibles addObject:project.qc_resp];
        [_listofResponsibles addObject:project.qa_resp];
        [_listofResponsibles addObject:project.nft_resp];
        [_listofResponsibles addObject:project.env_resp];

    }
    
    [self.scrollView setContentSize:CGSizeMake(240, 870)];

}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error {

    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:[error localizedDescription] delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
    [alert show];
    
}

#pragma mark -
#pragma mark Split view support

- (void)splitViewController: (UISplitViewController*)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem*)barButtonItem forPopoverController: (UIPopoverController*)pc {
    
	barButtonItem.title = @"Root List";
    [[self navigationItem] setLeftBarButtonItem:barButtonItem];
	[self setPopoverController:pc];
	self.appDelegate.rootPopoverButtonItem = barButtonItem;
}

// Called when the view is shown again in the split view, invalidating the button and popover controller.
- (void)splitViewController: (UISplitViewController*)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem {
	[[self navigationItem] setLeftBarButtonItem:nil];
	[self setPopoverController:nil];
	self.appDelegate.rootPopoverButtonItem = barButtonItem;
}

#pragma mark -
#pragma mark Rotation support

// Ensure that the view controller supports rotation and that the split view can therefore show in both portrait and landscape.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    //hot fix sometimes in multilevel bar button is shown in landscape mode.
	
	if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
		[[self navigationItem] setLeftBarButtonItem:nil];
	}
	else {
		[[self navigationItem] setLeftBarButtonItem:self.appDelegate.rootPopoverButtonItem];
	}	
	return YES;
}

#pragma mark -
#pragma mark View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
	self.title=@"General Information";
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(10, 60, 667, 1)];
    lineView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:lineView];
    
    _listofStakeholders = [[NSMutableArray alloc] init];
    _listofResponsibles = [[NSMutableArray alloc] init];    
    _listofProcesses = [[NSMutableArray alloc] init];

}

- (void)viewDidUnload {
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.popoverController = nil;
}

#pragma mark -
#pragma mark Memory management

- (IBAction)pushViewController:(id)sender{
	
	DetailLevel1 <UISplitViewControllerDelegate>*detailLevel1=[[DetailLevel1 alloc]init];
	    
	[self.appDelegate.splitProjectsViewController viewWillDisappear:YES];
	[[self.appDelegate.splitProjectsViewController.viewControllers objectAtIndex:1] pushViewController:detailLevel1 animated:YES];
	
    self.appDelegate.splitProjectsViewController.delegate = detailLevel1;
	[self.appDelegate.splitProjectsViewController viewWillAppear:YES];
	
}

-(void)popViewController {
    
	[self.splitViewController viewWillDisappear:YES];
	[[self.appDelegate.splitProjectsViewController.viewControllers objectAtIndex:0]popViewControllerAnimated:YES];	
	[[self.appDelegate.splitProjectsViewController.viewControllers objectAtIndex:1]popViewControllerAnimated:YES];	
	UIViewController <UISplitViewControllerDelegate>* viewController= [[self.appDelegate.splitProjectsViewController.viewControllers objectAtIndex:1] visibleViewController];
	self.splitViewController.delegate=viewController;	
	[self.splitViewController viewWillAppear:YES];
	
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView {
    
    // Return the number of sections.
    return 3;
    
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    if (section == 0) {
        return 4;
    } else if (section == 1) {
        return 6;
    } else {
        return 1;
    }
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if (section == 0 ) {
        return @"Stakeholders";        
    } else if (section == 1) {
        return @"Responsibles";
    } else {
        return @"Processes";
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CellIdentifier";
    
    // Dequeue or create a cell of the appropriate type.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    
    if (indexPath.section == 0) {
        
        EmployeeRoles* employeeRoles = (EmployeeRoles*) [_listofStakeholders objectAtIndex:indexPath.row];

        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", employeeRoles.employee.user.last_name, employeeRoles.employee.user.first_name];
        cell.textLabel.font = [UIFont systemFontOfSize:17];
        cell.detailTextLabel.text = employeeRoles.role.name;
        
    } else if (indexPath.section == 1) {
        
        Employee* employee = (Employee*) [_listofResponsibles objectAtIndex:indexPath.row];
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", employee.user.last_name, employee.user.first_name];
        cell.textLabel.font = [UIFont systemFontOfSize:17];
        cell.detailTextLabel.text = employee.subarea.name;
        
    } else {
        
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        cell.textLabel.text = @"Pruebas No Funcionales";
        cell.textLabel.font = [UIFont systemFontOfSize:17];

        UIButton *button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        button.backgroundColor = [UIColor clearColor];
        [button addTarget:self action:@selector(pushViewController:) forControlEvents:UIControlEventTouchUpInside];
        cell.accessoryView = button;

    }
    
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;    
    
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)aTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 2) {
        
        [self pushViewController:nil];
        
    }

}

@end
