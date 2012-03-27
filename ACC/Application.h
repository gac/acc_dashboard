//
//  Application.h
//  ACC
//
//  Created by Juan Galicia Castillo on 3/26/12.
//  Copyright (c) 2012 Scotiabank. All rights reserved.
//

#import "SBICatalog.h"
#import "ApplicationType.h"

@interface Application : NSObject

@property (strong, nonatomic) NSNumber* applicationID;
@property (strong, nonatomic) ApplicationType* applicationType;

@end
