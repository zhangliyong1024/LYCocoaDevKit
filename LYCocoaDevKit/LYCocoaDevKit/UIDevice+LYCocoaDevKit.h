//
//  UIDevice+LYCocoaDevKit.h
//  LYCocoaDevKit
//
//  Created by Polly polly on 8/17/19.
//  Copyright © 2019 zhangliyong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (LYCocoaDevKit)

+ (NSString *)osPlatform;

+ (NSString *)osModel;

+ (NSString *)osVersion;

+ (NSString *)WiFiSSID;

+ (NSString *)WiFiBSSID;

+ (NSString *)appVersion;

+ (NSString *)appBuildVersion;

+ (NSString *)deviceID;

@end

NS_ASSUME_NONNULL_END
