//
//  GOGig.h
//  GigOut
//
//  Created by BORA CELIK on 12/3/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "GOGigVideoInfo.h"

@interface GOGig : NSObject {
    NSString *gigName_;
    NSString *artistName_;
    NSString *artistImgUrl;
    NSString *venueId_;
    NSString *venueName_;
    NSString *venueLat_;
    NSString *venueLng_;
    NSString *venueCity_;
    NSString *venueCountry_;
    NSString *venueStreet_;
    NSString *venueZip_;
    NSString *venueUrl_;
    NSString *venuePhone_;
    NSString *startDate_;
    NSString *description_;
    
    NSMutableArray *videoArray_; // A GOGigVideoInfo array
}

@property (nonatomic, copy) NSString *gigName;
@property (nonatomic, copy) NSString *artistName;
@property (nonatomic, copy) NSString *venueId;
@property (nonatomic, copy) NSString *venueName;
@property (nonatomic, copy) NSString *venueLat;
@property (nonatomic, copy) NSString *venueLng;
@property (nonatomic, copy) NSString *venueCity;
@property (nonatomic, copy) NSString *venueCountry;
@property (nonatomic, copy) NSString *venueStreet;
@property (nonatomic, copy) NSString *venueZip;
@property (nonatomic, copy) NSString *venueUrl;
@property (nonatomic, copy) NSString *artistImgUrl;
@property (nonatomic, copy) NSString *venuePhone;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, retain) NSString *startDate;
@property (nonatomic, retain) NSMutableArray *videoArray;


@end
