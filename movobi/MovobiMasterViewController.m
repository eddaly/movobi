//
//  MovobiMasterViewController.m
//  movobi
//
//  Created by Ed Daly on 30/03/2013.
//  Copyright (c) 2013 Movobi Ltd. All rights reserved.
//

#import "MovobiMasterViewController.h"
#import "MovobiFilmViewController.h"
#import "Film.h"
#import "Screen.h"

@implementation MovobiMasterViewController

@synthesize managedObjectContext;
@synthesize films;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSSortDescriptor *nameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = @[nameDescriptor];
    [fetchRequest setSortDescriptors: sortDescriptors];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Film" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError *error;
    self.films = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    //self.title = @"Movies";
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return [films count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Film";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Set up the cell...
    Film *film = [films objectAtIndex:indexPath.row];
    cell.textLabel.text = film.name;
    //cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@",
      //                           film.resolutionWidth, film.resolutionHeight];
    
    //UIImageView
    /*NSArray *screens = [movie.screens allObjects];
    for (Screen *screen in screens)
    {
        [cell.imageView setImage: screen.image];
    }*/
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"ShowFilm" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ShowFilm"])
    {
        MovobiFilmViewController *filmViewController = [segue destinationViewController];
        filmViewController.film = [films objectAtIndex:[self.tableView indexPathForSelectedRow].row];
    }
}

@end
