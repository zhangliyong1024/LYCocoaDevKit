//
//  NSString+LYCocoaDevKit.h
//  LYCocoaDevKit
//
//  Created by Polly polly on 8/17/19.
//  Copyright © 2019 zhangliyong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (LYCocoaDevKit)

- (NSString *)stringByLeftTrimmingCharactersInSet:(NSCharacterSet *)set;

- (NSString *)stringByRightTrimmingCharactersInSet:(NSCharacterSet *)set;

- (NSString *)phoneNumberStyledString;

- (NSString *)MD5;

- (NSString *)MD5InShort;

- (NSString *)sha1;

- (NSString *)hmacWithKey:(NSString *)key;

- (BOOL)isValidPhoneNumber;

- (BOOL)isValidMobileNumber;

- (BOOL)isValidIdNumber;

- (NSString *)pinyin;

- (NSInteger)pinyinDiffWithString:(NSString *)string;

- (NSArray *)wordComponentsWithLimit:(NSInteger)limit;

- (UIImage *)qrImage;

- (NSString *)ossUrlStringResized:(CGSize)size;

- (NSString *)ossUrlStringResized:(CGSize)size mode:(UIViewContentMode)mode;

- (NSString *)ossUrlStringRound;

- (NSString *)ossUrlStringJpegFormatted;

- (NSString *)ossUrlStringPngFormatted;

- (NSString *)ossUrlStringRoundWithSize:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
