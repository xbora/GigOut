//
//  GOGigSentiment.m
//  GigOut
//
//  Created by luigi br on 04/12/11.
//  Copyright (c) 2011 la sua. All rights reserved.
//

#import "GOGigSentiment.h"


#define kMaxLoudness 100.
#define kMinLoudness -kMaxLoudness

#define kMaxEnergy 1.0
#define kMinEnergy 0.0

#define kMaxDancebility 1.0
#define kMinDancebility 0.0

#define kRangeValue 3;

@interface GOGigSentiment ()

- (NSString *)getLoudnessMessage;
- (NSString *)getEnergyMessage;
- (NSString *)getDaceabilityMessage;

@end
@implementation GOGigSentiment

@synthesize duration = _duration;
@synthesize loudness = _loudness;
@synthesize energy   = _energy;
@synthesize tempo    = _tempo;
@synthesize danceability = _danceability;

- (NSString *)sentimentString{
    
    NSString *finalString = @"";
    
    finalString = [finalString stringByAppendingString:[self getLoudnessMessage]];
    finalString = [finalString stringByAppendingString:[self getEnergyMessage]];
    finalString = [finalString stringByAppendingString:[self getDaceabilityMessage]];

    return finalString;
}

- (NSString *)getLoudnessMessage{
    
    NSString *loudString = nil;
    
    CGFloat range = kMaxLoudness - kMinLoudness;
    CGFloat gap = range/kRangeValue;
    
    if (_loudness < gap) {
        loudString = @"low loud";
    }
    else if (_loudness < gap*2) {
        loudString = @"medium loud";
    }
    else if (_loudness < gap*3) {
        loudString = @"high loud";
    }
    
    if (![loudString isEqualToString:@""]) {
        loudString = [loudString stringByAppendingFormat:@"\n"];
    }
    
    return loudString;
}

- (NSString *)getEnergyMessage{
    
    NSString *energyString = nil;
    
    CGFloat range = kMaxEnergy - kMinEnergy;
    CGFloat gap = range/kRangeValue;
    
    if (_energy < gap) {
        energyString = @"low energy";
    }
    else if (_energy < gap*2) {
        energyString = @"medium energy";
    }
    else if (_energy < gap*3) {
        energyString = @"high energy";
    }
    
    if (![energyString isEqualToString:@""]) {
        energyString = [energyString stringByAppendingFormat:@"\n"];
    }
    
    return energyString;
}
- (NSString *)getDaceabilityMessage{
    
    NSString *danceString = nil;
    
    CGFloat range = kMaxDancebility - kMinDancebility;
    CGFloat gap = range/kRangeValue;
    
    if (_danceability < gap) {
        danceString = @"low dance";
    }
    else if (_danceability < gap*2) {
        danceString = @"medium dance";
    }
    else if (_danceability < gap*3) {
        danceString = @"high dance";
    }
    
    if (![danceString isEqualToString:@""]) {
        danceString = [danceString stringByAppendingFormat:@"\n"];
    }
    
    return danceString;
}
@end
