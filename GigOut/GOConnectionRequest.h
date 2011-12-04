//
//  GOConnectionRequest.h
//  GigOut
//
//  Created by luigi br on 04/12/11.
//  Copyright (c) 2011 la sua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GOConnectionRequest : NSObject

+ (NSString *)getTopTrackNameForArtist:(NSString *)artistName;
+ (NSString *)getSentimentsForTrack:(NSString *)trackName andArtistName:(NSString *)artistName;

@end
