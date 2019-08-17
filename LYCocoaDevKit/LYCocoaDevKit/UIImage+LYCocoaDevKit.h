//
//  UIImage+LYCocoaDevKit.h
//  LYCocoaDevKit
//
//  Created by Polly polly on 8/17/19.
//  Copyright © 2019 zhangliyong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (LYCocoaDevKit)

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

+ (UIImage *)imageWithColor:(UIColor *)color
                       size:(CGSize)size
          byRoundingCorners:(UIRectCorner)corners
                cornerRadii:(CGSize)cornerRadii;

- (UIImage *)convertToGrayscale;

- (UIImage *)imageMaskedWithColor:(UIColor *)maskColor;

- (UIImage *)imageResized:(CGFloat)resolution;

- (UIImage *)croppedImage:(CGRect)bounds;

- (UIImage *)imageRotated:(UIImageOrientation)orientation;

- (UIImage *)imageWithcornerRadii:(CGFloat)cornerRadii
                             scale:(CGFloat)scale;

- (UIImage *)imageWithAlpha:(CGFloat)alpha;

- (UIColor *)averageColor;

- (nullable NSString *)QR;

+ (UIImage *)imageWithColor:(UIColor *)color
                       size:(CGSize)size
          byRoundingCorners:(UIRectCorner)corners
                cornerRadii:(CGSize)cornerRadii
                      title:(NSString *)title
                  titleFont:(UIFont *)titleFont
                 titleColor:(UIColor *)titleColor;


@end

NS_ASSUME_NONNULL_END
