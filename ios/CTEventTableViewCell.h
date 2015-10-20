//
//  CTEventTableViewCell.h
//  ios
//
//  Created by Kevin Musselman on 9/23/15.
//  Copyright © 2015 The Training, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CTEventModel;
@interface CTEventTableViewCell : UITableViewCell

@property (nonatomic, strong) CTEventModel *event;

+ (CGFloat)heightForCellWithEvent:(CTEventModel *)event;

@end
