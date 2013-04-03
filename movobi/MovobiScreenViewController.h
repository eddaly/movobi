//
//  MovobiScreenViewController.h
//  movobi
//
//  Created by Ed Daly on 30/03/2013.
//  Copyright (c) 2013 Movobi Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Screen;
@class MovobiScreenView;

@interface MovobiScreenViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) Screen *screen;
@property (nonatomic, strong) NSArray *tags;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet MovobiScreenView *screenView;
@property (weak, nonatomic) IBOutlet UITableView *tagsTable;

@end
