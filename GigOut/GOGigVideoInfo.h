//
//  GOGigVideoInfo.h
//  GigOut
//
//  Created by luigi br on 03/12/11.
//  Copyright (c) 2011 la sua. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GOGigVideoInfo : NSObject {
    NSString *_videoStringUrl;
    NSString *_videoDescription;
}

@property (nonatomic, copy) NSString *videoStringUrl;
@property (nonatomic, copy) NSString *videoDescription;

@end
