//
//  MovobiProductViewController.h
//  Movobi
//
//  Created by Ed Daly on 09/11/2014.
//  Copyright (c) 2014 Movobi Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MObject;

@interface MovobiProductViewController : UIViewController
@property (nonatomic, strong) MObject *mobject;

@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@end
