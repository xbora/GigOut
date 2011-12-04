//
//  GOFetchSentiment.m
//  GigOut
//
//  Created by luigi br on 04/12/11.
//  Copyright (c) 2011 la sua. All rights reserved.
//

#import "GOFetchSentiment.h"
#import "GOGigSentiment.h"
#import "GOConnectionRequest.h"

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
    NSString *topTrackName = [GOConnectionRequest getTopTrackNameForArtist:_artistName];
    NSString *sentimentMessage = [GOConnectionRequest getSentimentsForTrack:topTrackName
                                                              andArtistName:_artistName];

    if (delegate != nil &&
        [delegate respondsToSelector:@selector(fetchSentimentRequestDidFinishWithMessage:)]){
        [delegate fetchSentimentRequestDidFinishWithMessage:sentimentMessage];
    }
}

@end
