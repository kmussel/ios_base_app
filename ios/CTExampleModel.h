//
//  CTExampleModel.h
//  ios
//
//  Created by Kevin Musselman on 9/18/15.
//  Copyright © 2015 The Training, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

@interface CTExampleModel : MTLModel<MTLJSONSerializing>
@property (copy, nonatomic) NSString    *identifier;
@property (copy, nonatomic) NSString    *name;
@property (readwrite, nonatomic) BOOL   isCool;
@property (copy, nonatomic) NSDate      *createdOn;
@end
