//
//  UIColor+LYCocoaDevKit.m
//  LYCocoaDevKit
//
//  Created by Polly polly on 8/17/19.
//  Copyright © 2019 zhangliyong. All rights reserved.
//

#import "UIColor+LYCocoaDevKit.h"

@implementation UIColor (LYCocoaDevKit)

+ (instancetype)colorFromHex:(long long)hex {
    return [UIColor colorWithRed:((double)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)((hex & 0xFF) >> 0))/255.0 alpha:1];
}

+ (instancetype)colorAlphaFromHex:(long long)hex {
    return [UIColor colorWithRed:((double)((hex & 0xFF000000) >> 24))/255.0 green:((float)((hex & 0xFF0000) >> 16))/255.0 blue:((float)((hex & 0xFF00) >> 8))/255.0 alpha:((float)(hex & 0xFF))/255.0];
}

+ (instancetype)colorFromString:(NSString *)string {
    if (string.length == 0) {
        return nil;
    }
    
    if (![string containsString:@"0x"]) {
        string = [@"0x" stringByAppendingString:string];
    }
    
    if (string.length == 8) {
        long long value = 0;
        sscanf([string cStringUsingEncoding:NSASCIIStringEncoding], "%llx", &value);
        return [UIColor colorFromHex:value];
    }
    
    return nil;
}

+ (instancetype)colorAlphaFromString:(NSString *)string {
    if (string.length == 0) {
        return nil;
    }
    
    if (![string containsString:@"0x"]) {
        string = [@"0x" stringByAppendingString:string];
    }
    
    if (string.length == 10) {
        long long value = 0;
        sscanf([string cStringUsingEncoding:NSASCIIStringEncoding], "%llx", &value);
        
        return [UIColor colorAlphaFromHex:value];
    }
    
    return nil;
}

- (NSString *)hexStringWithAlpha:(BOOL)alpha {
    CGFloat red, green, blue, a;
    [self getRed:&red green:&green blue:&blue alpha:&a];
    
    NSString *string = @"0x";
    string = [string stringByAppendingString:[NSString stringWithFormat:@"%02X", (unsigned int)(red * 255)]];
    string = [string stringByAppendingString:[NSString stringWithFormat:@"%02X", (unsigned int)(green * 255)]];
    string = [string stringByAppendingString:[NSString stringWithFormat:@"%02X", (unsigned int)(blue * 255)]];
    if (alpha) {
        string = [string stringByAppendingString:[NSString stringWithFormat:@"%02X", (unsigned int)(a * 255)]];
    }
    
    return string;
}

- (UIColor *)colorWithMinimumSaturation:(CGFloat)saturation {
    if (!self)
        return nil;
    
    CGFloat h, s, b, a;
    [self getHue:&h saturation:&s brightness:&b alpha:&a];
    
    if (s < saturation)
        return [UIColor colorWithHue:h saturation:saturation brightness:b alpha:a];
    
    return self;
}

@end
