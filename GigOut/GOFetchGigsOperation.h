//
//  GOFetchGigsOperation.h
//  GigOut
//
//  Created by BORA CELIK on 12/3/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/Corelocation.h>

@protocol GOFetchGigsOperationDelegate <NSObject>

- (void)fetchRequestDidFinishWithArray:(NSArray *)gigsArray;

@end

@interface GOFetchGigsOperation : NSOperation {
    CLLocation *location_;
    id <GOFetchGigsOperationDelegate> delegate;

}

@property (nonatomic, retain) CLLocation *location;
@property (nonatomic, assign) id <GOFetchGigsOperationDelegate> delegate;

- (id) initWithLocation: (CLLocation *)location;

@end
