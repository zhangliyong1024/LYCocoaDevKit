//
//  UIButton+LYCocoaDevKit.h
//  LYCocoaDevKit
//
//  Created by Polly polly on 8/17/19.
//  Copyright © 2019 zhangliyong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (LYCocoaDevKit)

+ (instancetype)buttonWithTitleColor:(nullable UIColor *)titleColor
                     backgroundColor:(nullable UIColor *)backgroundColor
                         cornerRadii:(CGSize)cornerRadii;

+ (instancetype)buttonWithTitleColor:(nullable UIColor *)titleColor
                     backgroundColor:(nullable UIColor *)backgroundColor
                         borderColor:(nullable UIColor *)borderColor
                         cornerRadii:(CGSize)cornerRadii;

- (void)setTitleColor:(nullable UIColor *)titleColor
      backgroundColor:(nullable UIColor *)backgroundColor
          borderColor:(nullable UIColor *)borderColor
          cornerRadii:(CGSize)cornerRadii;

@end

NS_ASSUME_NONNULL_END
