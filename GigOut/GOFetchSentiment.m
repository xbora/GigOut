//
//  GOFetchSentiment.m
//  GigOut
//
//  Created by luigi br on 04/12/11.
//  Copyright (c) 2011 la sua. All rights reserved.
//

#import "GOFetchSentiment.h"
#import "GOGigSentiment.h"

@implementation GOFetchSentiment

@synthesize delegate;
@synthesize artistName = _artistName;

- (id) initWithArtistName:(NSString *)artistName
{
    self = [super init];
    if (self)
    {
        _artistName = artistName;
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

-(void)retrieveSentimentData
{
    
    NSMutableArray *gigs = [[NSMutableArray alloc] init];
    NSString *apiKey = @"b25b959554ed76058ac220b7b2e0a026";
    NSString *fetchUrlString = [NSString stringWithFormat:@"http://ws.audioscrobbler.com/2.0/?method=artist.gettoptracks&artist=%@&api_key=%@&format=json", [_artistName stringByAddingPercentEscapesUsingEncoding: NSASCIIStringEncoding],apiKey];
    NSLog(@"The sentiment request is %@",fetchUrlString);
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
        NSArray *dataArray = [[dictionary objectForKey:@"response"] objectForKey:@"songs"];
        if (dataArray) {
            //for (NSDictionary *songs in data)
            NSDictionary *songs = [dataArray objectAtIndex:0];
            {
                GOGigSentiment *gigSentiment = [[GOGigSentiment alloc] init];
                [gigSentiment setTempo:[(NSNumber*)[songs objectForKey:@"tempo"] floatValue]];
                [gigSentiment setLoudness:[(NSNumber*)[songs objectForKey:@"loudness"] floatValue]];
                [gigSentiment setDuration:[(NSNumber*)[songs objectForKey:@"duration"] floatValue]];
                [gigSentiment setEnergy:[(NSNumber*)[songs objectForKey:@"energy"] floatValue]];
                [gigSentiment setDanceability:[(NSNumber*)[songs objectForKey:@"danceability"] floatValue]];
            }                    
        }

        if (delegate != nil &&
            [delegate respondsToSelector:@selector(fetchSentimentRequestDidFinishWithArray:)]){
            [delegate performSelector:@selector(fetchSentimentRequestDidFinishWithArray:) withObject:gigs];
        }
        
        [gigs release];
    }
}

@end
