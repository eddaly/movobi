//
//  MovobiTagViewController.h
//  movobi
//
//  Created by Ed Daly on 30/03/2013.
//  Copyright (c) 2013 Movobi Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Tag;

@interface MovobiTagViewController : UITableViewController <UIWebViewDelegate>
@property (nonatomic, strong) Tag *tag;

@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
