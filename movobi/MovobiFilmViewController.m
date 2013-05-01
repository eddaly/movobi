//
//  MovobiFilmViewController.m
//  movobi
//
//  Created by Ed Daly on 28/04/2013.
//  Copyright (c) 2013 Movobi Ltd. All rights reserved.
//

#import "MovobiFilmViewController.h"
#import "MovobiScreenViewController.h"
#import "Film.h"

@interface MovobiFilmViewController ()

@end

@implementation MovobiFilmViewController

@synthesize film;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = film.name; //can't seem to name title bar of tabviews
    self.nameLabel.text = film.name;
    self.yearLabel.text = film.year;
    self.imageView.image = film.image;
    
    //[self.navigationController setNavigationBarHidden: YES animated: YES]; could use this to lose Films option (need to show again in ScreenViewController so can get 'back'
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
