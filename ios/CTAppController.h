//
//  CTAppController.h
//  ios
//
//  Created by Kevin Musselman on 9/18/15.
//  Copyright © 2015 The Training, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTAppController : NSObject
@property (readonly, nonatomic) UIWindow *window;

-(void)transitionToTabs;

@end
