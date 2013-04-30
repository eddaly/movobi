//
//  MovobiFilmScreensViewController.m
//  movobi
//
//  Created by Ed Daly on 28/04/2013.
//  Copyright (c) 2013 Movobi Ltd. All rights reserved.
//

#import "MovobiFilmScreensViewController.h"
#import "Screen.h"
#import "Tag.h"
#import "MovobiScreenViewController.h"
#import "MovobiScreenObjectsViewController.h"
#import "MOActor.h"
#import "MOCharacter.h"
#import "MOProp.h"
#import "MOLocation.h"

@interface MovobiFilmScreensViewController ()

@end

@implementation MovobiFilmScreensViewController

@synthesize screens;

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
    return [screens count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Screen";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Set up the cell...
    Screen *screen = [screens objectAtIndex:indexPath.row];
    
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:100];
    [imageView setImage: screen.image];
    UILabel *descLabel = (UILabel *)[cell viewWithTag:101];
    descLabel.text = screen.desc;
    UILabel *timeLabel = (UILabel *)[cell viewWithTag:102];
    timeLabel.text = [NSString stringWithFormat:@"%@ %@", screen.timeStart, screen.timeEnd];
    
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

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
    [self performSegueWithIdentifier:@"ShowScreen" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ShowScreen"])
    {
        UITabBarController *tabBarController = [segue destinationViewController];
        
        MovobiScreenViewController *screenViewController = [[tabBarController viewControllers] objectAtIndex: 0];
        screenViewController.screen = [screens objectAtIndex:[self.tableView indexPathForSelectedRow].row];
        
        MovobiScreenObjectsViewController *moactorsViewController = [[tabBarController viewControllers] objectAtIndex: 1];
        moactorsViewController.screen = [screens objectAtIndex:[self.tableView indexPathForSelectedRow].row];
        MovobiScreenObjectsViewController *mocharactersViewController = [[tabBarController viewControllers] objectAtIndex: 2];
        mocharactersViewController.screen = [screens objectAtIndex:[self.tableView indexPathForSelectedRow].row];
        
        MovobiScreenObjectsViewController *mopropsViewController = [[tabBarController viewControllers] objectAtIndex: 3];
        mopropsViewController.screen = [screens objectAtIndex:[self.tableView indexPathForSelectedRow].row];
        MovobiScreenObjectsViewController *molocsViewController = [[tabBarController viewControllers] objectAtIndex: 4];
        molocsViewController.screen = [screens objectAtIndex:[self.tableView indexPathForSelectedRow].row];
        
        // Sort and set objects array for the object views
        NSSortDescriptor *descriptorName = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
        
    
        
        NSMutableArray *moactorsArray = [NSMutableArray arrayWithCapacity: 0];
        NSMutableArray *mocharactersArray = [NSMutableArray arrayWithCapacity: 0];
        NSMutableArray *mopropsArray = [NSMutableArray arrayWithCapacity: 0];
        NSMutableArray *molocsArray = [NSMutableArray arrayWithCapacity: 0];

        for (Tag *tag in screenViewController.screen.tags)
        {
            NSArray *mobjectsArray = [tag.mobjects sortedArrayUsingDescriptors: [NSArray arrayWithObject:descriptorName]];
        
            for (MObject *mobject in mobjectsArray)
            {
                if ([mobject isMemberOfClass:[MOActor class]])
                {
                    [moactorsArray addObject: mobject];
                }
                else if ([mobject isMemberOfClass:[MOCharacter class]])
                {
                    [mocharactersArray addObject:mobject];
                }
                else if ([mobject isMemberOfClass:[MOProp class]])
                {
                    [mopropsArray addObject:mobject];
                }
                else if ([mobject isMemberOfClass:[MOLocation class]])
                {
                    [molocsArray addObject:mobject];
                }
            }
        }
        
        moactorsViewController.mobjects = moactorsArray;
        mocharactersViewController.mobjects = mocharactersArray;
        mopropsViewController.mobjects = mopropsArray;
        molocsViewController.mobjects = molocsArray;
    }
}

@end
