//
//  SBILoginViewController.h
//  acc
//
//  Created by Juan Galicia Castillo on 2/23/12.
//  Copyright (c) 2012 Scotiabank. All rights reserved.
//

#import <RestKit/RestKit.h>

@class SBIAppDelegate;

@interface SBILoginViewController : UIViewController<UITextFieldDelegate, RKRequestDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *logoImageView;
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) IBOutlet UITextField *usernameField;
@property (strong, nonatomic) IBOutlet UILabel *passwordLabel;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic) IBOutlet UILabel *activityIndicatorLabel;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;
@property (strong, nonatomic) IBOutlet UILabel *copyrightLabel;

@end