//
//  CTFormModel.m
//  ios
//
//  Created by Kevin Musselman on 9/23/15.
//  Copyright © 2015 The Training, Inc. All rights reserved.
//

#import "CTFormModel.h"
#import "CTAPIClient.h"


@implementation CTFormModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"identifier"  : @"id",
             @"name"        : @"name",
             @"url"        : @"url",             
             @"createdOn"   : @"created_on",
             @"startDate"   : @"startDate",
             };
}

+ (NSValueTransformer *)createdOnJSONTransformer {
    NSDateFormatter *dateFormatter  = [[NSDateFormatter alloc] init];
    dateFormatter.locale            = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    dateFormatter.dateFormat        = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
    
    return [MTLValueTransformer transformerUsingForwardBlock:^NSDate *(NSString *dateString, BOOL *success, NSError *__autoreleasing *error) {
        return [dateFormatter dateFromString:dateString];
    }];
}

+ (NSValueTransformer *)startDateJSONTransformer {
    NSDateFormatter *dateFormatter  = [[NSDateFormatter alloc] init];
    dateFormatter.locale            = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    dateFormatter.dateFormat        = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
    
    return [MTLValueTransformer transformerUsingForwardBlock:^NSDate *(NSString *dateString, BOOL *success, NSError *__autoreleasing *error) {
        return [dateFormatter dateFromString:dateString];
    }];
}

+ (NSURLSessionDataTask *)getForms:(void (^)(NSArray *forms, NSError *error))block {
    return [[CTAPIClient sharedClient] GET:@"forms" parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        //        NSArray *audiosFromResponse = [JSON valueForKeyPath:@"data"];
        NSMutableArray *mutableForms = [NSMutableArray arrayWithCapacity:[JSON count]];
        for (NSDictionary *attributes in JSON) {
            NSError *error = nil;
            CTFormModel *form = [MTLJSONAdapter modelOfClass:CTFormModel.class fromJSONDictionary:attributes error:&error];
            [mutableForms addObject:form];
        }
        
        if (block) {
            block([NSArray arrayWithArray:mutableForms], nil);
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        NSLog(@"THE ERROR = %@", error);
        if (block) {
            block([NSArray array], error);
        }
    }];
}



@end
