//
//  MemoViewController.m
//  memo-me-there
//
//  Created by Eric Mentele on 2/4/15.
//  Copyright (c) 2015 Eric Mentele. All rights reserved.
//

#import "MemoViewController.h"

@interface MemoViewController ()

@end

@implementation MemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  NSLog(@" long: %f lat: %f", self.annotation.coordinate.longitude, self.annotation.coordinate.latitude);
}//view did load


- (IBAction)addMemoButtonPressed:(id)sender {

  if ([CLLocationManager isMonitoringAvailableForClass:[CLCircularRegion class]]) {
    
    CLCircularRegion *region = [[CLCircularRegion alloc] initWithCenter:self.annotation.coordinate radius:500 identifier:@"Reminder"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"memoAdded" object:self userInfo:@{@"memo" : region}]; 
  }//if CL Location Manager
  
}//add memo button pressed

@end
