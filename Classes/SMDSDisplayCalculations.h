/*
 *  SMDSDisplayCalculations.h
 *  SMDisplayServices
 *
 *  Created by Sam Marshall on 4/4/12.
 *  Copyright 2012 Sam Marshall. All rights reserved.
 *
 */

#import "SMDSConstants.h"

CGRect ReduceFrameWithDelta(CGRect rect, CGSize size) {
	return CGRectMake((rect.origin.x+fabs(size.width))*kDefaultDisplayScale, (rect.origin.y+fabs(size.height))*kDefaultDisplayScale, rect.size.width*kDefaultDisplayScale, rect.size.height*kDefaultDisplayScale);
}

UInt32 IndexOfTopMostDisplay(NSArray *displays) {
	UInt32 index = 0;
	CGFloat high = 0.f;
	for (UInt32 i = 0; i < [displays count]; i++) {
		CGFloat height = [[displays objectAtIndex:i] bounds].origin.y;
		if (high > height) {
			index = i;
			high = height;
		}
	}
	return index;
}

UInt32 IndexOfBottomMostDisplay(NSArray *displays) {
	UInt32 index = 0;
	CGFloat low = 0.f;
	for (UInt32 i = 0; i < [displays count]; i++) {
		CGFloat lower = [[displays objectAtIndex:i] bounds].origin.y+[[displays objectAtIndex:i] bounds].size.height;
		if (low < lower) {
			index = i;
			low = lower;
		}
	}
	return index;
}

UInt32 IndexOfLeftMostDisplay(NSArray *displays) {
	UInt32 index = 0;
	CGFloat wide = 0.f;
	for (UInt32 i = 0; i < [displays count]; i++) {
		CGFloat width = [[displays objectAtIndex:i] bounds].origin.x;
		if (wide > width) {
			index = i;
			wide = width;
		}
	}
	return index;
}

UInt32 IndexOfRightMostDisplay(NSArray *displays) {
	UInt32 index = 0;
	CGFloat wide_right = 0.f;
	for (UInt32 i = 0; i < [displays count]; i++) {
		CGFloat width = [[displays objectAtIndex:i] bounds].origin.x+[[displays objectAtIndex:i] bounds].size.width;
		if (wide_right < width) {
			index = i;
			wide_right = width;
		}
	}
	return index;
}

CGSize GetDelta(NSArray *displays) {
	UInt32 left_index = IndexOfLeftMostDisplay(displays);
	UInt32 top_index = IndexOfTopMostDisplay(displays);
	return CGSizeMake([[displays objectAtIndex:left_index] bounds].origin.x, [[displays objectAtIndex:top_index] bounds].origin.y);
}

CGRect GetGlobalDisplaySpace(NSArray *displays) {
	UInt32 left_index = IndexOfLeftMostDisplay(displays);
	UInt32 top_index = IndexOfTopMostDisplay(displays);
	UInt32 bottom_index = IndexOfBottomMostDisplay(displays);
	UInt32 right_index = IndexOfRightMostDisplay(displays);
	CGFloat width = fabs([[displays objectAtIndex:right_index] bounds].origin.x+[[displays objectAtIndex:right_index] bounds].size.width)+fabs([[displays objectAtIndex:left_index] bounds].origin.x);
	CGFloat height = fabs([[displays objectAtIndex:bottom_index] bounds].origin.y+[[displays objectAtIndex:bottom_index] bounds].size.height)+fabs([[displays objectAtIndex:top_index] bounds].origin.y);
	return CGRectMake([[displays objectAtIndex:left_index] bounds].origin.x, [[displays objectAtIndex:top_index] bounds].origin.y, width, height);
}

CGRect GetDisplayRectForDisplayInSpace(NSUInteger displayid, CGRect global) {
	CGRect bounds = CGDisplayBounds(displayid);
	//printf("%f %f %f %f\n",bounds.origin.x, bounds.origin.y, bounds.size.width, bounds.size.height);
	CGRect o_bounds = CGDisplayBounds(CGMainDisplayID());
	//printf("%f %f %f %f\n",o_bounds.origin.x, o_bounds.origin.y, o_bounds.size.width, o_bounds.size.height);
	CGPoint new_origin = CGPointMake(o_bounds.origin.x,o_bounds.origin.y+o_bounds.size.height);
	CGRect new = CGRectMake(bounds.origin.x+new_origin.x,(new_origin.y+(o_bounds.origin.y-bounds.origin.y)-bounds.size.height),bounds.size.width,bounds.size.height);
	//printf("%f %f %f %f\n",new.origin.x, new.origin.y, new.size.width, new.size.height);
	return new;
}