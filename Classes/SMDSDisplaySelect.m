//
//  SMDSDisplaySelect.m
//  SMDisplayServices
//
//  Created by Sam Marshall on 4/5/12.
//  Copyright 2012 Sam Marshall. All rights reserved.
//

#import "SMDSDisplaySelect.h"
#import "SMDSConstants.h"

@implementation SMDSDisplaySelect

- (id)initWithContentRect:(NSRect)contentRect styleMask:(NSUInteger)windowStyle backing:(NSBackingStoreType)bufferingType defer:(BOOL)deferCreation {
	self = [super initWithContentRect:contentRect styleMask:windowStyle backing:bufferingType defer:deferCreation];
	if (self) {
		self.backgroundColor = NSColor.clearColor;
		[self setOpaque:NO];
		self.contentView = [[[SMDSDisplaySelectBorder alloc] initWithFrame:contentRect] autorelease];
	}
	return self;
}

- (void)dealloc {
	[super dealloc];
}

@end

@implementation SMDSDisplaySelectBorder

- (void)drawRect:(NSRect)dirtyRect {
    // Drawing code here.
	CGContextRef context = [[NSGraphicsContext currentContext] graphicsPort];
	
	CGContextSetRGBFillColor(context, 1.0,0.0,0.0,0.0);
	CGContextFillRect(context, dirtyRect);
	CGContextSetLineWidth(context, kSelectionHighlightBorder);
	CGContextSetRGBStrokeColor(context, 1.0, 0, 0, 1.0);
	CGContextStrokeRect(context, dirtyRect);	
}

- (void)dealloc {
	[super dealloc];
}

@end
