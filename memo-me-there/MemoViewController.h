//
//  MemoViewController.h
//  memo-me-there
//
//  Created by Eric Mentele on 2/4/15.
//  Copyright (c) 2015 Eric Mentele. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MemoViewController : UIViewController

//These hold the values from mapVC that have been passed in prepare for segue.
@property (strong,nonatomic) MKPointAnnotation *annotation;
@property (strong,nonatomic) CLLocationManager *locationManager;

@end
