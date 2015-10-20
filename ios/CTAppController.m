//
//  CTAppController.m
//  ios
//
//  Created by Kevin Musselman on 9/18/15.
//  Copyright © 2015 The Training, Inc. All rights reserved.
//

#import "CTAppController.h"
#import "CTExampleViewController.h"
#import "CTAPIClient.h"
#import "CTEventsController.h"
#import "CTVideoController.h"
#import "CTCallsController.h"
#import "CTFormsController.h"
#import "CTAudioController.h"
#import "CTContactsController.h"
#import "CTLoginController.h"
#import "CTUser.h"


@interface CTAppController()
@property (strong, nonatomic) UIWindow                  *window;
@property (strong, nonatomic) UITabBarController        *tabbarController;
@property (strong, nonatomic) CTLoginController         *loginController;
@property (strong, nonatomic) CTExampleViewController   *exampleController;
@property (strong, nonatomic) CTAudioController   *audioController;
@property (strong, nonatomic) CTEventsController  *eventsController;
@property (strong, nonatomic) CTVideoController   *videosController;
@property (strong, nonatomic) CTCallsController   *callsController;
@property (strong, nonatomic) CTFormsController   *formsController;
@property (strong, nonatomic) CTContactsController   *contactsController;
@end

@implementation CTAppController

#pragma mark - Actions
- (void)presentViewController:(UIViewController *)controller animated:(BOOL)flag completion:(void (^ _Nullable)(void))completion {
    [self.window.rootViewController presentViewController:controller animated:flag completion:completion];
}

#pragma mark - Getters
- (UIWindow *)window {
    if(_window)
        return _window;
    
    _window                     = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.rootViewController  = self.loginController;

    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"access_token"]) {

        [CTUser getCurrentUser:^(CTUser *user, NSError *error) {
            if (!error) {
                [self transitionToTabs];
                
            }
            else {
                NSLog(@"THE ERROR = %@", error);
            }
        }];
    }

//    _window.rootViewController  = self.tabbarController;
    
    return _window;
}

- (void)transitionToTabs {
    _window.rootViewController  = self.tabbarController;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (CTLoginController *)loginController {
    if(_loginController)
        return _loginController;
    
    _loginController                   = [[CTLoginController alloc] init];
    
    return _loginController;
}

- (UITabBarController *)tabbarController {
    if(_tabbarController)
        return _tabbarController;
    
    _tabbarController                   = [[UITabBarController alloc] init];


    _tabbarController.viewControllers   = @[self.audioController,
                                            [[UINavigationController alloc] initWithRootViewController:self.videosController],
                                            [[UINavigationController alloc] initWithRootViewController:self.eventsController],
                                            [[UINavigationController alloc] initWithRootViewController:self.formsController], self.callsController, self.contactsController];
    
    return _tabbarController;
}

- (CTExampleViewController *)exampleController {
    if(_exampleController)
        return _exampleController;
    
    _exampleController = [[CTExampleViewController alloc] init];
    
    return _exampleController;
}

- (CTAudioController *)audioController {
    if(_audioController)
        return _audioController;
    
    _audioController = [[CTAudioController alloc] init];
    return _audioController;
}

- (CTVideoController *)videosController {
    if(_videosController)
        return _videosController;
    
   _videosController = [[CTVideoController alloc] init];
    
    return _videosController;
}

- (CTEventsController *)eventsController {
    if(_eventsController)
        return _eventsController;
    
    _eventsController = [[CTEventsController alloc] init];
    
    return _eventsController;
}


- (CTCallsController *)callsController {
    if(_callsController)
        return _callsController;
    
    _callsController = [[CTCallsController alloc] init];
    
    return _callsController;
}

- (CTFormsController *)formsController {
    if(_formsController)
        return _formsController;
    
    _formsController = [[CTFormsController alloc] init];
    
    return _formsController;
}

- (CTContactsController *)contactsController {
    if(_contactsController)
        return _contactsController;
    
    _contactsController = [[CTContactsController alloc] init];
    
    return _contactsController;
}


@end





