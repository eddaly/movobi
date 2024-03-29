//
//  MovobiScreenObjectsViewController.m
//  movobi
//
//  Created by Ed Daly on 30/04/2013.
//  Copyright (c) 2013 Movobi Ltd. All rights reserved.
//

#import "MovobiScreenObjectsViewController.h"
#import "MObject.h"
#import "MOCharacter.h"
#import "MOProp.h"
#import "Screen.h"
#import "MovobiMObjectViewController.h"
#import "MovobiMOCharacterViewController.h"
#import "MovobiProductViewController.h"

@interface MovobiScreenObjectsViewController ()

@end

@implementation MovobiScreenObjectsViewController

@synthesize screen;
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
    
    [self.image setImage: screen.image];
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
    MObject *mobject = [self.mobjects objectAtIndex:indexPath.row];
    
    cell.textLabel.text = mobject.name;
    cell.imageView.image = mobject.image;
    
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
    if ([mobject isMemberOfClass:[MOProp class]])
    {
        [self performSegueWithIdentifier:@"ShowProduct" sender:nil];
    }
    else if ([mobject isMemberOfClass:[MOCharacter class]])
    {
        [self performSegueWithIdentifier:@"ShowCharacter" sender:nil];
    }
    else
    {
        [self performSegueWithIdentifier:@"ShowMObject" sender:nil];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ShowMObject"])
    {
        MovobiMObjectViewController *mobjectViewController = [segue destinationViewController];
        mobjectViewController.mobject = [self.mobjects objectAtIndex:[self.tableView indexPathForSelectedRow].row];
    }
    else if ([[segue identifier] isEqualToString:@"ShowCharacter"])
    {
        MovobiMOCharacterViewController *mocharacterViewController = [segue destinationViewController];
        mocharacterViewController.mocharacter = [self.mobjects objectAtIndex:[self.tableView indexPathForSelectedRow].row];
    }
    else if ([[segue identifier] isEqualToString:@"ShowProduct"])
    {
        MovobiProductViewController *productViewController = [segue destinationViewController];
        productViewController.mobject = [self.mobjects objectAtIndex:[self.tableView indexPathForSelectedRow].row];
    }
}

@end
