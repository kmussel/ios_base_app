//
//  CTUser.m
//  ios
//
//  Created by Kevin Musselman on 9/21/15.
//  Copyright © 2015 The Training, Inc. All rights reserved.
//

#import "CTUser.h"
#import "CTAPIClient.h"

@implementation CTUser

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"identifier"  : @"id",
             @"name"        : @"name",
             @"loggedOn"      : @"loggedOn",
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


+ (NSValueTransformer *)loggedOnJSONTransformer {
    return [NSValueTransformer valueTransformerForName:MTLBooleanValueTransformerName];
}


+ (void)login:(NSDictionary *)params withCB:(void (^)(CTUser *user, NSError *error))block {
    
//    NSDictionary * all_params = @{@"grant_type": @"password"};
    NSMutableDictionary * all_params = [NSMutableDictionary dictionaryWithObject:@"password" forKey:@"grant_type"];
    if (params) {
        [all_params addEntriesFromDictionary:params];
    }


    [[CTAPIClient sharedClient] POST:@"oauth/token" parameters:all_params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {

        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        [defaults setObject:[NSString stringWithFormat:@"Bearer %@", [responseObject objectForKey:@"access_token"]] forKey:@"access_token"];
        [defaults synchronize];
        
        [[[CTAPIClient sharedClient] requestSerializer] setValue:[NSString stringWithFormat:@"Bearer %@", [responseObject objectForKey:@"access_token"]] forHTTPHeaderField:@"Authorization"];
        
        NSError *error = nil;
        CTUser *user = [MTLJSONAdapter modelOfClass:CTUser.class fromJSONDictionary:responseObject error:&error];
        if (block) {
            block(user, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        if (block) {
            block(nil, error);
        }
    } ];

}

+ (void)getCurrentUser:(void (^)(CTUser *, NSError *))block {
    
    
    [[CTAPIClient sharedClient] GET:@"api/me" parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSError *error = nil;
        CTUser *user = [MTLJSONAdapter modelOfClass:CTUser.class fromJSONDictionary:responseObject error:&error];
        if (block) {
            block(user, nil);
        }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        if (block) {
            block(nil, error);
        }
    } ];
    
}

@end
