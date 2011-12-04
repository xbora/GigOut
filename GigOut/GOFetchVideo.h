//
//  GOFetchVideoOperation.h
//  GigOut
//
//  Created by luigi br on 03/12/11.
//  Copyright (c) 2011 la sua. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GOGigVideoInfo.h"

@protocol GOFetchVideoOperationDelegate <NSObject>

- (void)fetchVideoRequestDidFinishWithArray:(NSArray *)gigsVideoArray;

@end

@interface GOFetchVideo : NSObject{
    
    id <GOFetchVideoOperationDelegate> delegate;
    NSString *_artistName;
}

@property (nonatomic, assign) id <GOFetchVideoOperationDelegate> delegate;
@property (nonatomic, copy) NSString *artistName;

- (id) initWithArtistName:(NSString *)artistName;
- (void)retrieveVideoData;

@end
