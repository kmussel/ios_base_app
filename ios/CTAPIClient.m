//
//  CTAPIClient.m
//  ios
//
//  Created by Kevin Musselman on 9/21/15.
//  Copyright © 2015 The Training, Inc. All rights reserved.
//

#import "CTAPIClient.h"

static NSString * const CTAPIBaseURLString = @"https://api.myapp.dev";

@implementation CTAPIClient

+ (instancetype)sharedClient {
    static CTAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[CTAPIClient alloc] initWithBaseURL:[NSURL URLWithString:CTAPIBaseURLString]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        _sharedClient.securityPolicy.allowInvalidCertificates = YES;
        [_sharedClient setAuthorizationHeader];
        
    });
    
    return _sharedClient;
}

-(void)setAuthorizationHeader {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"access_token"]) {
        [self.requestSerializer setValue:[defaults objectForKey:@"access_token"] forHTTPHeaderField:@"Authorization"];
    }
}


@end
