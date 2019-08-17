//
//  UIDevice+LYCocoaDevKit.m
//  LYCocoaDevKit
//
//  Created by Polly polly on 8/17/19.
//  Copyright © 2019 zhangliyong. All rights reserved.
//

#import "UIDevice+LYCocoaDevKit.h"
#import <SystemConfiguration/CaptiveNetwork.h>
#import <sys/utsname.h>
#import "KeychainItemWrapper.h"
#import "NSString+LYCocoaDevKit.h"

NSString  *const kDeviceIDKey = @"com.cybertecho.uuid";
NSUInteger const md5CodeLength = 5;
NSUInteger const firstLength = 8;
NSUInteger const secondLength = 10;

@implementation UIDevice (LYCocoaDevKit)

+ (NSString *)osPlatform {
    return [[UIDevice currentDevice] systemName];
}

+ (NSString *)osModel {
    struct utsname name;
    uname(&name);
    
    NSString *model = [NSString stringWithFormat:@"%s", name.machine];
    if ([model isEqualToString:@"iPod5,1"]) {
        return @"iPod Touch 5";
    }
    else if ([model isEqualToString:@"iPod7,1"]) {
        return @"iPod Touch 6";
    }
    else if ([model isEqualToString:@"iPhone3,1"] || [model isEqualToString:@"iPhone3,2"] || [model isEqualToString:@"iPhone3,3"]) {
        return @"iPhone 4";
    }
    else if ([model isEqualToString:@"iPhone4,1"]) {
        return @"iPhone 4s";
    }
    else if ([model isEqualToString:@"iPhone5,1"] || [model isEqualToString:@"iPhone5,2"]) {
        return @"iPhone 5";
    }
    else if ([model isEqualToString:@"iPhone5,3"] || [model isEqualToString:@"iPhone5,4"]) {
        return @"iPhone 5c";
    }
    else if ([model isEqualToString:@"iPhone6,1"] || [model isEqualToString:@"iPhone6,2"]) {
        return @"iPhone 5s";
    }
    else if ([model isEqualToString:@"iPhone7,2"]) {
        return @"iPhone 6";
    }
    else if ([model isEqualToString:@"iPhone7,1"]) {
        return @"iPhone 6 Plus";
    }
    else if ([model isEqualToString:@"iPhone8,1"]) {
        return @"iPhone 6s";
    }
    else if ([model isEqualToString:@"iPhone8,2"]) {
        return @"iPhone 6s Plus";
    }
    else if ([model isEqualToString:@"iPhone9,1"] || [model isEqualToString:@"iPhone9,3"]) {
        return @"iPhone 7";
    }
    else if ([model isEqualToString:@"iPhone9,2"] || [model isEqualToString:@"iPhone9,4"]) {
        return @"iPhone 7 Plus";
    }
    else if ([model isEqualToString:@"iPhone8,4"]) {
        return @"iPhone SE";
    }
    else if ([model isEqualToString:@"iPhone10,1"] || [model isEqualToString:@"iPhone10,4"]) {
        return @"iPhone 8";
    }
    else if ([model isEqualToString:@"iPhone10,2"] || [model isEqualToString:@"iPhone10,5"]) {
        return @"iPhone 8 Plus";
    }
    else if ([model isEqualToString:@"iPhone10,3"] || [model isEqualToString:@"iPhone10,6"]) {
        return @"iPhone X";
    }
    else if ([model isEqualToString:@"iPhone11,8"]) {
        return @"iPhone XR";
    }
    else if ([model isEqualToString:@"iPhone11,2"]) {
        return @"iPhone XS";
    }
    else if ([model isEqualToString:@"iPhone11,6"] || [model isEqualToString:@"iPhone11,4"]) {
        return @"iPhone XS Max";
    }
    else {
        return @"Simulator";
    }
}

+ (NSString *)osVersion {
    return [[UIDevice currentDevice] systemVersion];
}

+ (NSString *)WiFiSSID {
    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    for (NSString *ifnam in ifs) {
        id info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        return [[ NSString alloc] initWithData:info[@"SSIDDATA"] encoding:NSUTF8StringEncoding];
    }
    
    return nil;
}

+ (NSString *)WiFiBSSID {
    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    for (NSString *ifnam in ifs) {
        id info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        return info[@"BSSID"];
    }
    
    return nil;
}

