//
//  CTVideoModel.m
//  ios
//
//  Created by Kevin Musselman on 9/22/15.
//  Copyright © 2015 The Training, Inc. All rights reserved.
//

#import "CTVideoModel.h"

#import "CTAPIClient.h"



@implementation CTVideoModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{@"identifier"  : @"id",
             @"videoId"     : @"contentDetails.videoId",
             @"name"        : @"snippet.title",
             @"url"         : @"snippet.thumbnails.standard.url",
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

+ (AFHTTPRequestOperation *)getVideoFiles:(void (^)(NSArray *videos, NSError *error))block {
    
        NSString * kStrJsonURL =     @"https://www.googleapis.com/youtube/v3/playlistItems?part=snippet%2CcontentDetails%2Cstatus&playlistId=PLycYO1GczXF9TlHZGaZzK1ywVWSNYPhCF&key=YOUR_KEY HERE";
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    return [manager GET:kStrJsonURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *videosFromResponse = [responseObject valueForKeyPath:@"items"];

//        NSLog(@"VIDEO COUNT = %lu", (unsigned long)videosFromResponse.count);

        NSMutableArray *mutableVideos = [NSMutableArray arrayWithCapacity:videosFromResponse.count];
        for (NSDictionary *attributes in videosFromResponse) {
            NSError *error = nil;
            CTVideoModel *video = [MTLJSONAdapter modelOfClass:CTVideoModel.class fromJSONDictionary:attributes error:&error];
            [mutableVideos addObject:video];
        }
        
        if (block) {
            block(mutableVideos, nil);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];


}


@end
