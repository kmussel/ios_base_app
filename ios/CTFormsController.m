//
//  CTFormsController.m
//  ios
//
//  Created by Kevin Musselman on 9/22/15.
//  Copyright © 2015 The Training, Inc. All rights reserved.
//

#import "CTFormsController.h"
#import "CTFormTableViewCell.h"
#import "CTFormViewController.h"
#import "CTFormModel.h"

@interface CTFormsController ()

@property (readwrite, nonatomic, strong) NSArray *forms;
@property(nonatomic, strong)  CTFormViewController *formViewer;
@end

@implementation CTFormsController


- (id)init{
    self = [super init];
    self.title = @"Forms";
    return self;
    
}

- (void)reload:(__unused id)sender {
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    NSURLSessionTask *task = [CTFormModel getForms:^(NSArray *forms, NSError *error) {
        if (!error) {
            self.forms = forms;
            [self.tableView reloadData];
        }
    }];

    [UIAlertView showAlertViewForTaskWithErrorOnCompletion:task delegate:nil];
    [self.refreshControl setRefreshingWithStateOfTask:task];
}


#pragma mark - UIViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.formViewer = [[CTFormViewController alloc] init];
    
    self.title = NSLocalizedString(@"Forms", nil);
    
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
    return self.forms.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"audiofile" forIndexPath:indexPath];
    static NSString *CellIdentifier = @"FormCell";
    CTFormTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[CTFormTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.form = self.forms[(NSUInteger)indexPath.row];
    NSLog(@"THE Form = %@", cell.form);
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CTFormTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //    NSString *cellText = cell.textLabel.text;
    

    
    [self.formViewer setFormUrl:[NSString stringWithFormat:@"http://kmussel.local/%@", cell.form.url]];
    [self.navigationController presentViewController:self.formViewer animated:YES completion:^{
        NSLog(@"displayed formviewer");
    }];
//    [self.navigationController pushViewController:self.formViewer animated:YES];
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
