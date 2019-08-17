//
//  NSDateFormatter+LYCocoaDevKit.h
//  LYCocoaDevKit
//
//  Created by Polly polly on 8/17/19.
//  Copyright © 2019 zhangliyong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDateFormatter (LYCocoaDevKit)

- (NSString *)shortDayStringFromDate:(NSDate *)date;

- (NSString *)shortTimeStringFromDate:(NSDate *)date;

- (NSString *)shortDayTimeStringFromDate:(NSDate *)date;

- (NSString *)shortTimeStringFromTimeInterval:(NSTimeInterval)interval;

- (NSString *)clockTimeStringFromTimeInterval:(NSTimeInterval)interval;

- (NSString *)smartDayTimeStringFromDate:(NSDate *)date;

@end

NS_ASSUME_NONNULL_END
