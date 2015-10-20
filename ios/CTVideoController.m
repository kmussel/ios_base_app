//
//  CTVideoController.m
//  ios
//
//  Created by Kevin Musselman on 9/22/15.
//  Copyright © 2015 The Training, Inc. All rights reserved.
//

#import "CTVideoController.h"
#import "CTVideoModel.h"
#import "CTVideoTableViewCell.h"
#import "UIRefreshControl+AFNetworking.h"
#import "UIAlertView+AFNetworking.h"

#import "CTVideoViewController.h"
#import "YTPlayerView.h"

@interface CTVideoController ()

@property (readwrite, nonatomic, strong) NSArray *videoFiles;

@property(nonatomic, strong)  CTVideoViewController *playerWrapper;

@end

@implementation CTVideoController

- (id)init{
    self = [super init];
    self.title = @"Videos";
    return self;
    
}

//- (IBAction)refresh:(id)sender {
//
//}

- (void)reload:(__unused id)sender {
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    AFHTTPRequestOperation *task =  [CTVideoModel getVideoFiles:^(NSArray *videofiles, NSError *error) {
        if (!error) {
            NSLog(@"THE ViDEo fiLES are %@", videofiles);
            self.videoFiles = videofiles;
            [self.tableView reloadData];
        }
    }];
    
    [UIAlertView showAlertViewForTaskWithErrorOnCompletion:task delegate:nil];
    [self.refreshControl setRefreshingWithStateOfTask:task];
}


#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor grayColor];

    self.playerWrapper = [[CTVideoViewController alloc] init];
    self.title = NSLocalizedString(@"Videos", nil);
    
    self.refreshControl = [[UIRefreshControl alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableView.frame.size.width, 100.0f)];
    [self.refreshControl addTarget:self action:@selector(reload:) forControlEvents:UIControlEventValueChanged];
    [self.tableView.tableHeaderView addSubview:self.refreshControl];
    
    self.tableView.rowHeight = 70.0f;
    
    [self reload:nil];
}

-(void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = TRUE;
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.videoFiles.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"VideoCell";
    CTVideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[CTVideoTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.video = self.videoFiles[(NSUInteger)indexPath.row];
    NSLog(@"THE Video = %@", cell.video);
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CTVideoTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //    NSString *cellText = cell.textLabel.text;
    
    
    
    
//    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:3000/%@", cell.audio.url]];
//    NSString *fullPath = [NSTemporaryDirectory() stringByAppendingPathComponent:[url lastPathComponent]];
//    [cell.playerView loadWithVideoId:cell.video.videoId];

//    [self addChildViewController:self.playerWrapper];

        [self.playerWrapper setVideoId:cell.video.videoId];
    [self.navigationController pushViewController:self.playerWrapper animated:YES];

//        [self.playerWrapper.playerView loadWithVideoId:cell.video.videoId];    
//    [self presentViewController:self.playerWrapper animated:YES completion:^{
//        self.playerWrapper.playerView.delegate = self;        

////        [self.playerWrapper.playerView cueVideoById:cell.video.videoId startSeconds:0.0 suggestedQuality:kYTPlaybackQualityDefault];
//
//    }];
//    [self.playerView loadWithVideoId:cell.video.videoId];
//    [self.playerView playVideo];
}

//-(void)dismiss{
//    NSLog(@"CALL DISMISS");
//    [self dismissViewControllerAnimated:YES completion:^{
//        NSLog(@"dismissed");
//        [self.tableView reloadData];
//    }];
//}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
