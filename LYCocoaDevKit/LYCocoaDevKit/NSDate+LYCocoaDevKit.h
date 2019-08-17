//
//  NSDate+LYCocoaDevKit.h
//  LYCocoaDevKit
//
//  Created by Polly polly on 8/17/19.
//  Copyright © 2019 zhangliyong. All rights reserved.
//

#import <Foundation/Foundation.h>

#define LATER_DATE(a, b)            a = a?[a laterDate:b]:b

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (LYCocoaDevKit)

@property (readonly) NSTimeInterval timeIntervalToNow;

+ (NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
                    hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second;

- (NSInteger)year;
- (NSInteger)month;
- (NSInteger)day;
- (NSInteger)week;
- (NSInteger)weekDay;

- (NSInteger)hour;
- (NSInteger)minute;
- (NSInteger)second;

- (BOOL)sameYearTo:(NSDate *)date;
- (BOOL)sameMonthTo:(NSDate *)date;
- (BOOL)sameDayTo:(NSDate *)date;

- (long)secondsSince1970;

- (NSDate *)startDateOfThisDay;

- (NSDate *)endDateOfThisDay;

@end

NS_ASSUME_NONNULL_END
