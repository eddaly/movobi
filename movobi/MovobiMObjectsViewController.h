//
//  MovobiMObjectsViewController.h
//  movobi
//
//  Created by Ed Daly on 28/04/2013.
//  Copyright (c) 2013 Movobi Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovobiMObjectsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *mobjects;
@property (nonatomic) BOOL useClassSpecificDetailViews;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
