//
//  GOFetchGigsOperation.m
//  GigOut
//
//  Created by BORA CELIK on 12/3/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "GOFetchGigsOperation.h"
#import <CoreLocation/CoreLocation.h>
#import "GOGig.h"
#import "GOAppDelegate.h"
#import "PSLog.h"

@implementation GOFetchGigsOperation

@synthesize location = location_;
@synthesize delegate;

#pragma mark - Initialization

- (id)initWithLocation:(CLLocation *)location
{
    self = [self init];
    if (self)
    {
        location_ = [location copy];
    }
    return self;
}

- (id) init
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

#pragma mark - Cleanup

- (void) dealloc
{
    self.delegate = nil;
    [location_ release];
    [super dealloc];
}

#pragma mark - Operation main method

- (void)main
{
    @try {        
        //check to see if we have been cancelled.
        if (![self isCancelled])
        {
            NSMutableArray *gigs = [[NSMutableArray alloc] init];
            NSString *apiKey = @"b25b959554ed76058ac220b7b2e0a026";
            NSString *fetchUrlString = [NSString stringWithFormat:@"http://ws.audioscrobbler.com/2.0/?method=geo.getevents&limit=25&lat=%@&lng=%@&format=json&api_key=%@",
                                        @"51.549751017014245",
                                        @"-1.494140625", apiKey];
            NSURL *fetchUrl = [NSURL URLWithString: fetchUrlString];
            NSURLRequest *request = [NSURLRequest requestWithURL:fetchUrl];
            NSURLResponse *response = nil;
            NSError *error = nil;
            NSData *receivedData = [NSURLConnection sendSynchronousRequest:request 
                                                                returningResponse:&response 
                                                                            error:&error];
            NSError *jsonError = nil;
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:receivedData options:kNilOptions error:&jsonError];
            
            if (dictionary != nil) {
                NSArray *events = [[dictionary objectForKey:@"events"] objectForKey:@"event"];
                if (events) {
                    for (NSDictionary *event in events)
                    {
                        //NSLog(@"The events values are %@", event);
                        GOGig *gig = [[GOGig alloc] init];
                        gig.gigName = [event objectForKey:@"title"];
                        
                        NSDictionary *artists = [event objectForKey:@"artists"];
                        
                        gig.artistName = [artists objectForKey:@"headliner"];                            
                        
                        NSDictionary *venue = [event objectForKey:@"venue"];
                        
                        gig.venueId = [venue objectForKey:@"id"]; 
                        gig.venueName = [venue objectForKey:@"name"];
                        
                        
                        NSDictionary *location = [venue objectForKey:@"location"];
                        NSDictionary *geopoint = [location objectForKey:@"geo:point"];
                        
                        gig.venueLat = [geopoint objectForKey:@"geo:lat"];
                        gig.venueLng = [geopoint objectForKey:@"geo:long"];
                        
                        gig.venueCity = [location objectForKey:@"city"];
                        gig.venueCountry = [location objectForKey:@"country"];
                        gig.venueStreet = [location objectForKey:@"street"];
                        gig.venueZip = [location objectForKey:@"postalcode"];
                        gig.venueUrl = [venue objectForKey:@"website"];
                        gig.venuePhone = [venue objectForKey:@"phonenumber"];
                        gig.description = [event objectForKey:@"description"];
                        
                        NSArray *imgArray = [event objectForKey:@"image"];
                        for (NSDictionary *imgJSON in imgArray) {
                            if ([[imgJSON valueForKey:@"size"] isEqualToString:@"extralarge"]) {
                                gig.artistLargeImgUrl = [imgJSON valueForKey:@"#text"];
                            }
                            else if([[imgJSON valueForKey:@"size"] isEqualToString:@"small"]) {
                                gig.artistSmallImgUrl = [imgJSON valueForKey:@"#text"];
                            }
                        }
                        gig.startDate = [event objectForKey:@"startDate"];
                        
                        [gigs addObject:gig];
                    }                    
                }

            }

//            NSStringEncoding encoding;
//            //fetch data from web service
//            NSString *jsonString = [NSString stringWithContentsOfURL:fetchUrl usedEncoding:&encoding error:nil];
//            PSLogDebug(@"json %@", jsonString);
//            NSData *jsonData = [jsonString dataUsingEncoding:NSUTF32BigEndianStringEncoding];
//            NSError *jsonError = nil;
//            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&jsonError];
            
            //check to see if we have been cancelled
//            if (![self isCancelled] && dictionary != nil)
//            {                    
//            }
         
            if (delegate != nil &&
                [delegate respondsToSelector:@selector(fetchRequestDidFinishWithArray:)]){
                [delegate fetchRequestDidFinishWithArray:gigs];
            }
            
            [gigs release];
        }  
    }
    @catch (NSException *e) {
        PSLogException(@"%@", e);
    }
    
    
}

@end
