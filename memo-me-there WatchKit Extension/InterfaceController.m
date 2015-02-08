//
//  InterfaceController.m
//  memo-me-there WatchKit Extension
//
//  Created by Eric Mentele on 2/5/15.
//  Copyright (c) 2015 Eric Mentele. All rights reserved.
//Got help from Rodrigo with watch map display code.

#import "InterfaceController.h"
#import "MemoWatchRowController.h"
#import <CoreLocation/CoreLocation.h>

@interface InterfaceController()

@property (weak, nonatomic) IBOutlet WKInterfaceTable *watchTable;
@property (strong, nonatomic) NSArray *regionsArray;
@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
  
  
  CLLocationManager *locationManager = [CLLocationManager new];
  NSSet *regions = locationManager.monitoredRegions;
  self.regionsArray = regions.allObjects;
  
  [self.watchTable setNumberOfRows:self.regionsArray.count withRowType:@"watchRow"];

  NSInteger index = 0;
  for (CLCircularRegion *region in self.regionsArray) {
    
    MemoWatchRowController *rowController = [self.watchTable rowControllerAtIndex:index];
    [rowController.memoLabel setText:region.identifier];
    
    index++;
  }//for CL Circular Region
}//awakeWithContext


-(id)contextForSegueWithIdentifier:(NSString *)segueIdentifier inTable:(WKInterfaceTable *)table rowIndex:(NSInteger)rowIndex {
  
  return self.regionsArray[rowIndex];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
  [self.watchTable setNumberOfRows:self.regionsArray.count withRowType:@"watchRow"];
  
}

@end



