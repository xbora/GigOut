//
//  GOFetch4SqVenueId.m
//  GigOut
//
//  Created by BORA CELIK on 12/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "GOFetch4SqVenueId.h"

@implementation GOFetch4SqVenueId

@synthesize delegate;
@synthesize gigVenueName = _gigVenueName;
@synthesize gigVenueLat = _gigVenueLat;
@synthesize gigVenueLng = _gigVenueLng;
@synthesize gigObject = _gigObject;

- (id) initWithGigObject: (GOGig *)gig
{
    self = [super init];
    if (self)
    {
        _gigObject = gig;
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

-(void) retrieve4SqVenueId
{
    //NSMutableArray *venues = [[NSMutableArray alloc] init];
    NSString *clientSecret = @"UECICV24WVG1ZFP1TWQYDQMU2XISHCNIGOZSGUD3Z1WEUU5G";
    NSString *venue4sqId = @"";
    NSString *oauthToken = @"TB32OHYOSH1SYNE14BGLSLR0BBSQZLM4JAPX1OTSD0KQTGMD" ;
    NSString *fetchUrlString = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/search?query=%@&ll=%@,%@&client_secret=%@&oauth_token=%@",[_gigObject.venueName stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding],_gigObject.venueLat,_gigObject.venueLng,clientSecret,oauthToken];
    NSLog(@"The 4sq request is %@",fetchUrlString);
    
    NSURL *fetchUrl = [NSURL URLWithString: fetchUrlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:fetchUrl];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *receivedData = [NSURLConnection sendSynchronousRequest:request 
                                                 returningResponse:&response 
                                                             error:&error];
    NSError *jsonError = nil;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:receivedData options:kNilOptions error:&jsonError];
    
    NSLog(@"The response %@ values %@",[dictionary allKeys],[dictionary allValues]);
    
    if (dictionary != nil) {
        
        NSArray *venueArray = [[dictionary objectForKey:@"response"] objectForKey:@"groups"];
        NSArray *venueGroups = [[venueArray objectAtIndex:0] objectForKey:@"items"];
        if (venueGroups != nil) {
            
            for (NSDictionary *venue in venueGroups){
                NSString *venue4sqName = [venue objectForKey:
                                          @"name"];
                
                if ([venue4sqName rangeOfString:_gigObject.venueName].location == NSNotFound) {
                    NSLog(@"string does not contain bla");
                } else {
                    NSLog(@"string contains bla!");
                    venue4sqId = [venue objectForKey:
                                              @"id"];
                    break;
                    
                }
            }
            NSLog(@"boom");
        }
        
        if (delegate != nil &&
            [delegate respondsToSelector:@selector(fetchRequestDidFinishWithVenueId:)]){
            [delegate fetchRequestDidFinishWithVenueId:venue4sqId];
        }
        
    }
    
    
}

@end
