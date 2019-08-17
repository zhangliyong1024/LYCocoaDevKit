//
//  UIScreen+LYCocoaDevKit.m
//  LYCocoaDevKit
//
//  Created by Polly polly on 8/17/19.
//  Copyright © 2019 zhangliyong. All rights reserved.
//

#import "UIScreen+LYCocoaDevKit.h"

@implementation UIScreen (LYCocoaDevKit)

+ (UIDeviceResolution)resolution {
    UIScreen *mainScreen = [UIScreen mainScreen];
    CGFloat scale = ([mainScreen respondsToSelector:@selector(scale)] ? mainScreen.scale : 1.0f);
    CGFloat pixelHeight = (CGRectGetHeight(mainScreen.bounds) * scale);
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        if (scale == 2.0f) {
            if (pixelHeight == 960.0f) {
                return UIDeviceResolution_iPhoneRetina4;
            }
            else if (pixelHeight == 1136.0f) {
                return UIDeviceResolution_iPhoneRetina5;
            }
            else if (pixelHeight == 1334.0f) {
                return UIDeviceResolution_iPhoneRetina6;
            }
            else if (pixelHeight == 1792.0f) {
                return UIDeviceResolution_iPhoneRetinaXR;
            }
        }
        else if (scale == 1.0f) {
            if (pixelHeight == pixelHeight == 480.0f) {
                return UIDeviceResolution_iPhoneStandard;
            }
        }
        else if (scale == 3.0f) {
            if (pixelHeight == 2208.0f) {
                return UIDeviceResolution_iPhoneRetina6p;
            }
            else if (pixelHeight == 2436) {
                return UIDeviceResolution_iPhoneRetinaX;
            }
            else if (pixelHeight == 2688) {
                return UIDeviceResolution_iPhoneRetinaXMax;
            }
        }
    }
    else {
        if (scale == 2.0f && pixelHeight == 2048.0f) {
            return UIDeviceResolution_iPadRetina;
        }
        else if (scale == 1.0f && pixelHeight == 1024.0f) {
            return UIDeviceResolution_iPadStandard;
        }
    }
    
    return UIDeviceResolution_Unknown;
}

+ (CGSize)screenSize {
    UIScreen *mainScreen = [UIScreen mainScreen];
    CGFloat scale = ([mainScreen respondsToSelector:@selector(scale)] ? mainScreen.scale : 1.0f);
    CGFloat pixelHeight = (CGRectGetHeight(mainScreen.bounds) * scale);
    CGFloat pixelWidth = (CGRectGetWidth(mainScreen.bounds) * scale);
    
    return CGSizeMake(pixelWidth, pixelHeight);
}

@end
