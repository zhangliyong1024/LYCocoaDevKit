//
//  UIColor+LYCocoaDevKit.h
//  LYCocoaDevKit
//
//  Created by Polly polly on 8/17/19.
//  Copyright © 2019 zhangliyong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (LYCocoaDevKit)

+ (instancetype)colorFromHex:(long long)value;
+ (instancetype)colorAlphaFromHex:(long long)value;

+ (instancetype)colorFromString:(NSString *)string;
+ (instancetype)colorAlphaFromString:(NSString *)string;

- (NSString *)hexStringWithAlpha:(BOOL)alpha;

- (UIColor *)colorWithMinimumSaturation:(CGFloat)saturation;

@end

NS_ASSUME_NONNULL_END
