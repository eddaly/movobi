//
//  MovobiImageTransformer.m
//  movobi
//
//  Created by Ed Daly on 30/03/2013.
//  Copyright (c) 2013 Movobi Ltd. All rights reserved.
//

#import "MovobiImageTransformer.h"

@implementation MovobiImageTransformer


+ (BOOL)allowsReverseTransformation
{
    return YES;
}

+ (Class)transformedValueClass
{
    return [NSData class];
}

- (id)transformedValue:(id)value
{
    NSData *data = UIImagePNGRepresentation(value);
	return data;
}

- (id)reverseTransformedValue:(id)value
{
	UIImage *uiImage = [[UIImage alloc] initWithData:value];
	return uiImage;
}

@end
