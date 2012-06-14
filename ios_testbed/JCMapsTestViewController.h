//
//  JCMapsTestViewController.h
//  ios_testbed
//
//  Created by Johnny Chan on 6/13/12.
//  Copyright (c) 2012 Johnny Chan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface JCMapsTestViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate>
{
    __weak IBOutlet MKMapView *mapView;
    CLLocationManager *locationManager;
    
}

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end
