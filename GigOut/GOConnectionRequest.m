//
//  GOConnectionRequest.m
//  GigOut
//
//  Created by luigi br on 04/12/11.
//  Copyright (c) 2011 la sua. All rights reserved.
//

#import "GOConnectionRequest.h"
#import "GOGigSentiment.h"

@implementation GOConnectionRequest

+ (NSString *)getTopTrackNameForArtist:(NSString *)artistName{
    
    NSString *apiKey = @"b25b959554ed76058ac220b7b2e0a026";
    NSString *fetchUrlString = [NSString stringWithFormat:@"http://ws.audioscrobbler.com/2.0/?method=artist.gettoptracks&artist=%@&api_key=%@&limit=1&format=json", [artistName stringByAddingPercentEscapesUsingEncoding: NSASCIIStringEncoding],apiKey];

    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString: fetchUrlString]];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *receivedData = [NSURLConnection sendSynchronousRequest:request 
                                                 returningResponse:&response 
                                                             error:&error];
    if (!error) {

        NSError *jsonError = nil;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:receivedData options:kNilOptions error:&jsonError];
        
        if (dictionary != nil && !jsonError) {
            NSString *trackName = (NSString *)[[[dictionary objectForKey:@"toptracks"] objectForKey:@"track"] objectForKey:@"name"];
            return trackName;
            }
    }
    return nil;
}

+ (NSString *)getSentimentsForTrack:(NSString *)trackName andArtistName:(NSString *)artistName{
    
    if (trackName != nil && artistName != nil) {
            
        NSString *apiKey = @"b25b959554ed76058ac220b7b2e0a026";
        NSString *fetchUrlString = [NSString stringWithFormat:@"http://developer.echonest.com/api/v4/song/search?api_key=N6E4NIOVYMTHNDM8J&format=json&results=1&artist=%@&title=%@&bucket=id:7digital&bucket=audio_summary&bucket=tracks",
                                    apiKey,
                                    [artistName stringByAddingPercentEscapesUsingEncoding: NSASCIIStringEncoding],
                                    [trackName stringByAddingPercentEscapesUsingEncoding: NSASCIIStringEncoding]];

        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString: fetchUrlString]];
        NSURLResponse *response = nil;
        NSError *error = nil;
        NSData *receivedData = [NSURLConnection sendSynchronousRequest:request 
                                                     returningResponse:&response 
                                                                 error:&error];
        if (!error) {

            NSError *jsonError = nil;
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:receivedData options:kNilOptions error:&jsonError];
            
            if (dictionary != nil && !jsonError) {
                NSArray *dataArray = [[dictionary objectForKey:@"response"] objectForKey:@"songs"];
                if (dataArray) {
                    NSDictionary *song = [dataArray objectAtIndex:0];
                    {
                        if (song) {
                            GOGigSentiment *gigSentiment = [[GOGigSentiment alloc] init];
                            [gigSentiment setTempo:[(NSNumber*)[song objectForKey:@"tempo"] floatValue]];
                            [gigSentiment setLoudness:[(NSNumber*)[song objectForKey:@"loudness"] floatValue]];
                            [gigSentiment setDuration:[(NSNumber*)[song objectForKey:@"duration"] floatValue]];
                            [gigSentiment setEnergy:[(NSNumber*)[song objectForKey:@"energy"] floatValue]];
                            [gigSentiment setDanceability:[(NSNumber*)[song objectForKey:@"danceability"] floatValue]];
                            
                            return [gigSentiment sentimentString];
                        }
                    }                    
                }
            }
        }
    }
    return nil;
}

@end
