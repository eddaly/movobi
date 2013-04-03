//
//  MovobiScreenView.m
//  movobi
//
//  Created by Ed Daly on 31/03/2013.
//  Copyright (c) 2013 Movobi Ltd. All rights reserved.
//

#import "MovobiScreenView.h"
#import "MovobiScreenViewController.h"

@implementation MovobiScreenView

@synthesize tagRects;
@synthesize selectedTagIndex;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        selectedTagIndex = [NSNumber numberWithInt:-1]; //i.e. take to mean no selected tag
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super initWithCoder:decoder];
    if (self) {
        // Initialization code
        selectedTagIndex = [NSNumber numberWithInt:-1]; //i.e. take to mean no selected tag
    }
    return self;
}

- (void)drawTagArea:(CGRect) rect  withHighlight: (BOOL) highlighted
{
    UIColor* colour;
    CGBlendMode blendMode;
    if (highlighted)
    {
        blendMode = kCGBlendModePlusLighter;
        colour = [UIColor whiteColor];
    }
    else
    {
        blendMode = kCGBlendModeNormal;
        colour = [UIColor blackColor];
    }
    UIBezierPath* boxPath = [UIBezierPath bezierPathWithRoundedRect: rect cornerRadius: 4];
    [colour setFill];
    [boxPath fillWithBlendMode:blendMode alpha:0.25f];
}

- (void)drawRect:(CGRect)rect //***think drawing before / under the image
{    
    int i = 0;
    CGRect selectedRect;
    for (NSValue *rectObj in tagRects)
    {
        CGRect rect = [rectObj CGRectValue];
        if (selectedTagIndex.intValue != i)
            [self drawTagArea: rect withHighlight: NO];
        else
            selectedRect = rect;
        i++;
    }
    if (selectedTagIndex.intValue != -1) //draw highlighted tag last in case under others
        [self drawTagArea: selectedRect withHighlight: YES];
}

@end