+ (NSString *)appVersion {
    NSDictionary *info = [NSBundle mainBundle].infoDictionary;
    return [info objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)appBuildVersion {
    NSDictionary *info = [NSBundle mainBundle].infoDictionary;
    return [info objectForKey:(__bridge NSString *)kCFBundleVersionKey];
}

+ (NSString *)deviceID {
    NSString *deviceID = nil;
    
    KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:kDeviceIDKey accessGroup:nil];
    NSString *deviceID1 = [keychainItem objectForKey:(id)kSecValueData];
    
    NSString *deviceID2 = nil;
    UIPasteboard *pasteboard = [UIPasteboard pasteboardWithName:kDeviceIDKey create:YES];
    NSData *data = [pasteboard valueForPasteboardType:kDeviceIDKey];
    if(data && [data isKindOfClass:[NSData class]]) {
        deviceID2 = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    
    if (deviceID1.length == 0 && deviceID2.length == 0) {
        deviceID = [self generatorDeviceId];
        
        [keychainItem setObject:kDeviceIDKey forKey:(id)kSecAttrAccount];
        [keychainItem setObject:deviceID forKey:(id)kSecValueData];
        
        [pasteboard setValue:deviceID forPasteboardType:kDeviceIDKey];
        return deviceID;
    }
    
    BOOL deviceIdAvailable1 = [self checkDeviceIdAvailable:deviceID1];
    BOOL deviceIdAvailable2 = [self checkDeviceIdAvailable:deviceID2];
    
    NSString *uniqueIdentifier = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    if([deviceID1 hasPrefix:uniqueIdentifier]) {
        [pasteboard setValue:deviceID1 forPasteboardType:kDeviceIDKey];
        
        return deviceID1;
    }
    
    if([deviceID2 hasPrefix:uniqueIdentifier]) {
        [keychainItem setObject:kDeviceIDKey forKey:(id)kSecAttrAccount];
        [keychainItem setObject:deviceID2 forKey:(id)kSecValueData];
        return deviceID2;
    }
    
    if(deviceIdAvailable1 && deviceIdAvailable2) {
        if ([deviceID1 isEqualToString:deviceID2]) {
            return deviceID1;
        }
        else {
            [keychainItem setObject:kDeviceIDKey forKey:(id)kSecAttrAccount];
            [keychainItem setObject:deviceID2 forKey:(id)kSecValueData];
            
            return deviceID2;
        }
    }
    else if (deviceIdAvailable1 && !deviceIdAvailable2) {
        [pasteboard setValue:deviceID1 forPasteboardType:kDeviceIDKey];
        return deviceID1;
    }
    else if (!deviceIdAvailable1 && deviceIdAvailable2) {
        [keychainItem setObject:kDeviceIDKey forKey:(id)kSecAttrAccount];
        [keychainItem setObject:deviceID2 forKey:(id)kSecValueData];
        return deviceID2;
    }
    else {
        deviceID = [self generatorDeviceId];
        [keychainItem setObject:kDeviceIDKey forKey:(id)kSecAttrAccount];
        [keychainItem setObject:deviceID forKey:(id)kSecValueData];
        [pasteboard setValue:deviceID forPasteboardType:kDeviceIDKey];
        
        return deviceID;
    }
    
    return nil;
}

+ (NSString *)generatorDeviceId {
    NSString *uniqueIdentifier = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    return [self encryptUUID:uniqueIdentifier];
}

+ (NSString *)encryptUUID:(NSString *)uuid {
    if(uuid.length>20) {
        NSString *subString1 = [uuid substringToIndex:firstLength];
        NSString *subString2 = [uuid substringToIndex:secondLength];
        subString1 = subString1.MD5;
        subString2 = subString2.MD5;
        
        NSString *combineString = [subString1 stringByAppendingString:subString2];
        NSString *md5 = combineString.MD5;
        if(md5.length >= md5CodeLength) {
            md5 = [md5 substringToIndex:md5CodeLength-1];
            return [uuid stringByAppendingFormat:@"-%@", md5];
        }
    }
    
    return uuid;
}

+ (BOOL)checkDeviceIdAvailable:(NSString *)deviceId {
    if(deviceId.length > md5CodeLength) {
        NSString *uuid = [deviceId substringToIndex:deviceId.length-md5CodeLength];
        NSString *encrypt = [self encryptUUID:uuid];
        
        if ([encrypt isEqualToString:deviceId] && ![encrypt isEqualToString:uuid]) {
            return YES;
        }
    }
    
    return NO;
}

@end
