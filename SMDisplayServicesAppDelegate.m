//
//  SMDisplayServicesAppDelegate.m
//  SMDisplayServices
//
//  Created by Sam Marshall on 3/31/12.
//  Copyright 2012 Sam Marshall. All rights reserved.
//

#import "SMDisplayServicesAppDelegate.h"
#import "SMDSController.h"

@implementation SMDisplayServicesAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	// Insert code here to initialize your application 
	SMDSController *controller = [[SMDSController alloc] init];
	[[window contentView] addSubview:[controller displayview]];
}

@end
