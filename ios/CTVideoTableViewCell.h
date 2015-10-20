//
//  CTVideoTableViewCell.h
//  ios
//
//  Created by Kevin Musselman on 9/22/15.
//  Copyright © 2015 The Training, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTPlayerView.h"

@class CTVideoModel;

@interface CTVideoTableViewCell : UITableViewCell

@property (nonatomic, strong) CTVideoModel *video;

+ (CGFloat)heightForCellWithVideo:(CTVideoModel *)video;

@end
