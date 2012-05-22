//
//  Project.h
//  ACC
//
//  Created by Juan Galicia Castillo on 4/4/12.
//  Copyright (c) 2012 Scotiabank. All rights reserved.
//

#import "SBICatalog.h"
#import "Portfolio.h"
#import "ProjectType.h"
#import "ProjectSize.h"
#import "EmployeeRoles.h"

#import <Foundation/Foundation.h>

@interface Project : NSObject

@property (strong, nonatomic) NSNumber* projectID;
@property (strong, nonatomic) Portfolio* portfolio;
@property (strong, nonatomic) ProjectType* project_type;
@property (strong, nonatomic) ProjectSize* project_size;
@property (strong, nonatomic) NSString* folio;
@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* description;
@property (strong, nonatomic) NSNumber* is_focus;
@property (strong, nonatomic) NSNumber* is_kpt;

@property (strong, nonatomic) EmployeeRoles* relationship_manager;
@property (strong, nonatomic) EmployeeRoles* delivery_manager;
@property (strong, nonatomic) EmployeeRoles* portfolio_manager;
@property (strong, nonatomic) EmployeeRoles* sponsor;

@property (strong, nonatomic) Employee* dps_resp;
@property (strong, nonatomic) Employee* is_resp;

@property (strong, nonatomic) Employee* qc_resp;
@property (strong, nonatomic) Employee* qa_resp;
@property (strong, nonatomic) Employee* nft_resp;
@property (strong, nonatomic) Employee* env_resp;

@property (strong, nonatomic) NSString* url;

@end
