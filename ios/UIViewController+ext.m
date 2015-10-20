//
//  UIViewController+ext.m
//  ios
//
//  Created by Kevin Musselman on 9/21/15.
//  Copyright © 2015 The Training, Inc. All rights reserved.
//

#import "UIViewController+ext.h"
#import "AppDelegate.h"

@implementation UIViewController (ext)

- (CTAppController *)appController {
    return ((AppDelegate *)[[UIApplication sharedApplication] delegate]).appController;
}

@end
