//
//  CTAudioTableViewCell.h
//  ios
//
//  Created by Kevin Musselman on 9/21/15.
//  Copyright © 2015 The Training, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVAudioPlayer.h>

@class CTAudioModel;

@interface CTAudioTableViewCell : UITableViewCell

@property (nonatomic, strong) CTAudioModel *audio;
@property (nonatomic, strong) AVAudioPlayer *player;

+ (CGFloat)heightForCellWithAudio:(CTAudioModel *)audio;


@end
