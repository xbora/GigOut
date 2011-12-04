//
//  GOGigSentiment.h
//  GigOut
//
//  Created by luigi br on 04/12/11.
//  Copyright (c) 2011 la sua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GOGigSentiment : NSObject {
    CGFloat _duration;
    CGFloat _loudness;
    CGFloat _energy;
    CGFloat _tempo;
    CGFloat _danceability;
}

@property (nonatomic, assign) CGFloat duration;
@property (nonatomic, assign) CGFloat loudness;
@property (nonatomic, assign) CGFloat energy;
@property (nonatomic, assign) CGFloat tempo;
@property (nonatomic, assign) CGFloat danceability;

- (NSString *)sentimentString;

@end
