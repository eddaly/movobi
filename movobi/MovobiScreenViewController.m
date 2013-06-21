//
//  MovobiScreenViewController.m
//  movobi
//
//  Created by Ed Daly on 30/03/2013.
//  Copyright (c) 2013 Movobi Ltd. All rights reserved.
//

#import "MovobiScreenViewController.h"
#import "MovobiMObjectViewController.h"
#import "MovobiScreenView.h"
#import "Film.h"
#import "Screen.h"
#import "Tag.h"
#import "MObject.h"
#import "MOActor.h"
#import "MOCharacter.h"
#import "MOProp.h"
#import "MOLocation.h"


@interface MovobiScreenViewController ()

@end

@implementation MovobiScreenViewController

@synthesize screen;
@synthesize tags;
@synthesize tag;
@synthesize mobjectsArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //self.userInteractionEnabled = TRUE;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.image setImage: screen.image];
    //[ self setClearsSelectionOnViewWillAppear:NO ];
    
    NSSortDescriptor *nameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"desc" ascending:YES];
    NSArray *sortDescriptors = @[nameDescriptor];
    tags = [screen.tags sortedArrayUsingDescriptors: sortDescriptors];
    
    //[self.navigationController setNavigationBarHidden: NO animated: YES]; If was hiding in FilmVC
}
/* no longer needed presumably
- (void)viewWillAppear:(BOOL)animated
{
    // Select again as not automatic when programmatically selected via touching image
    [self.tableView selectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:NO scrollPosition:UITableViewScrollPositionNone];
    
    [self.screenView setSelectedTagIndex: [NSNumber numberWithInt: -1]];
    [self.screenView setNeedsDisplay];
}

- (void)viewDidAppear:(BOOL)animated
{
    // As forced select above need to deselect when appeared
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES ];
}
*/
-(void)selectTag:(NSInteger) index
{
    self.tag = [tags objectAtIndex:index];
    [self.tableView reloadData];
}

- (void)viewDidLayoutSubviews
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity: [tags count]];
    for (Tag *aTag in tags)
    {
        // Scaled image
        CGRect r = [ self frameForImage: self.image.image inImageViewAspectFit: self.image];
        
        // Scaled tag
        CGRect tagRect = CGRectMake (r.origin.x + [aTag.rectTopLeftX floatValue] * r.size.width,
                                     r.origin.y + [aTag.rectTopLeftY floatValue] * r.size.height,
                                     [aTag.rectWidth floatValue] * r.size.width,
                                     [aTag.rectHeight floatValue] * r.size.height);
        
        NSValue *tagRectObj = [NSValue valueWithCGRect:tagRect];
        [array addObject: tagRectObj];
    }
    
    [self.screenView setTagRects: array];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)canBecomeFirstResponder
{
    return TRUE;
}

-(CGRect)frameForImage:(UIImage*)image inImageViewAspectFit:(UIImageView*)imageView
{
    float imageRatio = image.size.width / image.size.height;
    float viewRatio = imageView.frame.size.width / imageView.frame.size.height;
    
    if(imageRatio < viewRatio)
    {
        float scale = imageView.frame.size.height / image.size.height;
        float width = scale * image.size.width;
        float topLeftX = (imageView.frame.size.width - width) * 0.5;
        return CGRectMake(topLeftX, 0, width, imageView.frame.size.height);
    }
    else
    {
        float scale = imageView.frame.size.width / image.size.width;
        float height = scale * image.size.height;
        float topLeftY = (imageView.frame.size.height - height) * 0.5;
        return CGRectMake(0, topLeftY, imageView.frame.size.width, height);
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event]; //otherwise have to stub other touch events
    
    UITouch *touch = [touches anyObject];
    
    CGPoint point = [touch locationInView: self.image];
    NSUInteger i = 0;
    for (Tag *aTag in tags)
    {
        // Scaled image
        CGRect r = [ self frameForImage: self.image.image inImageViewAspectFit: self.image];
        
        // Scaled tag
        CGRect rect = CGRectMake (r.origin.x + [aTag.rectTopLeftX floatValue] * r.size.width,
                                  r.origin.y + [aTag.rectTopLeftY floatValue] * r.size.height,
                                  [aTag.rectWidth floatValue] * r.size.width,
                                  [aTag.rectHeight floatValue] * r.size.height);

        if (point.x >= rect.origin.x &&
            point.x <= rect.origin.x + rect.size.width &&
            point.y >= rect.origin.y &&
            point.y <= rect.origin.y + rect.size.height)
        {
            [self.screenView setSelectedTagIndex: [NSNumber numberWithInt: i]];
            [self.screenView setNeedsDisplay];
            [self selectTag: i];
            return;
        }
        i++;
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event]; //otherwise have to stub other touch events
    
    UITouch *touch = [touches anyObject];
    
    CGPoint point = [touch locationInView: self.image];
    NSUInteger i = 0;
    bool alreadySelected = false;
    
    for (Tag *aTag in tags)
    {
        // Scaled image
        CGRect r = [self frameForImage: self.image.image inImageViewAspectFit: self.image];
        
        // Scaled tag
        CGRect rect = CGRectMake (r.origin.x + [aTag.rectTopLeftX floatValue] * r.size.width,
                                  r.origin.y + [aTag.rectTopLeftY floatValue] * r.size.height,
                                  [aTag.rectWidth floatValue] * r.size.width,
                                  [aTag.rectHeight floatValue] * r.size.height);
        
        
        if (point.x >= rect.origin.x &&
            point.x <= rect.origin.x + rect.size.width &&
            point.y >= rect.origin.y &&
            point.y <= rect.origin.y + rect.size.height && !alreadySelected)
        {
            //should also highlight box here (need to force redraw)
            [self.screenView setSelectedTagIndex: [NSNumber numberWithInt: i]];
            [self.screenView setNeedsDisplay];
            [self selectTag: i];
            alreadySelected = true; // prevent overlapping tags fighting for selection (need a better solution)
        }
        i++;
    }
  
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event]; //otherwise have to stub other touch events
}

// E.g. a system event cancels, like low memory/battery
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event]; //otherwise have to stub other touch events (done now so perhaps remove?)
    [self.screenView setSelectedTagIndex: [NSNumber numberWithInt: -1]];
    [self.screenView setNeedsDisplay];
    [self selectTag:0];// safe enough?
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.tag != nil){NSLog(@"%d",[self.tag.mobjects count]);
        return [self.tag.mobjects count];}
    else
        return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MObject";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Set up the cell...
    NSSortDescriptor *descriptorName = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    self.mobjectsArray = [self.tag.mobjects sortedArrayUsingDescriptors: [NSArray arrayWithObject:descriptorName]];
    MObject *mobject = [mobjectsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = mobject.name;
    if ([mobject isMemberOfClass:[MOActor class]])
        cell.detailTextLabel.text = @"Actor";
    else if ([mobject isMemberOfClass:[MOCharacter class]])
        cell.detailTextLabel.text = @"Character";
    else if ([mobject isMemberOfClass:[MOProp class]])
        cell.detailTextLabel.text = @"Object";
    else if ([mobject isMemberOfClass:[MOLocation class]])
        cell.detailTextLabel.text = @"Location";
    cell.imageView.image = mobject.image;
    
    return cell;
    
}

#pragma mark - Table view delegate
/*
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (
    return TRUE;
}*/
        
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"ShowMObject" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ShowMObject"])
    {
        MovobiMObjectViewController *mobjectViewController = [segue destinationViewController];
        mobjectViewController.mobject = [self.mobjectsArray objectAtIndex:[self.tableView indexPathForSelectedRow].row];
    }
}

@end
