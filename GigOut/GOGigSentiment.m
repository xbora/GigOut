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
    
    
    return finalString;
}

- (NSString *)getLoudnessMessage{
    
    NSString *loudString = @"";
    
    NSString *test = @"";    
    CGFloat range = kMaxLoudness - kMinLoudness;
    CGFloat gap = range/kRangeValue;
    
    if (_loudness < gap) {
        loudString = @"";
    }
    else if (_loudness < gap*2) {
        loudString = @"";
    }
    else if (_loudness < gap*3) {
        loudString = @"";
    }
    
    return loudString;
}

- (NSString *)getEnergyMessage{
    
    NSString *energyString = @"";
    
    return energyString;
}
- (NSString *)getDaceabilityMessage{
    
    NSString *danceString = @"";
    
    return danceString;
}
@end
