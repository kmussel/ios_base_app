//
//  CTVideoViewController.m
//  ios
//
//  Created by Kevin Musselman on 9/22/15.
//  Copyright © 2015 The Training, Inc. All rights reserved.
//

#import "CTVideoViewController.h"


@interface CTVideoViewController ()

@property(nonatomic, strong) NSString *videoId;

@end

@implementation CTVideoViewController


//-(UIStatusBarStyle)preferredStatusBarStyle
//{
//    return UIStatusBarStyleLightContent;
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.playerView = [[YTPlayerView alloc] initWithFrame:self.view.frame];
                       //CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-20 )];
    self.playerView.delegate = self;
    if (_videoId) {
        [self.playerView loadWithVideoId:_videoId];        
    }

    [self.view addSubview:self.playerView];
//    UIButton *close = [UIButton buttonWithType:UIButtonTypeSystem];
//    [close setTitle:@"CLOSE" forState:UIControlStateNormal];
//    [close setBackgroundColor:[UIColor whiteColor]];
//    close.top = 20;
//    [close sizeToFit];
//    [close addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:close];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = FALSE;
    [super viewWillAppear:animated];
}

-(void)dismiss{
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"dismissed");
    }];
}

-(void)setVideoId:(NSString *)videoId {
    _videoId = videoId;
    if (self.playerView) {
     [self.playerView loadWithVideoId:_videoId];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)playerView:(YTPlayerView *)playerView didChangeToState:(YTPlayerState)state {
    NSLog(@"THE STATE = %ld", (long)state);
    switch (state) {
        case kYTPlayerStatePlaying:
            NSLog(@"Started playback");
            break;
        case kYTPlayerStatePaused:
            NSLog(@"Paused playback");
            break;
        default:
            break;
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
