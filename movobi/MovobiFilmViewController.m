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
    self.nameLabel.text = film.name; // Note covered up by image
    self.yearLabel.text = film.year; // Note covered up by image
    self.imageView.image = film.image;
}

- (void)viewWillAppear:(BOOL)animated
{
    // Show the 'Films' back option
    [self.navigationController setNavigationBarHidden: NO animated: NO];
    
    NSLog(@"VIEW: %f %f %f %f",self.view.frame.origin.x,self.view.frame.origin.y,self.view.frame.size.width,self.view.frame.size.height);
    NSLog(@"IMAGEVIEW: %f %f %f %f",self.imageView.frame.origin.x,self.imageView.frame.origin.y,self.imageView.frame.size.width,self.imageView.frame.size.height);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
