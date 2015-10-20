//
//  CTAudioController.m
//  ios
//
//  Created by Kevin Musselman on 9/21/15.
//  Copyright © 2015 The Training, Inc. All rights reserved.
//

#import "CTAudioController.h"
#import "CTAudioModel.h"
#import "UIRefreshControl+AFNetworking.h"
#import "UIAlertView+AFNetworking.h"
#import "CTAudioTableViewCell.h"
#import "AFHTTPRequestOperation.h"

#import <AVFoundation/AVAudioSession.h>

@interface CTAudioController ()

@property (readwrite, nonatomic, strong) NSArray *audioFiles;
@end

@implementation CTAudioController

- (id)init {
    self = [super init];
    self.title = @"Audio";
    [[AVAudioSession sharedInstance]
     setCategory: AVAudioSessionCategoryPlayback
     error: nil];
    return self;
}

- (UITabBarItem *)tabBarItem {
    return [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemDownloads tag:1];
}

//-(UIStatusBarStyle)preferredStatusBarStyle
//{
//    return UIStatusBarStyleLightContent;
//}

- (void)reload:(__unused id)sender {
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    NSURLSessionTask *task = [CTAudioModel getAudioFiles:^(NSArray *audiofiles, NSError *error) {
        if (!error) {
            self.audioFiles = audiofiles;
            [self.tableView reloadData];
        }
    }];
    
    [UIAlertView showAlertViewForTaskWithErrorOnCompletion:task delegate:nil];
    [self.refreshControl setRefreshingWithStateOfTask:task];
}


#pragma mark - UIViewController

//- (void)viewDidLayoutSubviews
//{
////    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
////        UIEdgeInsets padding = UIEdgeInsetsMake(8, 10, 8, 10);
////        
////        make.edges.equalTo(self.view).insets(padding);
////    }];
//        [self setEdgesForExtendedLayout:UIRectEdgeNone];
//    
//    [super viewDidLayoutSubviews];
//    
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = NSLocalizedString(@"Audio", nil);
    
    self.refreshControl = [[UIRefreshControl alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableView.frame.size.width, 100.0f)];
    [self.refreshControl addTarget:self action:@selector(reload:) forControlEvents:UIControlEventValueChanged];
    [self.tableView.tableHeaderView addSubview:self.refreshControl];
    
    self.tableView.rowHeight = 70.0f;
    
    [self reload:nil];
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

    return (NSInteger)[self.audioFiles count];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CTAudioTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    NSString *cellText = cell.textLabel.text;
 
    
    
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [path firstObject];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@", cell.audio.url]];
    
    NSString *fullPath = [documentDirectory stringByAppendingPathComponent:[url lastPathComponent]];

    if ([[NSFileManager defaultManager] fileExistsAtPath:fullPath]) {
        NSLog(@"THE FILE EXISTS! yay!");
        NSURL *soundURL = [NSURL fileURLWithPath:fullPath];
        
        NSError *error = nil;
        
        NSData *soundData = [NSData dataWithContentsOfURL:soundURL];
        cell.player = [[AVAudioPlayer alloc] initWithData:soundData error:&error];


        if (!error) {
            [cell.player play];
            NSLog(@"File is playing!");
        }
        else{
            NSLog(@"Error in creating audio player:%@",[error description]);
        }
    }
    else {
        
        NSLog(@"THE FILE iS BEING DOWNLOADED %@", fullPath);
    
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];

        operation.securityPolicy.allowInvalidCertificates = YES;
        operation.securityPolicy.validatesDomainName = NO;

        
        [operation setOutputStream:[NSOutputStream outputStreamToFileAtPath:fullPath append:NO]];
        
        [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
            NSLog(@"bytesRead: %lu, totalBytesRead: %lld, totalBytesExpectedToRead: %lld", (unsigned long)bytesRead, totalBytesRead, totalBytesExpectedToRead);
        }];
        
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSLog(@"RES: %@", [[[operation response] allHeaderFields] description]);
            
            NSError *error;
//            NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:fullPath error:&error];
            
            if (error) {
                NSLog(@"ERR: %@", [error description]);
            } else {
//                NSNumber *fileSizeNumber = [fileAttributes objectForKey:NSFileSize];
//                long long fileSize = [fileSizeNumber longLongValue];
                
                NSURL *soundURL = [NSURL fileURLWithPath:fullPath];
                
                cell.player =  [[AVAudioPlayer alloc] initWithContentsOfURL:soundURL error:&error];
                NSError *error = nil;
                if (!error) {
                    [cell.player play];
                    NSLog(@"File is playing!");
                }
                else{
                    NSLog(@"Error in creating audio player:%@",[error description]);
                }
                
//                [[_downloadFile titleLabel] setText:[NSString stringWithFormat:@"%lld", fileSize]];
            }
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"ERR: %@", [error description]);
                        NSLog(@"ERR: %@", [[operation response] allHeaderFields]);
            NSError * err;
            [[NSFileManager defaultManager] removeItemAtPath:fullPath error:&err];

        }];
        
        [operation start];
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"audiofile" forIndexPath:indexPath];
    static NSString *CellIdentifier = @"AudioCell";
    CTAudioTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[CTAudioTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.audio = self.audioFiles[(NSUInteger)indexPath.row];
    
    return cell;
}


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
