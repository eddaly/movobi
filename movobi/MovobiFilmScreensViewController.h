//
//  MovobiFilmScreensViewController.h
//  movobi
//
//  Created by Ed Daly on 28/04/2013.
//  Copyright (c) 2013 Movobi Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovobiFilmScreensViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *screens;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
