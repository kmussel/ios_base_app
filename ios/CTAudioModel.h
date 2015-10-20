//
//  CTAudioModel.h
//  ios
//
//  Created by Kevin Musselman on 9/21/15.
//  Copyright © 2015 The Training, Inc. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "MTLModel.h"

@interface CTAudioModel : MTLModel<MTLJSONSerializing>
@property (copy, nonatomic) NSString    *identifier;
@property (copy, nonatomic) NSString    *name;
@property (copy, nonatomic) NSString    *url;
@property (readwrite, nonatomic) BOOL   isCool;
@property (copy, nonatomic) NSDate      *createdOn;


+ (NSURLSessionDataTask *)getAudioFiles:(void (^)(NSArray *audios, NSError *error))block;

@end
