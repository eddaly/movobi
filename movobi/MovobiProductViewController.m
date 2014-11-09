//
//  MovobiProductViewController.m
//  Movobi
//
//  Created by Ed Daly on 09/11/2014.
//  Copyright (c) 2014 Movobi Ltd. All rights reserved.
//

#import "MovobiProductViewController.h"
#import "MObject.h"
#import "MovobiMObjectViewController.h"

@interface MovobiProductViewController ()

@end

@implementation MovobiProductViewController

@synthesize mobject;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.descLabel.text = mobject.name;
    self.imageView.image = mobject.image;
    
    //*** To add to model
    //self.descLabelMidTier.text = mobject. ?;
    //self.imageViewMidTier.image = mobject. ?;
    //self.descLabelLowTier.text = mobject. ?;
    //self.imageViewLowTier.image = mobject. ?;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    // Show the back option
    [self.navigationController setNavigationBarHidden: NO animated: NO];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    MovobiMObjectViewController *mobjectViewController = [segue destinationViewController];
    mobjectViewController.mobject = mobject;

    if ([[segue identifier] isEqualToString:@"ShowTopTier"])
    {
        mobjectViewController.mobject.url = [NSString stringWithFormat: @"http://google.com/search?q=%@&safe", mobject.name];
    }
    else if ([[segue identifier] isEqualToString:@"ShowMidTier"])
    {
         mobjectViewController.mobject.url = [NSString stringWithFormat: @"http://www.selfridges.com/webapp/wcs/stores/servlet/FhBrowse?freeText=%@&srch=Y", mobject.name];
    }
    else if ([[segue identifier] isEqualToString:@"ShowLowTier"])
    {
        mobjectViewController.mobject.url = [NSString stringWithFormat: @"http://m.topshop.com/mt/www.topshop.com/webapp/wcs/stores/servlet/CatalogNavigationSearchResultCmd?langId=-1&storeId=12556&catalogId=33057&beginIndex=1&viewAllFlag=false&pageSize=20&sort_field=Relevance&un_jtt_headerSearch.x=0&un_jtt_headerSearch.y=0&searchTerm=%@&un_form_encoding=utf-8", mobject.name];
    }
}


@end
