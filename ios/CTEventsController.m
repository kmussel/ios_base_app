//
//  CTEventsController.m
//  ios
//
//  Created by Kevin Musselman on 9/22/15.
//  Copyright © 2015 The Training, Inc. All rights reserved.
//

#import "CTEventsController.h"
#import "UIRefreshControl+AFNetworking.h"
#import "UIAlertView+AFNetworking.h"
#import "CTEventModel.h"
#import "CTEventTableViewCell.h"

@interface CTEventsController ()

@property (readwrite, nonatomic, strong) NSArray *events;

@end

@implementation CTEventsController


- (id)init{
    self = [super init];
    self.title = @"Events";
    return self;
}

- (void)reload:(__unused id)sender {
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    NSURLSessionTask *task = [CTEventModel getEvents:^(NSArray *events, NSError *error) {
        if (!error) {
            self.events = events;
            [self.tableView reloadData];
        }
    }];
    
    [UIAlertView showAlertViewForTaskWithErrorOnCompletion:task delegate:nil];
    [self.refreshControl setRefreshingWithStateOfTask:task];
}


#pragma mark - UIViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = NSLocalizedString(@"Events", nil);
    
    self.refreshControl = [[UIRefreshControl alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableView.frame.size.width, 100.0f)];
    [self.refreshControl addTarget:self action:@selector(reload:) forControlEvents:UIControlEventValueChanged];
    [self.tableView.tableHeaderView addSubview:self.refreshControl];
    
    UIButton * moreBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    moreBtn.titleLabel.text = @"MORE";
    [moreBtn setTitle:@"MOREE" forState:UIControlStateNormal];
    [moreBtn setTintColor:[UIColor blueColor]];
    [moreBtn setTitleShadowColor:[UIColor grayColor] forState:UIControlStateNormal];
    [moreBtn setBackgroundColor:[UIColor greenColor]];
    [moreBtn setTitle:@"HITME" forState:UIControlStateNormal];

    moreBtn.frame = CGRectMake(60, 10, 60, 30);
        [moreBtn layoutIfNeeded];
//    [moreBtn setTintColor:[UIColor blueColor]];

    
    UIView *footerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    self.tableView.tableFooterView = footerView;
    
    [self.tableView.tableFooterView addSubview:moreBtn];
    
    moreBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [self.tableView.tableFooterView addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:|-[moreBtn]-|"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(moreBtn)]];

    //    [_tabbarController.view mas_updateConstraints:^(MASConstraintMaker *make) {
    //
    //        UIEdgeInsets padding = UIEdgeInsetsMake(8, 10, 8, 10);
    //
    //
    ////        make.edges.equalTo(self.window).insets(padding);
    //    }];
    

//    self.tableView.tableFooterView.height = 44;
//    self.tableView.rowHeight = 70.0f;
    
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
    return self.events.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"audiofile" forIndexPath:indexPath];
    static NSString *CellIdentifier = @"EventCell";
    CTEventTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[CTEventTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.event = self.events[(NSUInteger)indexPath.row];
    
    return cell;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 100.0f;
//}
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    
//    UIView *footerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
//    UIButton *addcharity=[UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [addcharity setTitle:@"Add to other" forState:UIControlStateNormal];
//        [addcharity setTintColor:[UIColor blueColor]];
////    [addcharity addTarget:self action:@selector(addCharity:) forControlEvents:UIControlEventTouchUpInside];
//    addcharity.frame=CGRectMake(0, 0, 40, 30);
//    [footerView addSubview:addcharity];
//    return footerView;
//    
//}

@end
