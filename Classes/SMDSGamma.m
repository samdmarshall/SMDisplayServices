//
//  SMDSGamma.m
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

#import "SMDSGamma.h"
#import "SMDSMaths.h"

@implementation SMDSGamma

@synthesize dID;

@synthesize redMin;
@synthesize redMax;
@synthesize redGamma;
            
@synthesize greenMin;
@synthesize greenMax;
@synthesize greenGamma;
            
@synthesize blueMin;
@synthesize blueMax;
@synthesize blueGamma;

- (id)initWithDisplayID:(NSUInteger)_id {
	self = [super init];
	if (self) {
		dID = _id;
		CGGetDisplayTransferByFormula(dID, &redMin, &redMax, &redGamma, &greenMin, &greenMax, &greenGamma, &blueMin,  &blueMax, &blueGamma);	
	}
	return self;
}

- (BOOL)isSame {
	float min[] = { redMin, greenMin, blueMin };
	float max[] = { redMax, greenMax, blueMax };
	float gamma[] = { redGamma, greenGamma, blueGamma };
	
	uint32_t table_count = CGDisplayGammaTableCapacity(dID);
	uint32_t sample_count;
	
	float *display_color[3] = { (float *)malloc(sizeof(float[table_count])), 
								(float *)malloc(sizeof(float[table_count])), 
								(float *)malloc(sizeof(float[table_count])) };
	
	float *colors[3] = { (float *)malloc(sizeof(float[table_count])), 
						 (float *)malloc(sizeof(float[table_count])),
						 (float *)malloc(sizeof(float[table_count])) };
	
	CGGetDisplayTransferByTable(dID, table_count, display_color[0], display_color[1], display_color[2], &sample_count);			
	
	BOOL color_ok[3] = { YES, YES, YES };
	
	for (NSUInteger c = 0; c < 3; c++) {
		for (NSUInteger i = 0; i < table_count; i++) {
			colors[c][i] = (min[c] + ((max[c] - min[c]) * pow((float)i, gamma[c])))/(float)(table_count - 1);
			color_ok[c] = FloatEqual(colors[c][i], display_color[c][i]);
		}
	}
		
	for (NSUInteger i = 0; i < 3; i++) {
		free(display_color[i]);
		free(colors[i]);
	}
	
	return (color_ok[0] && color_ok[1] && color_ok[2]);
}

- (void)update {
	if (![self isSame]) 
		CGSetDisplayTransferByFormula(dID, redMin, redMax, redGamma, greenMin, greenMax, greenGamma, blueMin, blueMax, blueGamma);
}

@end
