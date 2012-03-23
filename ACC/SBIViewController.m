//
//  SBIViewController.m
//  ACC
//
//  Created by Juan Galicia Castillo on 3/22/12.
//  Copyright (c) 2012 Scotiabank. All rights reserved.
//

#import "SBIViewController.h"
#import "SBIAppDelegate.h"
#import "RootViewController.h"
#import "DetailViewController.h"

@implementation SBIViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

-(IBAction)onClick1:(id)sender {
    
    NSLog(@"user clicked %@", sender);
    
    SBIAppDelegate *appDelegate = (SBIAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    // Override point for customization after app launch.
    appDelegate.splitViewController =[[UISplitViewController alloc]init];
    appDelegate.rootViewController = [[RootViewController alloc]init];
    appDelegate.detailViewController = [[DetailViewController alloc]init];
	
	UINavigationController *rootNav=[[UINavigationController alloc]initWithRootViewController:appDelegate.rootViewController];
    UINavigationController *detailNav=[[UINavigationController alloc]initWithRootViewController:appDelegate.detailViewController];
	
    
	appDelegate.splitViewController.viewControllers=[NSArray arrayWithObjects:rootNav,detailNav,nil];
	appDelegate.splitViewController.delegate=appDelegate.detailViewController;
    
    // Add the split view controller's view to the window and display.
    //[appDelegate.window addSubview: appDelegate.splitViewController.view];
    //[appDelegate.window makeKeyAndVisible];
    appDelegate.window.rootViewController = appDelegate.splitViewController;

}

@end
