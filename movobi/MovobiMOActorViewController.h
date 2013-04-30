//
//  MovobiMOActorViewController.h
//  movobi
//
//  Created by Ed Daly on 29/04/2013.
//  Copyright (c) 2013 Movobi Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MOActor;

@interface MovobiMOActorViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) MOActor *moactor;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
