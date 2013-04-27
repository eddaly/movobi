//
//  MovobiFilmViewController.h
//  movobi
//
//  Created by Ed Daly on 30/03/2013.
//  Copyright (c) 2013 Movobi Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Film;

@interface MovobiFilmViewController : UITableViewController
@property (nonatomic, strong) Film *film;
@property (nonatomic, strong) NSArray *screens;

@end
