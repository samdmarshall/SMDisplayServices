//
//  SMDSScreenControl.m
//  SMDisplayServices
//
//  Created by Sam Marshall on 3/31/12.
//  Copyright 2012 Sam Marshall. All rights reserved.
//

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

#import "SMDSScreenControl.h"
#import "SMDSMonitor.h"
#import "SMDSScreenView.h"

@implementation SMDSScreenControl

@synthesize displayHighlight;
@synthesize delta;
@synthesize global;

- (id)initWithFrame:(NSRect)rect {
	self = [super initWithFrame:rect];
	if (self) {
		displayHighlight = [[SMDSDisplaySelect alloc] initWithContentRect:CGRectMake(0,0,0,0) styleMask:NSBorderlessWindowMask backing:NSBackingStoreRetained defer:NO];
		[displayHighlight setLevel:NSTornOffMenuWindowLevel];
	}
	return self;
}

- (BOOL)isFlipped {
	return YES;
}

- (void)setDisplayViews:(NSArray *)displays {
	[[self subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
	delta = GetDelta(displays);
	global = GetGlobalDisplaySpace(displays);
	for (SMDSMonitor *screen in displays) {
		SMDSScreenView *a_screen = [[[SMDSScreenView alloc] initWithFrame:ReduceFrameWithDelta(screen.bounds, delta) withID:screen.displayid] autorelease];
		[self addSubview:a_screen];
	}
	[self setNeedsDisplay:YES];
}

- (void)setHightlight:(BOOL)toggle onDisplay:(NSUInteger)displayid {
	if (toggle) {
		CGRect bounds = GetDisplayRectForDisplayInSpace(displayid,global);		
		[displayHighlight setFrame:bounds display:YES];
		[displayHighlight orderFrontRegardless];
	} else {
		[displayHighlight orderOut:self];
		[displayHighlight setFrame:CGRectMake(0,0,0,0) display:YES];
	}
}

- (void)mouseDown:(NSEvent *)theEvent {
	NSPoint vloc = [self convertPoint:[theEvent locationInWindow] fromView:[self superview]];
	for (SMDSScreenView *view in [self subviews]) {
		view.isSelected = [view mouse:vloc inRect:view.frame];
		if (view.isSelected) {
			[self setHightlight:YES onDisplay:[view displayid]];
		}
	}
	[self setNeedsDisplay:YES];
}

- (void)mouseUp:(NSEvent *)theEvent {
	[self setHightlight:NO onDisplay:0];
}

- (BOOL)willDisplay:(SMDSScreenView *)dragged_display collide:(CGRect)display_rect {
	BOOL status = NO;
	
	for (SMDSScreenView *view in [self subviews]) {
		if (view != dragged_display) {
			status = CGRectIntersectsRect(view.frame, display_rect);
			if (status) break;
		}
	}
	return status;
}

- (NSArray *)viewSnap:(SMDSScreenView *)colliding_view {
	NSMutableArray *array = [[[NSMutableArray alloc] init] autorelease];	
	for (SMDSScreenView *view in [self subviews]) {
		if (view != colliding_view) {
			CGRect draggable = CGRectMake(view.frame.origin.x-colliding_view.frame.size.width, view.frame.origin.y-colliding_view.frame.size.height, (2.0*colliding_view.frame.size.width)+view.frame.size.width+0.5, (2.0*colliding_view.frame.size.height)+view.frame.size.height+0.5);		
			[array addObject:[NSValue valueWithRect:draggable]];
		}
	}
	return array;
}

- (BOOL)snap:(CGRect)view toBounds:(NSArray *)array {
	BOOL status = YES;
	for (NSValue *val in array) {		
		status = CGRectContainsRect([val rectValue], view);
		if (!status) break;
	}
	return status;
}

- (CGPoint)getDeltaFromMain:(SMDSScreenView *)view {
	CGFloat x = 0.f, y = 0.f;
	for (SMDSScreenView *screen in [self subviews]) {
		if (screen.isMain) {
			if (screen != view) {
				x = (screen.frame.origin.x + view.frame.origin.x)/kDefaultDisplayScale;
				y = (screen.frame.origin.y + view.frame.origin.y)/kDefaultDisplayScale;
			}
		}
	}
	return CGPointMake(x, y);
}

- (void)dealloc {
	[displayHighlight release];
	[super dealloc];
}

@end