//
//  MovobiMasterViewController.m
//  movobi
//
//  Created by Ed Daly on 30/03/2013.
//  Copyright (c) 2013 Movobi Ltd. All rights reserved.
//

#import "MovobiMasterViewController.h"
#import "MovobiMovieViewController.h"
#import "Movie.h"
#import "Screen.h"

@implementation MovobiMasterViewController

@synthesize managedObjectContext;
@synthesize movies;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSSortDescriptor *nameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = @[nameDescriptor];
    [fetchRequest setSortDescriptors: sortDescriptors];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Movie" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError *error;
    self.movies = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    //self.title = @"Movies";
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return [movies count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Movie";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Set up the cell...
    Movie *movie = [movies objectAtIndex:indexPath.row];
    cell.textLabel.text = movie.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@",
                                 movie.resolutionWidth, movie.resolutionHeight];
    
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
    [self performSegueWithIdentifier:@"ShowMovie" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ShowMovie"])
    {
        MovobiMovieViewController *movieViewController = [segue destinationViewController];
        
        movieViewController.movie = [movies objectAtIndex:[self.tableView indexPathForSelectedRow].row];
    }
}

@end
