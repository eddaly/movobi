//
//  MovobiMObjectViewController.h
//  movobi
//
//  Created by Ed Daly on 28/04/2013.
//  Copyright (c) 2013 Movobi Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovobiMObjectViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *mobjects;
@property (weak, nonatomic) IBOutlet UITableView *moactorsTableView;
@property (weak, nonatomic) IBOutlet UITableView *mocharactersTableView;
@property (weak, nonatomic) IBOutlet UITableView *mopropsTableView;
@property (weak, nonatomic) IBOutlet UITableView *molocationsTableView;

@end
