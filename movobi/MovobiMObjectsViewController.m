//
//  MovobiMObjectsViewController.m
//  movobi
//
//  Created by Ed Daly on 28/04/2013.
//  Copyright (c) 2013 Movobi Ltd. All rights reserved.
//

#import "MovobiMObjectsViewController.h"
#import "MObject.h"
#import "MOActor.h"
#import "MOCharacter.h"
#import "MovobiMObjectViewController.h"
#import "MovobiMOActorViewController.h"
#import "MovobiMOCharacterViewController.h"

@interface MovobiMObjectsViewController ()

@end

@implementation MovobiMObjectsViewController

@synthesize mobjects;

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
	// Do any additional setup after loading the view.
    
    self.tableView.delegate = self; 
    self.tableView.dataSource = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.mobjects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MObject";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Set up the cell...
    MObject *mobject = [mobjects objectAtIndex:indexPath.row];
    
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:100];
    [imageView setImage: mobject.image];
    UILabel *descLabel = (UILabel *)[cell viewWithTag:101];
    descLabel.text = mobject.name;
    
    return cell;
}

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MObject *mobject = [self.mobjects objectAtIndex:[tableView indexPathForSelectedRow].row];
    if ([mobject isMemberOfClass:[MOActor class]])
    {
        [self performSegueWithIdentifier:@"ShowMOActorDetail" sender:nil];
    }
    else if ([mobject isMemberOfClass:[MOCharacter class]])
    {
        [self performSegueWithIdentifier:@"ShowMOCharacterDetail" sender:nil];
    }
    else
    {
        [self performSegueWithIdentifier:@"ShowMObjectDetail" sender:nil];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ShowMOActorDetail"])
    {
        MovobiMOActorViewController *viewController = [segue destinationViewController];
        viewController.moactor = [self.mobjects objectAtIndex:[self.tableView indexPathForSelectedRow].row];
    }
    else if ([[segue identifier] isEqualToString:@"ShowMOCharacterDetail"])
    {
        MovobiMOCharacterViewController *viewController = [segue destinationViewController];
        viewController.mocharacter = [self.mobjects objectAtIndex:[self.tableView indexPathForSelectedRow].row];
    }
    else if ([[segue identifier] isEqualToString:@"ShowMObjectDetail"])
    {
        MovobiMObjectViewController *viewController = [segue destinationViewController];
        viewController.mobject = [self.mobjects objectAtIndex:[self.tableView indexPathForSelectedRow].row];
    }
}

@end
