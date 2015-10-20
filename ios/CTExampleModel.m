//
//  CTExampleModel.m
//  ios
//
//  Created by Kevin Musselman on 9/18/15.
//  Copyright © 2015 The Training, Inc. All rights reserved.
//

#import "CTExampleModel.h"

@implementation CTExampleModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"identifier"  : @"id",
             @"name"        : @"user_name",
             @"isCool"      : @"is_cool",
             @"createdOn"   : @"created_on",};
}

+ (NSValueTransformer *)createdOnJSONTransformer {
    NSDateFormatter *dateFormatter  = [[NSDateFormatter alloc] init];
    dateFormatter.locale            = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    dateFormatter.dateFormat        = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
    
    return [MTLValueTransformer transformerUsingForwardBlock:^NSDate *(NSString *dateString, BOOL *success, NSError *__autoreleasing *error) {
        return [dateFormatter dateFromString:dateString];
    }];
}

+ (NSValueTransformer *)isCoolJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLBooleanValueTransformerName];
}



@end
