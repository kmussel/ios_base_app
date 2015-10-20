//
//  CTAudioTableViewCell.m
//  ios
//
//  Created by Kevin Musselman on 9/21/15.
//  Copyright © 2015 The Training, Inc. All rights reserved.
//

#import "CTAudioTableViewCell.h"
#import "CTAudioModel.h"

@implementation CTAudioTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (void)setAudio:(CTAudioModel *)audio {
    _audio = audio;
    
    self.textLabel.text = _audio.name;
//    self.detailTextLabel.text = _post.text;
//    [self.imageView setImageWithURL:_post.user.avatarImageURL placeholderImage:[UIImage imageNamed:@"profile-image-placeholder"]];
    
    [self setNeedsLayout];
}

+ (CGFloat)heightForCellWithAudio:(CTAudioModel *)audio {
    return (CGFloat)fmaxf(70.0f, (float)[self detailTextHeight:audio.name] + 45.0f);
}


+ (CGFloat)detailTextHeight:(NSString *)text {
    CGRect rectToFit = [text boundingRectWithSize:CGSizeMake(240.0f, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12.0f]} context:nil];
    return rectToFit.size.height;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
//    self.imageView.frame = CGRectMake(10.0f, 10.0f, 50.0f, 50.0f);
    self.textLabel.frame = CGRectMake(70.0f, 6.0f, 240.0f, 20.0f);
    
    CGRect detailTextLabelFrame = CGRectOffset(self.textLabel.frame, 0.0f, 25.0f);
    CGFloat calculatedHeight = [[self class] detailTextHeight:self.audio.name];
    detailTextLabelFrame.size.height = calculatedHeight;
    self.detailTextLabel.frame = detailTextLabelFrame;
}


@end
