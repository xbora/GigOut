//
//  GOFetchGigsOperation.m
//  GigOut
//
//  Created by BORA CELIK on 12/3/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "GOFetchGigsOperation.h"
#import <CoreLocation/CoreLocation.h>
#import "PSLog.h"

@implementation GOFetchGigsOperation

#pragma mark - Initialization

- (id) initiWithLocation: (CLLocation *)location
{
    self = [super init];
    if (self)
    {
        location_ = [location copy];
    }
    return self;
}

#pragma mark - Cleanup

- (void) dealloc
{
    [location_ release];
    [super dealloc];
}

#pragma mark - Operation main method

- (void)main
{
    
    @try {
        NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
        
        //check to see if we have been cancelled.
        if (![self isCancelled])
        {
            NSMutableArray *gigs = [[NSMutableArray alloc] init];
            NSString *apiKey = @"b25b959554ed76058ac220b7b2e0a026";
            //NSUInteger count = kMaxResults;
            NSUInteger radius = kSearchRadiusMile;
            NSString *fetchUrlString = [NSString stringWithFormat:@"bla",
                                        location_.coordinate.latitude,
                                        location_.coordinate.longitude,
                                        radius,
                                        apiKey];
            NSURL *fetchUrl = [NSURL URLWithString: fetchUrlString];
            NSStringEncoding encoding;
            
            //fetch data from web service
            NSString *jsonString = [NSString stringWithContentsOfURL:fetchUrl usedEncoding:&encoding error:nil];
            NSData *jsonData = [jsonString dataUsingEncoding:NSUTF32BigEndianStringEncoding];
            NSError *jsonError = nil;
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&jsonError];
            
        }
        
        
    }
    @catch (NSException *e) {
        PSLogException(@"%@", e);
    }
    
    
}

@end
