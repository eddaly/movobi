//
//  MovobiMObjectViewController.h
//  movobi
//
//  Created by Ed Daly on 30/03/2013.
//  Copyright (c) 2013 Movobi Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MObject;

@interface MovobiMObjectViewController : UITableViewController <UIWebViewDelegate>
@property (nonatomic, strong) MObject *mobject;

@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end
