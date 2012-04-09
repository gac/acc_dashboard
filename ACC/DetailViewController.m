//
//  DetailViewController.m
//  NavigatorSplitView
//
//  Created by Kshitiz Ghimire on 1/26/11.
//  Copyright 2011 Kshitiz Ghimire. All rights reserved.
//

#import "DetailViewController.h"
#import "RootViewController.h"
#import "RootLevel1.h"
#import "DetailLevel1.h"

@interface DetailViewController ()
@property (strong, nonatomic) UIPopoverController *popoverController;
- (void)configureView;
@end



@implementation DetailViewController

@synthesize  popoverController;
@synthesize folio;
@synthesize name;
@synthesize folioLabel;
@synthesize nameLabel;

@synthesize appDelegate;
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
- (void)setFolio:(id)newFolio {
    if (folio != newFolio) {

        folio = newFolio;
        
        // Update the view.
        [self configureView];
    }
    
    if (popoverController != nil) {
        [popoverController dismissPopoverAnimated:YES];
    }        
}


- (void)configureView {
    
    // Update the user interface for the detail item.
    folioLabel.text = [folio description];
    nameLabel.text = [name description];
    
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
	//self.title=@"Detail VC";
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	
    
}

/*
 - (void)viewDidAppear:(BOOL)animated {
 [super viewDidAppear:animated];
 }
 */
/*
 - (void)viewWillDisappear:(BOOL)animated {
 [super viewWillDisappear:animated];
 }
 */
/*
 - (void)viewDidDisappear:(BOOL)animated {
 [super viewDidDisappear:animated];
 }
 */

- (void)viewDidUnload {
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.popoverController = nil;
}


#pragma mark -
#pragma mark Memory management

/*
 - (void)didReceiveMemoryWarning {
 // Releases the view if it doesn't have a superview.
 [super didReceiveMemoryWarning];
 
 // Release any cached data, images, etc that aren't in use.
 }
 */

- (void)dealloc {
    //[popoverController release];
    
    
    //[detailItem release];
    //[detailDescriptionLabel release];
    //[super dealloc];
}
- (IBAction)pushViewController:(id)sender{
	
	RootLevel1 *rootLevel1 =[[RootLevel1 alloc]init];
	DetailLevel1 <UISplitViewControllerDelegate>*detailLevel1=[[DetailLevel1 alloc]init];
	
	UIBarButtonItem *backButton = [[UIBarButtonItem alloc] 
								   initWithTitle: @"Home" 
								   style:UIBarButtonItemStylePlain 
								   target:self 
								   action:@selector(popViewController)];
	rootLevel1.navigationItem.leftBarButtonItem=backButton;
	[self.appDelegate.splitViewController viewWillDisappear:YES];
	[[self.appDelegate.splitViewController.viewControllers objectAtIndex:0] pushViewController:rootLevel1 animated:YES];
	[[self.appDelegate.splitViewController.viewControllers objectAtIndex:1] pushViewController:detailLevel1 animated:YES];
	self.appDelegate.splitViewController.delegate = detailLevel1;
	[self.appDelegate.splitViewController viewWillAppear:YES];
	//[rootLevel1 release];
	//[detailLevel1 release];
	
}

-(void)popViewController {
	[self.splitViewController viewWillDisappear:YES];
	[[self.appDelegate.splitViewController.viewControllers objectAtIndex:0]popViewControllerAnimated:YES];	
	[[self.appDelegate.splitViewController.viewControllers objectAtIndex:1]popViewControllerAnimated:YES];	
	UIViewController <UISplitViewControllerDelegate>*viewController=[[self.appDelegate.splitViewController.viewControllers objectAtIndex:1] visibleViewController];
	self.splitViewController.delegate=viewController;	
	[self.splitViewController viewWillAppear:YES];
	
}

@end
