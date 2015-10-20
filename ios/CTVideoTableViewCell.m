//
//  CTVideoTableViewCell.m
//  ios
//
//  Created by Kevin Musselman on 9/22/15.
//  Copyright © 2015 The Training, Inc. All rights reserved.
//

#import "CTVideoTableViewCell.h"
#import "CTVideoModel.h"
#import "UIImageView+AFNetworking.h"

@implementation CTVideoTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setVideo:(CTVideoModel *)video {
    _video = video;
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
    self.textLabel.text = _video.name;
    //    self.detailTextLabel.text = _post.text;
    NSLog(@"THE VIDEO URL = %@", _video.url);
    __weak typeof(self) weakSelf = self;
    [self.imageView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_video.url]] placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nonnull response, UIImage * _Nonnull image) {
        NSLog(@"IT WORKED");
        weakSelf.imageView.image = image;
        [weakSelf setNeedsLayout];
        
    } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nonnull response, NSError * _Nonnull error) {
        
    }];
//    [self.imageView setImageWithURL:[NSURL URLWithString:_video.url]];
//        [self.videoThumbnail setImageWithURL:_post.user.avatarImageURL placeholderImage:[UIImage imageNamed:@"profile-image-placeholder"]];
    //    [self.imageView setImageWithURL:_post.user.avatarImageURL placeholderImage:[UIImage imageNamed:@"profile-image-placeholder"]];
    
    [self setNeedsLayout];
}

+ (CGFloat)heightForCellWithVideo:(CTVideoModel *)video {
    return (CGFloat)fmaxf(70.0f, (float)[self detailTextHeight:video.name] + 45.0f);
}


+ (CGFloat)detailTextHeight:(NSString *)text {
    CGRect rectToFit = [text boundingRectWithSize:CGSizeMake(240.0f, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12.0f]} context:nil];
    return rectToFit.size.height;
}


- (void)layoutSubviews {
//      self.imageView.backgroundColor = [UIColor blueColor];

    [super layoutSubviews];


//    if(!self.videoThumbnail)
//    {
//        self.videoThumbnail = [[UIImageView alloc] initWithFrame:self.frame];
//        [self addSubview:self.videoThumbnail];
//    }
    
    //    self.imageView.frame = CGRectMake(10.0f, 10.0f, 50.0f, 50.0f);
//    self.textLabel.frame = CGRectMake(70.0f, 6.0f, 240.0f, 20.0f);
//    
//    CGRect detailTextLabelFrame = CGRectOffset(self.textLabel.frame, 0.0f, 25.0f);
//    CGFloat calculatedHeight = [[self class] detailTextHeight:self.video.name];
//    detailTextLabelFrame.size.height = calculatedHeight;
//    self.detailTextLabel.frame = detailTextLabelFrame;
}

@end
