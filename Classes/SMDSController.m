//
//  SMDSController.m
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

#import "SMDSController.h"
#import "SMDSMonitor.h"

@interface SMDSController ()
- (void)updateDetected:(NSNotification *)notification;
@end

@implementation SMDSController

@synthesize displays;

- (id)init {
	self = [super init];
	if (self) {
		self.displays = [self update];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateDetected:) name:NSApplicationDidChangeScreenParametersNotification object:nil];
	}
	return self;
}

- (void)updateDetected:(NSNotification *)notification {
	self.displays = [self update];
}

- (NSArray *)update {
	NSMutableArray *current_displays = [[[NSMutableArray alloc] init] autorelease];
	for (NSScreen *screen in [NSScreen screens]) {
		SMDSMonitor *monitor = [[[SMDSMonitor alloc] initWithScreen:screen] autorelease];
		[current_displays addObject:monitor];
	}
	return current_displays;
}

@end
