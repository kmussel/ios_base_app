//
//  CTVideoViewController.h
//  ios
//
//  Created by Kevin Musselman on 9/22/15.
//  Copyright © 2015 The Training, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YTPlayerView.h"

@interface CTVideoViewController : UIViewController<YTPlayerViewDelegate>

@property(nonatomic, strong)  YTPlayerView *playerView;

-(void)setVideoId:(NSString *)videoid;
@end
