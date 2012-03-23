//
//  SBIAppDelegate.m
//  ACC
//
//  Created by Juan Galicia Castillo on 3/22/12.
//  Copyright (c) 2012 Scotiabank. All rights reserved.
//

#import "SBIAppDelegate.h"

#import "SBIViewController.h"

#import "RootViewController.h"
#import "DetailViewController.h"


@implementation SBIAppDelegate

@synthesize window = _window;

@synthesize viewController = _viewController;

@synthesize splitViewController = _splitViewController;
@synthesize rootViewController = _rootViewController;
@synthesize detailViewController = _detailViewController;
@synthesize rootPopoverButtonItem = _rootPopoverButtonItem;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    // Override point for customization after app launch.
    /*
	self.splitViewController =[[UISplitViewController alloc]init];
	self.rootViewController=[[RootViewController alloc]init];
	self.detailViewController=[[DetailViewController alloc]init];
	
	UINavigationController *rootNav=[[UINavigationController alloc]initWithRootViewController:_rootViewController];
    UINavigationController *detailNav=[[UINavigationController alloc]initWithRootViewController:_detailViewController];
	
    
	self.splitViewController.viewControllers=[NSArray arrayWithObjects:rootNav,detailNav,nil];
	self.splitViewController.delegate=_detailViewController;
	*/
    
    // Add the split view controller's view to the window and display.
    //[_window addSubview:self.splitViewController.view];
    //[_window makeKeyAndVisible];
    //[_window removeFromSuperview]; // self.view removeFromSuperview];

    

    self.viewController = [[SBIViewController alloc] initWithNibName:@"SBIViewController" bundle:nil];
    self.window.rootViewController = self.viewController;
    
    //[self.window addSubview:self.viewController.view];
    [self.window makeKeyAndVisible];
    return YES;

    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
