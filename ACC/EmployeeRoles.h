//
//  EmployeeRoles.h
//  ACC Center
//
//  Created by Juan M Galicia on 5/22/12.
//  Copyright (c) 2012 Scotiabank. All rights reserved.
//

#import "Employee.h"
#import "Role.h"

@interface EmployeeRoles : NSObject

@property (strong, nonatomic) Employee* employee;
@property (strong, nonatomic) Role* role;

@end
