//
//  DateUtils.m
//  UberLife
//
//  Created by Richard on 26/07/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DateUtils.h"



@implementation DateUtils

+(NSDate*)ISO8601DateFromString:(NSString*)string {
    
    if(string == nil)
        return nil;
    
    NSDate* result;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    
    [dateFormat setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"] autorelease]];
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    NSError* dateError;
    
    if (![dateFormat getObjectValue:&result forString:string range:nil error:&dateError]) 
    {
        NSLog(@"Date '%@' could not be parsed: %d %@", string, [dateError code], [dateError localizedDescription]);
        [dateFormat release];
        return nil;
    }
    
    [dateFormat release];
    return result;
}

+(NSString*)ISO8601StringFromDate:(NSDate*)date {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    
    //[dateFormat setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"] autorelease]];
    
    [dateFormat setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    
    NSString * result = [dateFormat stringFromDate:date];
    
    [dateFormat release];
    
    
//
//    
//    NSDateFormatter * sISO8601 = [[NSDateFormatter alloc] init];
//    
//    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
//    int offset = [timeZone secondsFromGMT];
//    
//    NSMutableString *strFormat = [NSMutableString stringWithString:@"yyyyMMdd'T'HH:mm:ss"];
//    offset /= 60; //bring down to minutes
//    if (offset == 0) {
//        [strFormat appendString:@"Z"];
//    } else {
//        [strFormat appendFormat:@"%+02d%02d", offset / 60, offset % 60];
//    }
//    [sISO8601 setTimeStyle:NSDateFormatterFullStyle];
//    [sISO8601 setDateFormat:strFormat];
//    result = [sISO8601 stringFromDate:date];
//    [sISO8601 release];
    return result;
}

+(NSString*)niceDate:(NSDate*)date
{
    NSDate* now = [[NSDate alloc] init];
    NSCalendar* calNow = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSCalendar* calDate = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents * compNow = [calNow components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:now];
    NSDateComponents * compDate = [calDate components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:date];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    
    [dateFormat setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"] autorelease]];
    
   // NSLocale * locale = [NSLocale currentLocale];
    
   // [dateFormat setLocale: locale];
    
    NSString * result;
    if ([compNow year] == [compDate year] && [compNow month] == [compDate month] && [compNow day] == [compDate day]) 
    {

        [dateFormat setDateStyle:kCFDateFormatterNoStyle];
        [dateFormat setTimeStyle:kCFDateFormatterShortStyle];
        result = [NSString stringWithFormat:@"%@ %@", NSLocalizedString(@"Today", @"Today"), [dateFormat stringFromDate:date]];
    } 
    else if ( [calNow ordinalityOfUnit: NSCalendarCalendarUnit inUnit:kCFCalendarUnitDay forDate:now] - [calNow ordinalityOfUnit:NSCalendarCalendarUnit inUnit:kCFCalendarUnitDay forDate:date]  == 1  )
    {
        result = NSLocalizedString(@"Yesterday", @"Yesterday");
    } 
    else 
    {
        [dateFormat setDateStyle:kCFDateFormatterMediumStyle];
        result = [dateFormat stringFromDate:date];
    }
    
                                       
    [calNow release];
    [calDate release];                                       
    [now release];
    [dateFormat release];  
    return result;
}

+ (NSDate *)combineDate:(NSDate *)date withTime:(NSDate *)time 
{
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    unsigned unitFlagsDate = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    
    NSDateComponents *dateComponents = [gregorian components:unitFlagsDate fromDate:date];
    
    unsigned unitFlagsTime = NSHourCalendarUnit | NSMinuteCalendarUnit |  NSSecondCalendarUnit;
    
    NSDateComponents *timeComponents = [gregorian components:unitFlagsTime fromDate:time];
    
    [dateComponents setSecond:[timeComponents second]];
    
    [dateComponents setHour:[timeComponents hour]];
    
    [dateComponents setMinute:[timeComponents minute]];
    
    NSDate *combDate = [gregorian dateFromComponents:dateComponents];   
    
    [gregorian release];

    
    return combDate;
}

+ (int)yearsOld:(NSDate *) birthday
{
    NSCalendar * gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *dateComponents = [gregorian components:NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit
                                        fromDate:birthday];
    NSInteger bYear = dateComponents.year;
    NSInteger bMonth = dateComponents.month;
    NSInteger bDay = dateComponents.day;
    dateComponents = [gregorian components:NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit
                                  fromDate:[NSDate date]];
    NSInteger nowYear = dateComponents.year;
    NSInteger nowMonth = dateComponents.month;
    NSInteger nowDay = dateComponents.day;
    int yearsOld = nowYear - bYear;
    if ((bMonth > nowMonth) || (bMonth == nowMonth  && bDay > nowDay)) {
        yearsOld --;
    }
    
    [gregorian release];
    
    return yearsOld;
}

@end
