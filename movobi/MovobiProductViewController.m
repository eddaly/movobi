//
//  MovobiProductViewController.m
//  Movobi
//
//  Created by Ed Daly on 09/11/2014.
//  Copyright (c) 2014 Movobi Ltd. All rights reserved.
//

#import "MovobiProductViewController.h"
#import "MObject.h"

@interface MovobiProductViewController ()

@end

@implementation MovobiProductViewController

@synthesize mobject;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.descLabel.text = mobject.name;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    // Show the back option
    [self.navigationController setNavigationBarHidden: NO animated: NO];
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
