//
//  CTExampleView.m
//  ios
//
//  Created by Kevin Musselman on 9/18/15.
//  Copyright © 2015 The Training, Inc. All rights reserved.
//

#import "CTExampleView.h"

@interface CTExampleView()
@property (strong, nonatomic) UIImageView   *iconView;
@property (strong, nonatomic) UILabel       *titleLabel;
@end

@implementation CTExampleView


#pragma mark - Layout
- (void)updateConstraints
{
    [self.iconView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self).offset(40);
        make.right.equalTo(self);
        make.left.equalTo(self);
    }];
    
    [super updateConstraints];
}

#pragma mark - Setters
- (void)setTitle:(NSString *)title
{
    [self willChangeValueForKey:@"title"];
    
    self.titleLabel.text = [title copy];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    
    [self didChangeValueForKey:@"title"];
}

#pragma mark - Getters
- (NSString *)title {
    return self.titleLabel.text;
}

- (UIImageView *)iconView {
    if(_iconView)
        return _iconView;
    
    _iconView               = [[UIImageView alloc] initWithFrame:CGRectZero];
    _iconView.image         = [UIImage imageNamed:@"some-name"];
    _iconView.contentMode   = UIViewContentModeCenter;
    
    [self addSubview:_iconView];
    
    return _iconView;
}

- (UILabel *)titleLabel {
    if(_titleLabel)
        return _titleLabel;
    
    _titleLabel                 = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.backgroundColor = [UIColor whiteColor];
    _titleLabel.textAlignment   = NSTextAlignmentCenter;
    _titleLabel.font            = [UIFont boldSystemFontOfSize:40];
    
    [self addSubview:_titleLabel];
    
    return _titleLabel;
}

@end







