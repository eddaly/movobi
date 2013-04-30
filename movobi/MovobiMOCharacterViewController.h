//
//  MovobiMOCharacterViewController.h
//  movobi
//
//  Created by Ed Daly on 29/04/2013.
//  Copyright (c) 2013 Movobi Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MOCharacter;

@interface MovobiMOCharacterViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) MOCharacter *mocharacter;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
