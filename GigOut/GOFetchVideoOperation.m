//
//  GOFetchVideoOperation.m
//  GigOut
//
//  Created by luigi br on 03/12/11.
//  Copyright (c) 2011 la sua. All rights reserved.
//

#import "GOFetchVideoOperation.h"

@interface GOFetchVideoOperation ()

- (void)fetchVideoRequestForArtistName:(NSString *)artistName;

@end

@implementation GOFetchVideoOperation

@synthesize delegate;

- (id) initWithArtistName:(NSString *)artistName
{
    self = [super init];
    if (self)
    {
        [self fetchVideoRequestForArtistName:artistName];
    }
    return self;
}

#pragma mark - Cleanup

- (void) dealloc
{
    self.delegate = nil;
    [super dealloc];
}

#pragma mark - Operation main method

- (void)fetchVideoRequestForArtistName:(NSString *)artistName;
{
    @try {        
        //check to see if we have been cancelled.
        if (![self isCancelled])
        {
            // Change the request with the youtube video one!
            
            NSMutableArray *gigs = [[NSMutableArray alloc] init];
            NSString *apiKey = @"b25b959554ed76058ac220b7b2e0a026";
            NSString *fetchUrlString = [NSString stringWithFormat:@"http://ws.audioscrobbler.com/2.0/?method=geo.getevents&limit=25&lat=%@&lng=%@&format=json&api_key=%@",
                                        @"51.549751017014245",
                                        @"-1.494140625", apiKey];
            NSURL *fetchUrl = [NSURL URLWithString: fetchUrlString];
            NSStringEncoding encoding;
            
            //fetch data from web service
            NSString *jsonString = [NSString stringWithContentsOfURL:fetchUrl usedEncoding:&encoding error:nil];
            NSData *jsonData = [jsonString dataUsingEncoding:NSUTF32BigEndianStringEncoding];
            NSError *jsonError = nil;
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&jsonError];
            
            //check to see if we have been cancelled
            if (![self isCancelled] && dictionary != nil)
            {                    
                NSArray *events = [[dictionary objectForKey:@"events"] objectForKey:@"event"];
                if (events) {
                    for (NSDictionary *event in events)
                    {
                        
                    }                    
                }
            }
            
            if (delegate != nil &&
                [delegate respondsToSelector:@selector(fetchVideoRequestDidFinishWithArray:)]){
                [delegate fetchVideoRequestDidFinishWithArray:gigs];
            }
            
            [gigs release];
        }  
    }
    @catch (NSException *e) {
        NSLog(@"%@", e);
    }
    
    
}

@end
