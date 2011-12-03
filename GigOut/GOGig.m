//
//  GOGig.m
//  GigOut
//
//  Created by BORA CELIK on 12/3/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "GOGig.h"
#import <CoreLocation/CoreLocation.h>

@implementation GOGig

@synthesize gigName = gigName_;
@synthesize artistName = artistName_;
@synthesize location = location_;
@synthesize venueId = venueId_;
@synthesize venueName = venueName_;
@synthesize venueLat = venueLat_;
@synthesize venueLng= venueLng_;
@synthesize venueCity = venueCity_;
@synthesize venueCountry = venueCountry_;
@synthesize venueStreet = venueStreet_;
@synthesize venueZip = venueZip_; 
@synthesize venueUrl = venueUrl_;
@synthesize venuePhone = venuePhone_;
@synthesize startDate = startDate_;
@synthesize description = description_; 
@synthesize coordinate = coordinate_;

#pragma mark - Class methods

- (void)dealloc
{
	[gigName_ release];
	[artistName_ release];
	[location_ release];
	[venueId_ release];
	[venueName_ release];
	[venueLat_ release];
	[venueLng_ release];
	[venueCity_ release];
    [venueCountry_ release];
    [venueStreet_ release];
    [venueZip_ release];
    [venueUrl_ release];
    [venuePhone_ release];
    [startDate_ release];
    [description_ release];
	[super dealloc];
}

@end
