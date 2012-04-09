/*
 *  SMDSDisplayCalculations.h
 *  SMDisplayServices
 *
 *  Created by Sam Marshall on 4/4/12.
 *  Copyright 2012 Sam Marshall. All rights reserved.
 *
 */

/*
Copyright (c) 2010-2012, Sam Marshall
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
3. All advertising materials mentioning features or use of this software must display the following acknowledgement:
This product includes software developed by the Sam Marshall.
4. Neither the name of the Sam Marshall nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY Sam Marshall ''AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL Sam Marshall BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

#import "SMDSConstants.h"

static inline CGRect ReduceFrameWithDelta(CGRect rect, CGSize size) {
	return CGRectMake(roundf((rect.origin.x+fabs(size.width))*kDefaultDisplayScale), roundf((rect.origin.y+fabs(size.height))*kDefaultDisplayScale), roundf(rect.size.width*kDefaultDisplayScale), roundf(rect.size.height*kDefaultDisplayScale));
}

static inline UInt32 IndexOfTopMostDisplay(NSArray *displays) {
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

static inline UInt32 IndexOfBottomMostDisplay(NSArray *displays) {
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

static inline UInt32 IndexOfLeftMostDisplay(NSArray *displays) {
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

static inline UInt32 IndexOfRightMostDisplay(NSArray *displays) {
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

static inline CGSize GetDelta(NSArray *displays) {
	UInt32 left_index = IndexOfLeftMostDisplay(displays);
	UInt32 top_index = IndexOfTopMostDisplay(displays);
	return CGSizeMake([[displays objectAtIndex:left_index] bounds].origin.x, [[displays objectAtIndex:top_index] bounds].origin.y);
}

static inline CGRect GetGlobalDisplaySpace(NSArray *displays) {
	UInt32 left_index = IndexOfLeftMostDisplay(displays);
	UInt32 top_index = IndexOfTopMostDisplay(displays);
	UInt32 bottom_index = IndexOfBottomMostDisplay(displays);
	UInt32 right_index = IndexOfRightMostDisplay(displays);
	CGFloat width = fabs([[displays objectAtIndex:right_index] bounds].origin.x+[[displays objectAtIndex:right_index] bounds].size.width)+fabs([[displays objectAtIndex:left_index] bounds].origin.x);
	CGFloat height = fabs([[displays objectAtIndex:bottom_index] bounds].origin.y+[[displays objectAtIndex:bottom_index] bounds].size.height)+fabs([[displays objectAtIndex:top_index] bounds].origin.y);
	return CGRectMake([[displays objectAtIndex:left_index] bounds].origin.x, [[displays objectAtIndex:top_index] bounds].origin.y, width, height);
}

static inline CGRect GetDisplayRectForDisplayInSpace(NSUInteger displayid, CGRect global) {
	CGRect bounds = CGDisplayBounds(displayid);
	CGRect o_bounds = CGDisplayBounds(CGMainDisplayID());
	CGPoint new_origin = CGPointMake(o_bounds.origin.x,o_bounds.origin.y+o_bounds.size.height);
	CGRect new = CGRectMake(bounds.origin.x+new_origin.x, (new_origin.y+(o_bounds.origin.y-bounds.origin.y)-bounds.size.height), bounds.size.width, bounds.size.height);
	return new;
}