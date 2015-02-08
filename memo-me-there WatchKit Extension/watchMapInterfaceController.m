//
//  watchMapInterfaceController.m
//  memo-me-there
//
//  Created by Eric Mentele on 2/6/15.
//  Copyright (c) 2015 Eric Mentele. All rights reserved.
//

#import "watchMapInterfaceController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h> 


@interface watchMapInterfaceController()

@end


@implementation watchMapInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
  self.region = context;
  
  MKCoordinateRegion region = MKCoordinateRegionMake(self.region.center,MKCoordinateSpanMake(0.8, 0.8));
  [self.watchMap setRegion:region];
  }

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
  
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



