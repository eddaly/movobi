//
//  MovobiScreenObjectsViewController.h
//  movobi
//
//  Created by Ed Daly on 30/04/2013.
//  Copyright (c) 2013 Movobi Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Screen;
@class MovobiScreenView;

@interface MovobiScreenObjectsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) Screen *screen;
@property (nonatomic, strong) NSArray *mobjects;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet MovobiScreenView *screenView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
