//
//  SBIViewController.h
//  acc
//
//  Created by Juan Galicia Castillo on 2/23/12.
//  Copyright (c) 2012 Scotiabank. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SBIAppDelegate;

@interface SBILoginViewController : UIViewController<UITextFieldDelegate> {

    IBOutlet UIImageView *logoImageView;
    IBOutlet UILabel *usernameLabel;
    IBOutlet UITextField *usernameField;
    IBOutlet UILabel *passwordLabel;
    IBOutlet UITextField *passwordField;
    IBOutlet UILabel *activityIndicatorLabel;
    IBOutlet UIActivityIndicatorView *activityIndicatorView;
    IBOutlet UILabel *copyrightLabel;

}

@property (nonatomic, retain) UIImageView *logoImageView;
@property (nonatomic, retain) UILabel *usernameLabel;
@property (nonatomic, retain) UITextField *usernameField;
@property (nonatomic, retain) UILabel *passwordLabel;
@property (nonatomic, retain) UITextField *passwordField;
@property (nonatomic, retain) UILabel *activityIndicatorLabel;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic, retain) UILabel *copyrightLabel;

@end