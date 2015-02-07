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
#import "MemoViewController.h"

@interface MapViewController () <MKMapViewDelegate, CLLocationManagerDelegate>

@property (strong,nonatomic) CLLocationManager *locationManager;
@property (strong,nonatomic)  MKPointAnnotation * selectedAnnotation;

@property (nonatomic, retain) IBOutlet MKMapView *mapView;
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
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(memoAdded:) name:@"memoAdded" object: nil];
  
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
//- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
//
//  CLLocationCoordinate2D loc = [userLocation coordinate];
//  MKCoordinateRegion mregion = MKCoordinateRegionMakeWithDistance(loc, 500, 500);
//  self.mapView.region = mregion;
//}//didUpdateUserLocation


//MARK: GESTURE RECOGNIZER
-(void)mapLongPressed:(id)sender {
  
  UILongPressGestureRecognizer *longPress = (UILongPressGestureRecognizer*)sender;
  
  if (longPress.state == 3) {
    
    NSLog(@"Long press worked!");
    CGPoint location = [longPress locationInView:self.mapView];
    CLLocationCoordinate2D coordinates = [self.mapView convertPoint: location toCoordinateFromView:self.mapView];
    //day 3 homework will modify code here.
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    annotation.coordinate = coordinates;
    annotation.title = @"New Location";
    [self.mapView addAnnotation:annotation];
  }//if press 3
}//map long pressed


//MARK: Location store
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
  
  CLLocation *location = locations.firstObject;
}//did update locations


//Set up annotaion for location.
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
  
  MKPinAnnotationView *annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"AnnotationView"];
  annotationView.animatesDrop = true;
  annotationView.pinColor = MKPinAnnotationColorGreen;
  annotationView.canShowCallout = true;
  annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeContactAdd];
  
  return annotationView;
}//Annotaion view


//Fire segue when annotation pressed
-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
  
  self.selectedAnnotation = view.annotation;
  //MKPointAnnotation *annotation = view.annotation;
  
  [self performSegueWithIdentifier:@"locationDetail" sender:self];
  
  NSLog(@"ANNOTATION INTERACTON!");
}//annotaion view call


-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
  
  UILocalNotification *localNotification = [[UILocalNotification alloc] init];
  localNotification.alertBody = @"region entered!";
  localNotification.alertAction = @"region action";
  
  [[UIApplication sharedApplication] presentLocalNotificationNow:localNotification];
  [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}//location manager


//Send annotaion information to detail view controller.
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  
  if ([segue.identifier isEqualToString:@"locationDetail"]) {
    
    MemoViewController *MemoVC = (MemoViewController *)segue.destinationViewController;
    MemoVC.annotation = self.selectedAnnotation;
    MemoVC.locationManager = self.locationManager;
  }
  
}


-(void) memoAdded:(NSNotification *)notification {
  
  NSDictionary *userInfo = notification.userInfo;
  CLCircularRegion *region = userInfo[@"memo"];
  NSLog(@"MEMO ADDED!!!!!!");
  MKCircle *circleOverlay = [MKCircle circleWithCenterCoordinate:region.center radius:region.radius];
  
  [self.mapView addOverlay:circleOverlay];
}//memoAdded


-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
  
  MKCircleRenderer *circleRenderer = [[MKCircleRenderer alloc] initWithOverlay:overlay];
  circleRenderer.fillColor = [UIColor blueColor];
  circleRenderer.strokeColor = [UIColor redColor];
  circleRenderer.alpha = 0.5;
  return circleRenderer;
}//Overlay renderer


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


- (IBAction)userLocButton:(id)sender {
  
  CLLocationCoordinate2D startCoord = CLLocationCoordinate2DMake(self.mapView.userLocation.coordinate.latitude,self.mapView.userLocation.coordinate.longitude);
  
  MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:MKCoordinateRegionMakeWithDistance(startCoord, 200, 200)];
  [self.mapView setRegion:adjustedRegion animated:YES];
  self.mapView.mapType = MKMapTypeSatellite;
}


-(void)dealloc {
  
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
