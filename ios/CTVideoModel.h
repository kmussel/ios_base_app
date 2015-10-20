//
//  CTVideoModel.h
//  ios
//
//  Created by Kevin Musselman on 9/22/15.
//  Copyright © 2015 The Training, Inc. All rights reserved.
//

#import "MTLModel.h"
#import <Mantle/Mantle.h>

#import "AFHTTPRequestOperationManager.h"

@interface CTVideoModel : MTLModel<MTLJSONSerializing>
@property (copy, nonatomic) NSString    *identifier;
@property (copy, nonatomic) NSString    *videoId;
@property (copy, nonatomic) NSString    *name;
@property (copy, nonatomic) NSString    *url;
@property (readwrite, nonatomic) BOOL   isCool;
@property (copy, nonatomic) NSDate      *createdOn;


+ (AFHTTPRequestOperation *)getVideoFiles:(void (^)(NSArray *videos, NSError *error))block;

@end
