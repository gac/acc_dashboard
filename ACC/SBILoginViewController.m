//
//  SBIViewController.m
//  acc
//
//  Created by Juan Galicia Castillo on 2/23/12.
//  Copyright (c) 2012 Scotiabank. All rights reserved.
//

#import "SBILoginViewController.h"

#import "SBIAppDelegate.h"
#import "RootViewController.h"
#import "DetailViewController.h"

#include <unistd.h>

@implementation SBILoginViewController

@synthesize logoImageView = _logoImageView;
@synthesize usernameLabel = _usernameLabel;
@synthesize usernameField = _usernameField;
@synthesize passwordLabel = _passwordLabel;
@synthesize passwordField = _passwordField;
@synthesize activityIndicatorLabel = _activityIndicatorLabel;
@synthesize activityIndicatorView = _activityIndicatorView;
@synthesize copyrightLabel = _copyrightLabel;

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
    self.usernameField = nil;
    self.passwordField = nil;
    self.activityIndicatorLabel = nil;
    self.activityIndicatorView = nil;
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

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
        toInterfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        
        _logoImageView.frame = CGRectMake(309, 116, 100, 120);
        _usernameLabel.frame = CGRectMake(417, 141, 115, 21);
        _usernameField.frame = CGRectMake(540, 136, 175, 31);
        _passwordLabel.frame = CGRectMake(417, 185, 115, 21);
        _passwordField.frame = CGRectMake(540, 180, 175, 31);
        _activityIndicatorView.frame = CGRectMake(437, 355, 37, 37);
        _activityIndicatorLabel.frame = CGRectMake(482, 363, 105, 21);
        _copyrightLabel.frame = CGRectMake(112, 707, 800, 21);
        
    } else {
        
        _logoImageView.frame = CGRectMake(181, 191, 100, 120);
        _usernameLabel.frame = CGRectMake(289, 216, 115, 21);
        _usernameField.frame = CGRectMake(412, 211, 175, 31);
        _passwordLabel.frame = CGRectMake(289, 260, 115, 21);
        _passwordField.frame = CGRectMake(412, 255, 175, 31);
        _activityIndicatorView.frame = CGRectMake(309, 483, 37, 37);
        _activityIndicatorLabel.frame = CGRectMake(354, 491, 105, 21);
        _copyrightLabel.frame = CGRectMake(-16, 963, 800, 21);
        
    }
}

#pragma mark - login

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    
    if (textField == _usernameField) {
        
        if (_usernameField.text.length == 0) {
            [_usernameField becomeFirstResponder];
        } else {
            [_passwordField becomeFirstResponder];
        }
        
    } else if (textField == _passwordField) {
        
        if (_passwordField.text.length == 0) {
            [_passwordField becomeFirstResponder];
        } else {
            [_usernameField becomeFirstResponder];
        }
        
    }
    
    if (_usernameField.text.length > 0 && _passwordField.text.length > 0) {
        
        [_usernameField setEnabled:NO];
        [_passwordField setEnabled:NO];
        
        [_activityIndicatorView setHidden:NO];
        [_activityIndicatorLabel setHidden:NO];
        
        [_activityIndicatorView startAnimating];        
        [textField resignFirstResponder];
        
        SBIAppDelegate *appDelegate = (SBIAppDelegate *)[[UIApplication sharedApplication] delegate];
        
        // Override point for customization after app launch.
        appDelegate.splitViewController =[[UISplitViewController alloc]init];
        appDelegate.rootViewController = [[RootViewController alloc]init];
        appDelegate.detailViewController = [[DetailViewController alloc]init];
        
        UINavigationController *rootNav=[[UINavigationController alloc]initWithRootViewController:appDelegate.rootViewController];
        UINavigationController *detailNav=[[UINavigationController alloc]initWithRootViewController:appDelegate.detailViewController];
        
        appDelegate.splitViewController.viewControllers=[NSArray arrayWithObjects:rootNav,detailNav,nil];
        appDelegate.splitViewController.delegate=appDelegate.detailViewController;
        
        appDelegate.window.rootViewController = appDelegate.splitViewController;
        
    }
    
    return YES;
}

@end