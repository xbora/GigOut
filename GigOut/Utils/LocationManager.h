//
//  LocationManager.h
//  UberLife
//
//  Created by Richard on 05/08/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreLocation/CoreLocation.h>

@interface LocationManager : NSObject <CLLocationManagerDelegate>
{
    CLLocationManager* m_locationManager;
	BOOL m_locationDefined;
	float m_latitude;
	float m_longitude;
    float m_currentSpeed;
	NSString* m_tinyURL;
	BOOL m_locationDenied;
    BOOL m_locationChanged;
    CLLocationDistance m_distanceMoved;
    NSTimeInterval m_timeDelta;
    CLLocation* m_currentLocation;
    NSInteger m_numberOfTries;
}

@property(nonatomic,retain)NSString* m_tinyURL;
@property(readonly,getter=latitude)float latitude;
@property(readonly,getter=longitude)float longitude;

+(LocationManager*)sharedLocationManager;

-(CLLocation*)currentLocation;
-(float)latitude;
-(float)longitude;
-(BOOL)locationDefined;
-(BOOL)locationDenied;
-(BOOL)locationServicesEnabled;
-(NSString*)longURLWithLatitude:(float)lat longitude:(float)lon;
-(NSString*)mapURL;
-(void)startUpdates;
-(void)stopUpdates;


@end
