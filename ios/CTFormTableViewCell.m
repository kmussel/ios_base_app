//
//  CTFormTableViewCell.m
//  ios
//
//  Created by Kevin Musselman on 9/23/15.
//  Copyright © 2015 The Training, Inc. All rights reserved.
//

#import "CTFormTableViewCell.h"
#import "CTFormModel.h"

@implementation CTFormTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setForm:(CTFormModel *)form {
    _form = form;
    //    if(!self.playerView)
    //    {
    //        self.playerView = [[YTPlayerView alloc] initWithFrame:self.frame];
    //        [self addSubview:self.playerView];
    //        [self.playerView loadWithVideoId:_video.videoId];
    //
    //        [self.playerView cueVideoById:_video.videoId startSeconds:0.0 suggestedQuality:kYTPlaybackQualityDefault];
    //    }
    //    else {
    //        [self.playerView cueVideoById:_video.videoId startSeconds:0.0 suggestedQuality:kYTPlaybackQualityDefault];
    //    }
    //    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];
    //    requestOperation.responseSerializer = [AFImageResponseSerializer serializer];
    //    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
    //        NSLog(@"Response: %@", responseObject);
    //        _imageView.image = responseObject;
    //
    //    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    //        NSLog(@"Image error: %@", error);
    //    }];
    //    [requestOperation start];
    //
    self.textLabel.text = _form.name;
    //    self.detailTextLabel.text = _post.text;

//    __weak typeof(self) weakSelf = self;
//    [self.imageView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_video.url]] placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nonnull response, UIImage * _Nonnull image) {
//        NSLog(@"IT WORKED");
//        weakSelf.imageView.image = image;
//        [weakSelf setNeedsLayout];
//        
//    } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nonnull response, NSError * _Nonnull error) {
//        
//    }];
    //    [self.imageView setImageWithURL:[NSURL URLWithString:_video.url]];
    //        [self.videoThumbnail setImageWithURL:_post.user.avatarImageURL placeholderImage:[UIImage imageNamed:@"profile-image-placeholder"]];
    //    [self.imageView setImageWithURL:_post.user.avatarImageURL placeholderImage:[UIImage imageNamed:@"profile-image-placeholder"]];
    
    [self setNeedsLayout];
}

+ (CGFloat)heightForCellWithForm:(CTFormModel *)form {
    return (CGFloat)fmaxf(70.0f, (float)[self detailTextHeight:form.name] + 45.0f);
}

+ (CGFloat)detailTextHeight:(NSString *)text {
    CGRect rectToFit = [text boundingRectWithSize:CGSizeMake(240.0f, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12.0f]} context:nil];
    return rectToFit.size.height;
}


@end
