//
//  SMDisplayServicesTest.h
//
//  Created by Sam Marshall on 4/12/12.
//  Copyright 2012 Sam Marshall. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SMDisplayServices/SMDSController.h"

@interface SMDisplayServicesTest : NSObject {
    IBOutlet id window;
	IBOutlet id displayButton;
	SMDSController *controller;
}
@property (nonatomic, retain) SMDSController *controller;
@property (nonatomic, retain) IBOutlet id displayButton;
- (IBAction)getDisplay:(id)sender;
@end
