//
//  CTFormModel.h
//  ios
//
//  Created by Kevin Musselman on 9/23/15.
//  Copyright © 2015 The Training, Inc. All rights reserved.
//

#import "MTLModel.h"
#import <Mantle/Mantle.h>

@interface CTFormModel : MTLModel<MTLJSONSerializing>
@property (copy, nonatomic) NSString    *identifier;
@property (copy, nonatomic) NSString    *name;
@property (copy, nonatomic) NSString    *url;
@property (copy, nonatomic) NSDate      *startDate;
@property (copy, nonatomic) NSDate      *createdOn;

+ (NSURLSessionDataTask *)getForms:(void (^)(NSArray *forms, NSError *error))block;

@end
