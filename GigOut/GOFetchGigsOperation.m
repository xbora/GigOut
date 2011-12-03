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

- (id) initiWithLocation: (CLLocation *)location
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
            //NSUInteger count = kMaxResults;
            NSUInteger radius = kSearchRadiusKms;
            NSString *fetchUrlString = [NSString stringWithFormat:@"http://ws.audioscrobbler.com/2.0/?method=geo.getevents&lat=%@&lng=%@&format=json&api_key=%@",
                                        @"51.549751017014245",
                                        @"-1.494140625",                                        apiKey];
            NSURL *fetchUrl = [NSURL URLWithString: fetchUrlString];
            NSStringEncoding encoding;
            
            //fetch data from web service
            NSString *jsonString = [NSString stringWithContentsOfURL:fetchUrl usedEncoding:&encoding error:nil];
            PSLogDebug(@"json %@", jsonString);
            NSData *jsonData = [jsonString dataUsingEncoding:NSUTF32BigEndianStringEncoding];
            NSError *jsonError = nil;
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&jsonError];
            
        }
        
        //check to see if we have been cancelled
//        if (!self isCancelled)
//        {
//            if (dictionary) {
//                
//            }
//        }
        
        // MIKEEEE HI, how are you? Btw this is the array to be passed through the delegate. C u. Luigi.
        NSArray *gigsArray = [NSArray array];
        
        if (delegate != nil &&
            [delegate respondsToSelector:@selector(fetchRequestDidFinishWithArray:)]){
            [delegate fetchRequestDidFinishWithArray:gigsArray];
        }
        
        
    }
    @catch (NSException *e) {
        PSLogException(@"%@", e);
    }
    
    
}

@end
