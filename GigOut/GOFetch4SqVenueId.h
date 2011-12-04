//
//  GOFetch4SqVenueId.h
//  GigOut
//
//  Created by BORA CELIK on 12/4/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GOGig.h"

@protocol GOFetch4SqVenueIdOperationDelegate <NSObject>

- (void)fetchRequestDidFinishWithVenueId:(NSString *)venue4SqId;

@end

@interface GOFetch4SqVenueId : NSObject {
    
    id <GOFetch4SqVenueIdOperationDelegate> delegate;
    NSString *_gigVenueName;
    NSString *_gigVenueLat;
    NSString *_gigVenueLng;
    GOGig *_gigObject;
    
    
}

@property (nonatomic, assign) id <GOFetch4SqVenueIdOperationDelegate> delegate;
@property (nonatomic, copy) NSString *gigVenueName;
@property (nonatomic, copy) NSString *gigVenueLat;
@property (nonatomic, copy) NSString *gigVenueLng;
@property (nonatomic,retain) GOGig *gigObject;

-(void) retrieve4SqVenueId;
- (id) initWithGigObject: (GOGig *)gig;

@end
