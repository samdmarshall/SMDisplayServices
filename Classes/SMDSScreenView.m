//
//  SMDSScreenView.m
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

#import "SMDSScreenView.h"
#import "SMDSConstants.h"

@implementation SMDSScreenView

@synthesize isMain;
@synthesize isSelected;
@synthesize displayid;

- (id)initWithFrame:(CGRect)rect withID:(NSUInteger)did {
	self = [super initWithFrame:rect];
	if (self) {
		isSelected = NO;
		displayid = did;
		isMain = (displayid == CGMainDisplayID());
	}
	return self;
}

- (void)drawRect:(NSRect)dirtyRect {
	[super drawRect:dirtyRect];
	CGRect rect = CGRectMake(dirtyRect.origin.x, dirtyRect.origin.y, dirtyRect.size.width, dirtyRect.size.height);

	CGContextRef context = [[NSGraphicsContext currentContext] graphicsPort];
	
	CGContextSetLineWidth(context, 1.5);
	CGContextSetRGBFillColor(context, 0.329411765, 0.545098039, 0.807843137, 1.0);
	CGContextFillRect(context, rect);
	CGContextSetRGBStrokeColor(context, 0, 0, 0, 1.0);
	CGContextStrokeRect(context, rect);
	
	if (isSelected) {
		CGContextSetLineWidth(context, kSelectionHighlightBorderMini);
		CGContextSetRGBStrokeColor(context, 1, 0, 0, 1.0);
		CGRect select_rect = CGRectMake(rect.origin.x+kSelectionHighlightBorderMini, rect.origin.y+kSelectionHighlightBorderMini, rect.size.width-(2*kSelectionHighlightBorderMini), rect.size.height-(2*kSelectionHighlightBorderMini));
		CGContextStrokeRect(context, select_rect);
	}
	
	if (isMain) {
		CGContextSetLineWidth(context, 1.5);
		CGRect menu_bar = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, kMainDisplayMenubarHeight);	
		CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
		CGContextSetRGBStrokeColor(context, 0.0, 0.0, 0.0, 1.0);
		CGContextFillRect(context, menu_bar);
		CGContextStrokeRect(context, menu_bar);
	}
}

- (BOOL)isFlipped {
	return YES;
}

@end