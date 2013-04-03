//
//  MovobiScreenViewController.m
//  movobi
//
//  Created by Ed Daly on 30/03/2013.
//  Copyright (c) 2013 Movobi Ltd. All rights reserved.
//

#import "MovobiScreenViewController.h"
#import "MovobiTagViewController.h"
#import "MovobiScreenView.h"
#import "Movie.h"
#import "Screen.h"
#import "Tag.h"

@interface MovobiScreenViewController ()

@end

@implementation MovobiScreenViewController

@synthesize screen;
@synthesize tags;

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
    
    //Note, not currently linked tags to screens as may wish to decouple
    //for when missing screens (not that this view can manage that)
     //*** should only display those near screen based on time
    //tags = [NSArray alloc]; //needed, don't really get this stuff
    NSSortDescriptor *nameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timeStart" ascending:YES];
    NSArray *sortDescriptors = @[nameDescriptor];
    tags = [screen.movie.tags sortedArrayUsingDescriptors: sortDescriptors];
}

- (void)viewWillAppear:(BOOL)animated
{
    // Select again as not automatic when programmatically selected via touching image
    [self.tagsTable selectRowAtIndexPath:[self.tagsTable indexPathForSelectedRow] animated:NO scrollPosition:UITableViewScrollPositionNone];
    
    [self.screenView setSelectedTagIndex: [NSNumber numberWithInt: -1]];
    [self.screenView setNeedsDisplay];
}

- (void)viewDidAppear:(BOOL)animated
{
    // As forced select above need to deselect when appeared
    [self.tagsTable deselectRowAtIndexPath:[self.tagsTable indexPathForSelectedRow] animated:YES ];
}

- (void)viewDidLayoutSubviews
{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity: [tags count]];
    for (Tag *tag in tags)
    {
        // Scaled image
        CGRect r = [ self frameForImage: self.image.image inImageViewAspectFit: self.image];
        
        // Scaled tag
        CGRect tagRect = CGRectMake (
                                     r.origin.x + [tag.rectTopLeftX floatValue] * r.size.width,
                                     r.origin.y + [tag.rectTopLeftY floatValue] * r.size.height,
                                     [tag.rectWidth floatValue] * r.size.width,
                                     [tag.rectHeight floatValue] * r.size.height);
        
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
    for (Tag *tag in tags)
    {
        // Scaled image
        CGRect r = [ self frameForImage: self.image.image inImageViewAspectFit: self.image];
        
        // Scaled tag
        CGRect rect = CGRectMake (
                                  r.origin.x + [tag.rectTopLeftX floatValue] * r.size.width,
                                  r.origin.y + [tag.rectTopLeftY floatValue] * r.size.height,
                                  [tag.rectWidth floatValue] * r.size.width,
                                  [tag.rectHeight floatValue] * r.size.height);

        if (point.x >= rect.origin.x &&
            point.x <= rect.origin.x + rect.size.width &&
            point.y >= rect.origin.y &&
            point.y <= rect.origin.y + rect.size.height)
        {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            [self.screenView setSelectedTagIndex: [NSNumber numberWithInt: i]];
            [self.screenView setNeedsDisplay];
            [self.tagsTable selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
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
    
    for (Tag *tag in tags)
    {
        // Scaled image
        CGRect r = [ self frameForImage: self.image.image inImageViewAspectFit: self.image];
        
        // Scaled tag
        CGRect rect = CGRectMake (
                                  r.origin.x + [tag.rectTopLeftX floatValue] * r.size.width,
                                  r.origin.y + [tag.rectTopLeftY floatValue] * r.size.height,
                                  [tag.rectWidth floatValue] * r.size.width,
                                  [tag.rectHeight floatValue] * r.size.height);
        
        
        if (point.x >= rect.origin.x &&
            point.x <= rect.origin.x + rect.size.width &&
            point.y >= rect.origin.y &&
            point.y <= rect.origin.y + rect.size.height && !alreadySelected)
        {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection: 0];//should also highlight box here (need to force redraw)
            [self.screenView setSelectedTagIndex: [NSNumber numberWithInt: i]];
            [self.screenView setNeedsDisplay];
            [self.tagsTable selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
            alreadySelected = true; // prevent overlapping tags fighting for selection (need a better solution)
        }
        // If was previously selected, deselect
        else if ([self.tagsTable indexPathForSelectedRow].row == i)
        {
            [self.screenView setSelectedTagIndex: [NSNumber numberWithInt: -1]];
            [self.screenView setNeedsDisplay];
            [self.tagsTable deselectRowAtIndexPath:[self.tagsTable indexPathForSelectedRow] animated:YES ];
        }
        i++;
    }
  
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event]; //otherwise have to stub other touch events
    
    UITouch *touch = [touches anyObject];
    
    NSLog(@"Touch: %f %f", [touch locationInView: self.image].x, [touch locationInView: self.image].y);
    CGPoint point = [touch locationInView: self.image];
    NSUInteger i = 0;
    
    for (Tag *tag in tags)
    {
        //NSLog(@"TAG %f %f %f %f IMG %f %f", [tag.rectTopLeftX floatValue], [tag.rectTopLeftY floatValue], [tag.rectWidth floatValue], [tag.rectHeight floatValue], self.image.image.size.width, self.image.image.size.height);
        
        // Scaled image
        CGRect r = [ self frameForImage: self.image.image inImageViewAspectFit: self.image];
        
        // Scaled tag
        CGRect rect = CGRectMake (
            r.origin.x + [tag.rectTopLeftX floatValue] * r.size.width,
            r.origin.y + [tag.rectTopLeftY floatValue] * r.size.height,
            [tag.rectWidth floatValue] * r.size.width,
            [tag.rectHeight floatValue] * r.size.height);
        //NSLog(@"tag %f %f %f %f", rect.origin.x, rect.origin.x + rect.size.width, rect.origin.y, rect.origin.y + rect.size.height);
        //***need to test with proper data
        if (point.x >= rect.origin.x &&
            point.x <= rect.origin.x + rect.size.width &&
            point.y >= rect.origin.y &&
            point.y <= rect.origin.y + rect.size.height)
        {
            //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            //[self.tagsTable selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
            [self performSegueWithIdentifier:@"ShowTag" sender:nil];
            return;
        }
        i++;
    }
}

// E.g. a system event cancels, like low memory/battery
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event]; //otherwise have to stub other touch events (done now so perhaps remove?)
    [self.screenView setSelectedTagIndex: [NSNumber numberWithInt: -1]];
    [self.screenView setNeedsDisplay];
    [self.tagsTable deselectRowAtIndexPath:[self.tagsTable indexPathForSelectedRow] animated:NO ];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tags count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Tag";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Set up the cell...
    Tag *tag = [tags objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", tag.desc];
    
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
    [self performSegueWithIdentifier:@"ShowTag" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ShowTag"])
    {
        MovobiTagViewController *tagViewController = [segue destinationViewController];
        tagViewController.tag = [tags objectAtIndex:[self.tagsTable indexPathForSelectedRow].row];
    }
}

@end
