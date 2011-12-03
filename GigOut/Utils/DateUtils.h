//
//  DateUtils.h
//  UberLife
//
//  Created by Richard on 26/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DateUtils : NSObject {
    
}

+(NSDate*)ISO8601DateFromString:(NSString*)string;

+(NSString*)ISO8601StringFromDate:(NSDate*)date;

+(NSString*)niceDate:(NSDate*)date;

+(NSDate *)combineDate:(NSDate *)date withTime:(NSDate *)time;

+(int)yearsOld:(NSDate *) birthday;

@end
