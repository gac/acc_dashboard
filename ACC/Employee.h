//
//  Employee.h
//  ACC Center
//
//  Created by Juan M Galicia on 5/22/12.
//  Copyright (c) 2012 Scotiabank. All rights reserved.
//

#import "User.h"
#import "SubArea.h"

@interface Employee : NSObject

@property (strong, nonatomic) User* user;
@property (strong, nonatomic) SubArea* subarea;

@end
