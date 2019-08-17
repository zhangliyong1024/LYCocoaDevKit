//
//  NSDateFormatter+LYCocoaDevKit.m
//  LYCocoaDevKit
//
//  Created by Polly polly on 8/17/19.
//  Copyright © 2019 zhangliyong. All rights reserved.
//

#import "NSDateFormatter+LYCocoaDevKit.h"
#import "NSDate+LYCocoaDevKit.h"

@implementation NSDateFormatter (LYCocoaDevKit)

- (NSString *)shortDayStringFromDate:(NSDate *)date {
    self.dateFormat = @"y-M-d";
    return [self stringFromDate:date];
}

- (NSString *)shortTimeStringFromDate:(NSDate *)date {
    self.dateFormat = @"aa h:mm";
    return [self stringFromDate:date];
}

- (NSString *)shortDayTimeStringFromDate:(NSDate *)date {
    self.dateFormat = @"y-M-d aa h:mm";
    return [self stringFromDate:date];
}

- (NSString *)shortTimeStringFromTimeInterval:(NSTimeInterval)interval {
    NSInteger min = (NSInteger)interval / 60 % 60;
    NSInteger hour = (NSInteger)interval / (60 * 60);
    
    if (hour == 0) {
        return [NSString stringWithFormat:@"%ld分钟", (long)min];
    }
    else if (min == 0) {
        return [NSString stringWithFormat:@"%ld小时", (long)hour];
    }
    else {
        return [NSString stringWithFormat:@"%ld小时%ld分钟", (long)hour, (long)min];
    }
}

- (NSString *)clockTimeStringFromTimeInterval:(NSTimeInterval)interval {
    NSInteger second = (NSInteger)interval % 60;
    NSInteger min = (NSInteger)interval / 60 % 60;
    NSInteger hour = (NSInteger)interval / (60 * 60);
    
    if (hour == 0) {
        return [NSString stringWithFormat:@"%ld:%ld", (long)min, (long)second];
    }
    else {
        return [NSString stringWithFormat:@"%ld:%ld:%ld", (long)hour, (long)min, (long)second];
    }
}

- (NSString *)smartDayTimeStringFromDate:(NSDate *)date {
    NSDate *today = [NSDate date];
    
    if (date.day == today.day) {
        // 同一天内
        self.dateFormat = @"aa h:mm";
        return [self stringFromDate:date];
    }
    else if (date.week == today.week) {
        // 同一周内
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSInteger dayIndex = ((date.weekDay - 1) + (calendar.firstWeekday - 1)) % 7;
        return calendar.weekdaySymbols[dayIndex];
    }
    else {
        // 比较久远了
    }
    
    return nil;
}

@end
