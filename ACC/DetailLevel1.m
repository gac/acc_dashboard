//
//  DetailLevel1.m
//  SplitView
//
//  Created by Kshitiz Ghimire on 1/24/11.
//  Copyright 2011 Javra Software. All rights reserved.
//

#import "DetailLevel1.h"
#import "SBIAppDelegate.h"
#import "RootLevel2.h"
#import "DetailLevel2.h"

@implementation DetailLevel1

@synthesize appDelegate;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    
    [super viewDidLoad];
	self.appDelegate = (SBIAppDelegate *)[[UIApplication sharedApplication] delegate];
	self.title = @"Process";
    
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    //[super dealloc];
	//[popoverController release];
}

#pragma mark -
#pragma mark Split view support

- (void)splitViewController: (UISplitViewController*)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem*)barButtonItem forPopoverController: (UIPopoverController*)pc {
    
    barButtonItem.title = @"Root List";
    [[self navigationItem] setLeftBarButtonItem:barButtonItem];

	self.appDelegate.rootPopoverButtonItem = barButtonItem;
}


// Called when the view is shown again in the split view, invalidating the button and popover controller.
- (void)splitViewController: (UISplitViewController*)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem {
	[[self navigationItem] setLeftBarButtonItem:nil];

	self.appDelegate.rootPopoverButtonItem = barButtonItem;
}

- (IBAction)pushViewController:(id)sender{

	RootLevel2 *rootLevel2 =[[RootLevel2 alloc]init];
	DetailLevel2 <UISplitViewControllerDelegate>*detailLevel2=[[DetailLevel2 alloc]init];
	
	UIBarButtonItem *backButton = [[UIBarButtonItem alloc] 
								   initWithTitle: @"Home2" 
								   style:UIBarButtonItemStylePlain 
								   target:self 
								   action:@selector(popViewController)];
    
	detailLevel2.navigationItem.rightBarButtonItem=backButton;
    
	[self.appDelegate.splitProjectsViewController viewWillDisappear:YES];
	[[self.appDelegate.splitProjectsViewController.viewControllers objectAtIndex:0] pushViewController:rootLevel2 animated:YES];
	[[self.appDelegate.splitProjectsViewController.viewControllers objectAtIndex:1] pushViewController:detailLevel2 animated:YES];
	self.appDelegate.splitProjectsViewController.delegate = detailLevel2;
	[self.appDelegate.splitProjectsViewController viewWillAppear:YES];
	
}

-(void)popViewController {
	[self.splitViewController viewWillDisappear:YES];
	[[self.appDelegate.splitProjectsViewController.viewControllers objectAtIndex:0]popViewControllerAnimated:YES];	
	[[self.appDelegate.splitProjectsViewController.viewControllers objectAtIndex:1]popViewControllerAnimated:YES];	
	UIViewController <UISplitViewControllerDelegate>*viewController=[[self.appDelegate.splitProjectsViewController.viewControllers objectAtIndex:1] visibleViewController];
	self.splitViewController.delegate=viewController;	
	[self.splitViewController viewWillAppear:YES];
	
}



@end
