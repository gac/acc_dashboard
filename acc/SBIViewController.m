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

@synthesize logoImageView;
@synthesize usernameLabel;
@synthesize usernameField;
@synthesize passwordLabel;
@synthesize passwordField;
@synthesize activityIndicatorLabel;
@synthesize activityIndicatorView;
@synthesize copyrightLabel;

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

        logoImageView.frame = CGRectMake(309, 116, 100, 120);
        usernameLabel.frame = CGRectMake(417, 141, 115, 21);
        usernameField.frame = CGRectMake(540, 136, 175, 31);
        passwordLabel.frame = CGRectMake(417, 185, 115, 21);
        passwordField.frame = CGRectMake(540, 180, 175, 31);
        activityIndicatorView.frame = CGRectMake(437, 355, 37, 37);
        activityIndicatorLabel.frame = CGRectMake(482, 363, 105, 21);
        copyrightLabel.frame = CGRectMake(112, 707, 800, 21);
        
    } else {
        
        logoImageView.frame = CGRectMake(181, 191, 100, 120);
        usernameLabel.frame = CGRectMake(289, 216, 115, 21);
        usernameField.frame = CGRectMake(412, 211, 175, 31);
        passwordLabel.frame = CGRectMake(289, 260, 115, 21);
        passwordField.frame = CGRectMake(412, 255, 175, 31);
        activityIndicatorView.frame = CGRectMake(309, 483, 37, 37);
        activityIndicatorLabel.frame = CGRectMake(354, 491, 105, 21);
        copyrightLabel.frame = CGRectMake(-16, 963, 800, 21);

    }
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
        
        [self performSegueWithIdentifier: @"segue1" sender:self];
        
    }
    
    return YES;
}

@end
