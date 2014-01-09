//
//  MBViewController.m
//  GPXTest
//
//  Created by Mitsukuni Sato on 1/8/14.
//  Copyright (c) 2014 MyBike. All rights reserved.
//

#import "MBViewController.h"

@interface MBViewController ()
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocation *lastLocation;
@end

@implementation MBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - MKMapViewDelegate
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    if (self.lastLocation) {
        CLLocationCoordinate2D coordinates[2];
        coordinates[0] = self.lastLocation.coordinate;
        coordinates[1] = userLocation.coordinate;

        MKPolyline *polyline = [MKPolyline polylineWithCoordinates:coordinates count:2];
        [self.mapView addOverlay:polyline];
    }

    self.lastLocation = [[CLLocation alloc] initWithLatitude:userLocation.coordinate.latitude
                                                   longitude:userLocation.coordinate.longitude];
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    if ([overlay isKindOfClass:[MKPolyline class]])
    {
        MKPolyline *path = (MKPolyline *) overlay;
        MKPolylineRenderer *pathRenderer = [[MKPolylineRenderer alloc] initWithPolyline:path];
        pathRenderer.lineWidth = 5.0;
        pathRenderer.strokeColor = [UIColor redColor];
        return pathRenderer;
    } else {
        return nil;
    }
}

@end
