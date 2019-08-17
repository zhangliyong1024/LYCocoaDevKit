//
//  NSDate+LYCocoaDevKit.m
//  LYCocoaDevKit
//
//  Created by Polly polly on 8/17/19.
//  Copyright © 2019 zhangliyong. All rights reserved.
//

#import "NSDate+LYCocoaDevKit.h"

@implementation NSDate (LYCocoaDevKit)

+ (NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
                    hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second {
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    NSDateComponents *components = [calendar components:unit fromDate:[NSDate date]];
    components.year     = year;
    components.month    = month;
    components.day      = day;
    components.hour     = hour;
    components.minute   = minute;
    components.second   = second;
    
    return [calendar dateFromComponents:components];
}

- (NSTimeInterval)timeIntervalToNow {
    return -[self timeIntervalSinceNow];
}

- (NSDateComponents *)components {
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unit fromDate:self];
}

- (NSInteger)year {
    return [self components].year;
}

- (NSInteger)month {
    return [self components].month;
}

- (NSInteger)day {
    return [self components].day;
}

- (NSInteger)week {
    return [self components].weekOfYear;
}

- (NSInteger)weekDay {
    return [self components].weekday;
}

- (NSInteger)hour {
    return [self components].hour;
}

- (NSInteger)minute {
    return [self components].minute;
}

- (NSInteger)second {
    return [self components].second;
}

- (BOOL)sameYearTo:(NSDate *)date {
    return self.year == date.year;
}

- (BOOL)sameMonthTo:(NSDate *)date {
    return [self sameYearTo:date] && self.month == date.month;
}

- (BOOL)sameDayTo:(NSDate *)date {
    return [self sameMonthTo:date] && self.day == date.day;
}

- (long)secondsSince1970 {
    long seconds = self.timeIntervalSince1970;
    return seconds;
}

- (NSDate *)startDateOfThisDay {
    return [NSDate dateWithYear:self.year month:self.month day:self.day
                           hour:0 minute:0 second:0];
}

- (NSDate *)endDateOfThisDay {
    return [NSDate dateWithYear:self.year month:self.month day:self.day
                           hour:23 minute:59 second:59];
}

@end

