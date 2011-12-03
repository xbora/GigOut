//
//  LocationManager.m
//  UberLife
//
//  Created by Richard on 05/08/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LocationManager.h"
#import "Singleton.h"

@interface LocationManager (Private)

-(void)reset;

@end

@implementation LocationManager

SYNTHESIZE_SINGLETON_FOR_CLASS(LocationManager);

@synthesize latitude;
@synthesize longitude;
@synthesize m_tinyURL;

-(id)init {
	self = [super init];
    if (self) {
		m_locationManager = nil;
        m_locationDenied = NO;
        [self reset];
	}
    return self;
}

-(BOOL)locationDenied {
	return m_locationDenied;
}

-(BOOL) locationDefined {
	return m_locationDefined;
}

-(float)latitude {
	return m_latitude;
}

-(float)longitude {
	return m_longitude;
}

-(CLLocation*)currentLocation {
    return m_currentLocation;
}


-(BOOL) locationServicesEnabled {
    return [CLLocationManager locationServicesEnabled];
}

-(void)stopUpdates {
	if (m_locationManager) {
		[m_locationManager stopUpdatingLocation];
	}
	[self reset];
}


- (void) startUpdates {
	if (m_locationManager) {
		[m_locationManager stopUpdatingLocation];
        [m_locationManager startUpdatingLocation];
	} else {
		m_locationManager = [[CLLocationManager alloc] init];
		m_locationManager.delegate = self;
		m_locationManager.distanceFilter = 100;
		m_locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        m_locationManager.purpose = @"This is so we can find the nearest hangouts to you.";
	}
	
	m_locationDefined = NO;
    m_numberOfTries = 0;
    
    
#if TARGET_IPHONE_SIMULATOR
    /* replace with a test instance */
   [self performSelector:@selector(hackLocationFix) withObject:nil afterDelay:0.1];
#else
    [m_locationManager startUpdatingLocation];
#endif

}

-(void)hackLocationFix {
    //51.49710, -0.08220
    CLLocation *location = [[CLLocation alloc] initWithLatitude:51.49710 longitude:-0.08220];
    [self  locationManager:m_locationManager didUpdateToLocation:location fromLocation:nil];         
    [location release];
}

- (NSString*)urlFormat {
     NSString* urlString = @"http://maps.googleapis.com/maps/api/staticmap?"
        @"center=%f,%f&zoom=10&size=640x170&scale=2&sensor=true";
    return urlString;
}


-(NSString*)longURLWithLatitude:(float)lat longitude:(float)lon {
	return [NSString stringWithFormat:[self urlFormat], lat, lon];
}

-(NSString*)mapURL {
    if(!m_locationDefined)  {
		return nil;
    }
    
	return [self longURLWithLatitude:m_latitude longitude:m_longitude];
}

#pragma mark -
#pragma mark LocationManager (Private)

-(void)reset {
	m_locationDefined = NO;
	m_latitude = 0.f;
	m_longitude = 0.f;
}

#pragma mark -
#pragma mark CLLocationManagerDelegate

-(void)locationManager:(CLLocationManager *)manager
   didUpdateToLocation:(CLLocation *)newLocation
          fromLocation:(CLLocation *)oldLocation {
	m_locationDefined = NO;
    
    NSDate* eventDate = newLocation.timestamp;
    NSTimeInterval howRecent = abs([eventDate timeIntervalSinceNow]);
   
    
    if((newLocation.coordinate.latitude != oldLocation.coordinate.latitude) &&
       (newLocation.coordinate.longitude != oldLocation.coordinate.longitude)) {
        m_locationChanged = YES;
    } else {
        m_locationChanged = NO;
    }
    if (howRecent > 5.0) return;
    
    m_numberOfTries++;
    
    if (newLocation.horizontalAccuracy < 0) return;

    m_latitude = newLocation.coordinate.latitude;
    m_longitude = newLocation.coordinate.longitude;
    
    m_locationDefined = YES;
            
    [m_currentLocation release];
            
    m_currentLocation = [newLocation retain];

    if (oldLocation != nil)  {
        m_distanceMoved = [newLocation distanceFromLocation:oldLocation];
        m_currentSpeed = newLocation.speed;
        m_timeDelta = [newLocation.timestamp timeIntervalSinceDate:oldLocation.timestamp];
    }
    
    if(newLocation.horizontalAccuracy < 100 || m_numberOfTries > 5) {
        [m_locationManager stopUpdatingLocation];
    }

}

-(void)locationManager:(CLLocationManager *)manager
      didFailWithError:(NSError *)error {
	[self reset];
    
    if ([error domain] == kCLErrorDomain) {
        switch ([error code])  {
            case kCLErrorDenied:
				m_locationDenied = YES;
				[self stopUpdates];
                break;
            case kCLErrorLocationUnknown:
                break;
            default:
                break;
        }
	}
}

@end
