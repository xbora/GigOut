//
//  GOFetchSentiment.h
//  GigOut
//
//  Created by luigi br on 04/12/11.
//  Copyright (c) 2011 la sua. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol GOFetchSentimentDelegate <NSObject>

- (void)fetchSentimentRequestDidFinishWithMessage:(NSString *)sentimentMessage;

@end

@interface GOFetchSentiment : NSObject{
    
    id <GOFetchSentimentDelegate> delegate;
    NSString *_artistName;
}

@property (nonatomic, assign) id <GOFetchSentimentDelegate> delegate;
@property (nonatomic, copy) NSString *artistName;

- (id) initWithArtistName:(NSString *)artistName;
- (void)retrieveSentimentData;

@end