//
//  SMDSScreenControl.h
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

#import <Cocoa/Cocoa.h>
#import "SMDSDisplaySelect.h"

@interface SMDSScreenControl : NSControl {
	SMDSDisplaySelect *displayHighlight;
	CGSize delta;
	CGRect global;
	BOOL canConfigure;
	BOOL canEmptySelect;
	BOOL shouldRetainSelection;
}
@property (nonatomic, readonly) SMDSDisplaySelect *displayHighlight;
@property (nonatomic, readonly) CGSize delta;
@property (nonatomic, readonly) CGRect global;
@property (nonatomic, assign) BOOL canConfigure;
@property (nonatomic, assign) BOOL canEmptySelect;
@property (nonatomic, assign) BOOL shouldRetainSelection;

- (void)setHightlight:(BOOL)toggle onDisplay:(NSUInteger)displayid;
- (void)setDisplayViews:(NSArray *)displays;
- (void)mouseDown:(NSEvent *)theEvent;
- (void)mouseUp:(NSEvent *)theEvent;
- (BOOL)willDisplay:(id)dragged_display collide:(CGRect)display_rect;
- (BOOL)snap:(CGRect)view toBounds:(NSArray *)array;
- (NSArray *)viewSnap:(id)colliding_view;
- (CGPoint)getDeltaFromMain:(id)view;
- (void)translateDisplay:(NSUInteger)displayid toOffset:(CGPoint)offset;

@end