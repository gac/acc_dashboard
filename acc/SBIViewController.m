//
//  SBIViewController.m
//  acc
//
//  Created by Juan Galicia Castillo on 2/23/12.
//  Copyright (c) 2012 Scotiabank. All rights reserved.
//

#import "SBIViewController.h"
#include <unistd.h>

@implementation SBIViewController

@synthesize usernameField;
@synthesize passwordField;
@synthesize activityIndicatorLabel;
@synthesize activityIndicatorView;

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

#pragma mark - login

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    
    if (textField == usernameField) {
        
        if (usernameField.text.length == 0) {
            [usernameField becomeFirstResponder];
        } else {
            [passwordField becomeFirstResponder];
        }
    
    } else if (textField == passwordField) {
        
        if (passwordField.text.length == 0) {
            [passwordField becomeFirstResponder];
        } else {
            [usernameField becomeFirstResponder];
        }
        
    }
    
    if (usernameField.text.length > 0 && passwordField.text.length > 0) {
        
        [usernameField setEnabled:NO];
        [passwordField setEnabled:NO];
        
        [activityIndicatorView setHidden:NO];
        [activityIndicatorLabel setHidden:NO];
        
        [activityIndicatorView startAnimating];        
        [textField resignFirstResponder];
        
    }
    
    return YES;
}

@end
