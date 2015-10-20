//
//  UIViewController+ext.h
//  ios
//
//  Created by Kevin Musselman on 9/21/15.
//  Copyright © 2015 The Training, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CTAppController.h"

@interface UIViewController (ext)

@property (readonly, nonatomic) CTAppController *appController;

@end
