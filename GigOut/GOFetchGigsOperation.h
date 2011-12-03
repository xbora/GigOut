//
//  GOFetchGigsOperation.h
//  GigOut
//
//  Created by BORA CELIK on 12/3/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/Corelocation.h>

@interface GOFetchGigsOperation : NSOperation {
    CLLocation *location_;
}

- (id) initWithLocation: (CLLocation *)location;


@end
