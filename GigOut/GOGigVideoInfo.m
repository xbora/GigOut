//
//  GOGigVideoInfo.m
//  GigOut
//
//  Created by luigi br on 03/12/11.
//  Copyright (c) 2011 la sua. All rights reserved.
//

#import "GOGigVideoInfo.h"

@implementation GOGigVideoInfo

@synthesize videoStringUrl = _videoStringUrl;
@synthesize videoDescription = _videoDescription;

#pragma mark - Class methods

- (void)dealloc
{
	[_videoStringUrl release];
	[_videoDescription release];
    [super dealloc];
}

@end
