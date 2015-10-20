//
//  CTAudioModel.m
//  ios
//
//  Created by Kevin Musselman on 9/21/15.
//  Copyright © 2015 The Training, Inc. All rights reserved.
//

#import "CTAudioModel.h"

#import "CTAPIClient.h"

@implementation CTAudioModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"identifier"  : @"id",
             @"name"        : @"title",
             @"url"        : @"guid",             
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

+ (NSValueTransformer *)identifierJSONTransformer {
    return [MTLValueTransformer transformerUsingForwardBlock:^NSString *(NSNumber *ident, BOOL *success, NSError *__autoreleasing *error) {
        return ident.stringValue;
    }];
//    return [NSValueTransformer valueTransformerForName:];
}

+ (NSValueTransformer *)isCoolJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLBooleanValueTransformerName];
}

+ (NSURLSessionDataTask *)getAudioFiles:(void (^)(NSArray *audios, NSError *error))block {
    return [[CTAPIClient sharedClient] GET:@"api/audios" parameters:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSLog(@"the data = %@", JSON);
//        NSArray *audiosFromResponse = [JSON valueForKeyPath:@"data"];
        NSMutableArray *mutablePosts = [NSMutableArray arrayWithCapacity:[JSON count]];
        for (NSDictionary *attributes in JSON) {
            NSError *error = nil;
            NSLog(@"THE ATTRIButEs are = %@", attributes);
            CTAudioModel *audio = [MTLJSONAdapter modelOfClass:CTAudioModel.class fromJSONDictionary:attributes error:&error];
            NSLog(@"THE AUDIO model = %@", audio);
            NSLog(@"THE audio model error = %@", error);
            [mutablePosts addObject:audio];
        }
        
        if (block) {
            block([NSArray arrayWithArray:mutablePosts], nil);
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        NSLog(@"THE ERROR = %@", error);
        if (block) {
            block([NSArray array], error);
        }
    }];
}


@end
