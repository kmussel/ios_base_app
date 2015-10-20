//
//  CTAPIClient.h
//  ios
//
//  Created by Kevin Musselman on 9/21/15.
//  Copyright © 2015 The Training, Inc. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface CTAPIClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

-(void)setAuthorizationHeader;
@end
