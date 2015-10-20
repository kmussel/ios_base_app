//
//  CTFormTableViewCell.h
//  ios
//
//  Created by Kevin Musselman on 9/23/15.
//  Copyright © 2015 The Training, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CTFormModel;

@interface CTFormTableViewCell : UITableViewCell

@property (nonatomic, strong) CTFormModel *form;

+ (CGFloat)heightForCellWithForm:(CTFormModel *)form;

@end
