//
//  CTExampleViewController.m
//  ios
//
//  Created by Kevin Musselman on 9/18/15.
//  Copyright © 2015 The Training, Inc. All rights reserved.
//

#import "CTExampleViewController.h"
#import "CTExampleView.h"

@interface CTExampleViewController ()
@property (strong, nonatomic) CTExampleView *exampleView;
@end

@implementation CTExampleViewController

- (void)viewDidLayoutSubviews
{
    [self.exampleView mas_updateConstraints:^(MASConstraintMaker *make) {
        UIEdgeInsets padding = UIEdgeInsetsMake(8, 10, 8, 10);
        
        make.edges.equalTo(self.view).insets(padding);
    }];
    
    [super viewDidLayoutSubviews];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title                  = @"Example Controller";
    self.view.backgroundColor   = [UIColor redColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Getters
- (UITabBarItem *)tabBarItem {
    return [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemHistory tag:0];
}

- (CTExampleView *)exampleView {
    if(_exampleView)
        return _exampleView;
    
    _exampleView        = [[CTExampleView alloc] initWithFrame:CGRectZero];
    _exampleView.title  = @"Hello World";
    
    [self.view addSubview:_exampleView];
    
    return _exampleView;
}

@end
