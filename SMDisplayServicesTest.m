//
//  SMDisplayServicesTest.m
//
//  Created by Sam Marshall on 4/12/12.
//  Copyright 2012 Sam Marshall. All rights reserved.
//

#import "SMDisplayServicesTest.h"
#import "SMDisplayServices/SMDSMonitor.h"

@implementation SMDisplayServicesTest

@synthesize controller;
@synthesize displayButton;

- (void)awakeFromNib {
	controller = [[SMDSController alloc] initWithFrame:CGRectMake(0,100,750,450)];
	[controller setRetainSelection:YES];
	[[window contentView] addSubview:controller.displayview];
	[controller renderDisplays];
}

- (IBAction)getDisplay:(id)sender {
	SMDSMonitor *display = [controller selectedDisplay];
	NSLog(@"ID: %lu",display.displayid);
	NSLog(@"Name: %@",display.name);
	NSLog(@"Frame: %f %f %f %f",display.frame.origin.x,display.frame.origin.y,display.frame.size.width,display.frame.size.height);
	NSLog(@"Bounds: %f %f %f %f",display.bounds.origin.x,display.bounds.origin.y,display.bounds.size.width,display.bounds.size.height);
	NSLog(@"Main Display: %@", display.isMain ? @"Yes" : @"No");
	
}
@end
