//
//  SBIViewController.h
//  acc
//
//  Created by Juan Galicia Castillo on 2/23/12.
//  Copyright (c) 2012 Scotiabank. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SBIViewController : UIViewController<UITextFieldDelegate> {

IBOutlet UITextField *usernameField;
IBOutlet UITextField *passwordField;
    IBOutlet UILabel *activityIndicatorLabel;
    IBOutlet UIActivityIndicatorView *activityIndicatorView;
    
}

@property (nonatomic, retain) UITextField *usernameField;
@property (nonatomic, retain) UITextField *passwordField;
@property (nonatomic, retain) UILabel *activityIndicatorLabel;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicatorView;

@end


