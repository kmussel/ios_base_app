//
//  CTFormViewController.m
//  ios
//
//  Created by Kevin Musselman on 9/23/15.
//  Copyright © 2015 The Training, Inc. All rights reserved.
//

#import "CTFormViewController.h"

@interface CTFormViewController ()
@property(nonatomic, strong)  UIWebView *viewer;
@property(nonatomic, strong) UIToolbar *toolbar;
@property(nonatomic, strong) NSString *formUrl;
@end

@implementation CTFormViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    _toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    [_toolbar setTintColor:[UIColor greenColor]];
    [self.view addSubview:_toolbar];
    
    
    UIBarButtonItem * back = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(backPressed:)];
    NSMutableArray *items = [[NSMutableArray alloc] initWithObjects:back, nil];
    [_toolbar setItems:items animated:YES];
    

    _viewer = [[UIWebView alloc] initWithFrame:CGRectMake(0, _toolbar.bottom, self.view.frame.size.width, self.view.size.height-_toolbar.bottom)];
    [self.view addSubview:_viewer];
    
    
    _viewer.translatesAutoresizingMaskIntoConstraints = NO;
    _toolbar.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:|[_toolbar]|"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(_toolbar)]];
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:|[_viewer]|"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(_viewer)]];
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:|[_toolbar]-[_viewer]|"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(_toolbar, _viewer)]];

    
    if (self.formUrl) {
        [self.viewer loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:_formUrl]]];
        [self.view layoutSubviews];
    }
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = FALSE;
    [super viewWillAppear:animated];
}

- (void)backPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
};

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setFormUrl:(NSString *)formUrl {
    _formUrl = formUrl;
    if (self.viewer) {
        [self.viewer loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:_formUrl]]];
        [self.view layoutSubviews];
//        [self.playerView loadWithVideoId:_videoId];
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
