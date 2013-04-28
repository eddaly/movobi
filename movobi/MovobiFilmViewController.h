//
//  MovobiFilmViewController.h
//  movobi
//
//  Created by Ed Daly on 28/04/2013.
//  Copyright (c) 2013 Movobi Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Film;

@interface MovobiFilmViewController : UIViewController

@property (nonatomic, strong) Film *film;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
