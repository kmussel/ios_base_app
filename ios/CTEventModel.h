//
//  CTEvent.h
//  ios
//
//  Created by Kevin Musselman on 9/23/15.
//  Copyright © 2015 The Training, Inc. All rights reserved.
//

#import "MTLModel.h"
#import <Mantle/Mantle.h>

@interface CTEventModel : MTLModel<MTLJSONSerializing>
@property (copy, nonatomic) NSString    *identifier;
@property (copy, nonatomic) NSString    *name;
@property (copy, nonatomic) NSDate      *startDate;
@property (copy, nonatomic) NSDate      *createdOn;

+ (NSURLSessionDataTask *)getEvents:(void (^)(NSArray *events, NSError *error))block;

@end
