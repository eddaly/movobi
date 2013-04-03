//
//  MovobiMovieViewController.h
//  movobi
//
//  Created by Ed Daly on 30/03/2013.
//  Copyright (c) 2013 Movobi Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Movie;

@interface MovobiMovieViewController : UITableViewController
@property (nonatomic, strong) Movie *movie;
@property (nonatomic, strong) NSArray *screens;

@end
