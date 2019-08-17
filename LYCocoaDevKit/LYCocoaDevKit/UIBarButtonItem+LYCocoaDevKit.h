//
//  UIBarButtonItem+LYCocoaDevKit.h
//  LYCocoaDevKit
//
//  Created by Polly polly on 8/17/19.
//  Copyright © 2019 zhangliyong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (LYCocoaDevKit)

@property (atomic)          BOOL        badgeDot;
@property (nonatomic, copy) NSString    *badgeValue;

@end

NS_ASSUME_NONNULL_END
