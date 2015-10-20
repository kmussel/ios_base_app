//
//  CTEvent.m
//  ios
//
//  Created by Kevin Musselman on 9/23/15.
//  Copyright © 2015 The Training, Inc. All rights reserved.
//

#import "CTEventModel.h"
#import "CTAPIClient.h"

@implementation CTEventModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"identifier"  : @"id",
             @"name"        : @"name",
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


+ (NSValueTransformer *)loggedOnJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLBooleanValueTransformerName];
}

+ (NSURLSessionDataTask *)getEvents:(void (^)(NSArray *events, NSError *error))block {
    return [[CTAPIClient sharedClient] GET:@"events" parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"the data = %@", JSON);
        //        NSArray *audiosFromResponse = [JSON valueForKeyPath:@"data"];
        NSMutableArray *mutableEvents = [NSMutableArray arrayWithCapacity:[JSON count]];
        for (NSDictionary *attributes in JSON) {
            NSError *error = nil;
            NSLog(@"THE ATTRIButEs are = %@", attributes);
            CTEventModel *event = [MTLJSONAdapter modelOfClass:CTEventModel.class fromJSONDictionary:attributes error:&error];
            NSLog(@"THE FORM model = %@", event);
            NSLog(@"THE form model error = %@", error);
            [mutableEvents addObject:event];
        }
        
        if (block) {
            block([NSArray arrayWithArray:mutableEvents], nil);
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        NSLog(@"THE ERROR = %@", error);
        if (block) {
            block([NSArray array], error);
        }
    }];
}


+ (NSURLSessionDataTask *)getEvents:(NSDictionary *)params withCallback:(void (^)(NSArray *events, NSError *error))block {
    return [[CTAPIClient sharedClient] GET:@"events" parameters:params success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"the data = %@", JSON);
        //        NSArray *audiosFromResponse = [JSON valueForKeyPath:@"data"];
        NSMutableArray *mutableEvents = [NSMutableArray arrayWithCapacity:[JSON count]];
        for (NSDictionary *attributes in JSON) {
            NSError *error = nil;
            NSLog(@"THE ATTRIButEs are = %@", attributes);
            CTEventModel *event = [MTLJSONAdapter modelOfClass:CTEventModel.class fromJSONDictionary:attributes error:&error];
            NSLog(@"THE FORM model = %@", event);
            NSLog(@"THE form model error = %@", error);
            [mutableEvents addObject:event];
        }
        
        if (block) {
            block([NSArray arrayWithArray:mutableEvents], nil);
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        NSLog(@"THE ERROR = %@", error);
        if (block) {
            block([NSArray array], error);
        }
    }];
}


@end
