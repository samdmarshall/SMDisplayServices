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
	return CGRectMake((rect.origin.x+size.width)*kDefaultDisplayScale, (rect.origin.y+size.height)*kDefaultDisplayScale, rect.size.width*kDefaultDisplayScale, rect.size.height*kDefaultDisplayScale);
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
		CGFloat lower = [[displays objectAtIndex:i] bounds].origin.y;
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
		CGFloat width = [[displays objectAtIndex:i] bounds].origin.x;
		if (wide_right < width) {
			index = i;
			wide_right = width;
		}
	}
	return index;
}