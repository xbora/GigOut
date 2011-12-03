//
//  GOFetchVideoOperation.h
//  GigOut
//
//  Created by luigi br on 03/12/11.
//  Copyright (c) 2011 la sua. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GOFetchVideoOperationDelegate <NSObject>

- (void)fetchVideoRequestDidFinishWithArray:(NSArray *)gigsVideoArray;

@end

@interface GOFetchVideoOperation : NSOperation{
    
    id <GOFetchVideoOperationDelegate> delegate;

}

@property (nonatomic, assign) id <GOFetchVideoOperationDelegate> delegate;

- (id) initWithArtistName:(NSString *)artistName;

@end
