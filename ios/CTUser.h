//
//  CTUser.h
//  ios
//
//  Created by Kevin Musselman on 9/21/15.
//  Copyright © 2015 The Training, Inc. All rights reserved.
//

#import "MTLModel.h"
#import <Mantle/Mantle.h>


@interface CTUser : MTLModel<MTLJSONSerializing>
@property (copy, nonatomic) NSString    *identifier;
@property (copy, nonatomic) NSString    *name;
@property (readwrite, nonatomic) BOOL   loggedOn;
@property (copy, nonatomic) NSDate      *createdOn;

+ (void)login:(NSDictionary *)params withCB:(void (^)(CTUser *user, NSError *error))block;

+ (void)getCurrentUser:(void (^)(CTUser *user, NSError *error))block;

@end
