//
//  MapViewController.m
//  memo-me-there
//
//  Created by Eric Mentele on 2/2/15.
//  Copyright (c) 2015 Eric Mentele. All rights reserved.
//--------------------------------Self in a block is a retain cycle unless you declare a weak self. -----------------------------------

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MapViewController () <MKMapViewDelegate, CLLocationManagerDelegate>


@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) CLLocationManager *locationManager;

@property (weak, nonatomic) IBOutlet UIButton *craterLocButton;
@property (weak, nonatomic) IBOutlet UIButton *spacePortLocButton;
@property (weak, nonatomic) IBOutlet UIButton *darpaLocButton;


- (IBAction)craterGo:(id)sender;
- (IBAction)spacePortGo:(id)sender;
- (IBAction)darpaGo:(id)sender;

@end


@implementation MapViewController

- (void)viewDidLoad {
  
  [super viewDidLoad];
  self.locationManager = [[CLLocationManager alloc] init];
  self.locationManager.delegate = self;
  self.mapView.delegate = self;
  
  if ([CLLocationManager locationServicesEnabled]) {
    NSLog(@"location services enabled");
    if ([CLLocationManager authorizationStatus] == 0) {
      
      [self.locationManager requestAlwaysAuthorization];
    } else {
      
      self.mapView.showsUserLocation = YES;
      [self.locationManager startMonitoringSignificantLocationChanges];
    }//else1
  } else {
    
    UIAlertView *locationAlert = [[UIAlertView alloc] initWithTitle:@"Location Error" message:@"Location: services are not turned on." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [locationAlert show];
  }//if location services enabled
  
  UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(mapLongPressed:)];
  [self.mapView addGestureRecognizer:longPress];
}//viewDidLoad


//Start map center on user location.
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
  
  CLLocationCoordinate2D loc = [userLocation coordinate];
  MKCoordinateRegion mregion = MKCoordinateRegionMakeWithDistance(loc, 500, 500);
  self.mapView.region = mregion;
}


//MARK: GESTURE RECOGNIZER
-(void)mapLongPressed:(id)sender {
  
  UILongPressGestureRecognizer *longPress = (UILongPressGestureRecognizer*)sender;
  
  if (longPress.state == 3) {
    
    NSLog(@"Long press worked!");
    CGPoint location = [longPress locationInView:self.mapView];
    CLLocationCoordinate2D coordinates = [self.mapView convertPoint: location toCoordinateFromView:self.mapView];
    
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    annotation.coordinate = coordinates;
    annotation.title = @"New Location";
    [self.mapView addAnnotation:annotation];
  }//if press 3
}//map long pressed


//MARK: BUTTONS
-(void)craterGo:(id)sender{
  
  CLLocationCoordinate2D startCoord = CLLocationCoordinate2DMake(35.027185, -111.022388);
  MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:MKCoordinateRegionMakeWithDistance(startCoord, 1500, 1500)];
  [self.mapView setRegion:adjustedRegion animated:YES];
  self.mapView.mapType = MKMapTypeSatellite;
}

- (IBAction)spacePortGo:(id)sender {
  
  CLLocationCoordinate2D startCoord = CLLocationCoordinate2DMake(32.9869371, -106.9720099);
  MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:MKCoordinateRegionMakeWithDistance(startCoord, 2000, 2000)];
  [self.mapView setRegion:adjustedRegion animated:YES];
  self.mapView.mapType = MKMapTypeSatellite;
}

- (IBAction)darpaGo:(id)sender {
  
  CLLocationCoordinate2D startCoord = CLLocationCoordinate2DMake(38.878746,-77.108711);
  MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:MKCoordinateRegionMakeWithDistance(startCoord, 200, 200)];
  [self.mapView setRegion:adjustedRegion animated:YES];
  self.mapView.mapType = MKMapTypeSatellite;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
