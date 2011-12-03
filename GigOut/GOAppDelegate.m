//
//  GOAppDelegate.m
//  GigOut
//
//  Created by BORA CELIK on 12/3/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "GOAppDelegate.h"
#import "GOMasterViewController.h"

@implementation GOAppDelegate

@synthesize window = _window;
@synthesize navigationController = _navigationController;
@synthesize locationMgr = locationMgr_;
@synthesize locationTimer = locationTimer_;

- (void)dealloc
{
    [_window release];
    [_navigationController release];
    
    [locationTimer_ invalidate];
	[locationTimer_ release];
    
	[locationMgr_ stopUpdatingLocation];
	[locationMgr_ release];
    
    [super dealloc];
}

- (void)updateGigs
{
	PSLogDebug(@"");
	if (self.locationTimer == nil)
	{
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
		[locationMgr_ startUpdatingLocation];
		self.locationTimer = [NSTimer scheduledTimerWithTimeInterval:20.0 target:self selector:@selector(locationManagerDidTimeout:) userInfo:nil repeats:NO];
	}
}


- (void)locationManagerDidTimeout:(NSTimer *)timer
{
	PSLogDebug(@"");
	// Stop timer.
	[locationTimer_ invalidate];
	self.locationTimer = nil;
	// Stop location updates.
	[locationMgr_ stopUpdatingLocation];
	CLLocation *myLocation = locationMgr_.location;
	if (myLocation == nil)
	{
		PSLogWarning(@"CLLocationManager returned a nil location - using hard-coded location");
		myLocation = [[[CLLocation alloc] initWithLatitude:51.508056 longitude:-0.128056] autorelease];
	}

}

#pragma mark - CLLocationManagerDelegate methods

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
	PSLogDebug(@"");
	// Did we reach our desired accuracy?
	if (newLocation.horizontalAccuracy <= kCLLocationAccuracyNearestTenMeters)
	{
		// Stop timer.
		[locationTimer_ invalidate];
		self.locationTimer = nil;
		// Stop location updates.
		[locationMgr_ stopUpdatingLocation];
	}
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
	PSLogDebug(@"");
	if ([error code] == kCLErrorDenied)
	{
		// Stop timer.
		[locationTimer_ invalidate];
		self.locationTimer = nil;
		// Stop location updates.
		[locationMgr_ stopUpdatingLocation];
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	}
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.

    GOMasterViewController *masterViewController = [[[GOMasterViewController alloc] initWithNibName:@"GOMasterViewController" bundle:nil] autorelease];
    self.navigationController = [[[UINavigationController alloc] initWithRootViewController:masterViewController] autorelease];
    self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
