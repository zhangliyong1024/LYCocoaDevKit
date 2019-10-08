//
//  UIView+LYCocoaDevKit.h
//  LYCocoaDevKit
//
//  Created by Polly polly on 10/8/19.
//  Copyright © 2019 zhangliyong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (LYCocoaDevKit)

- (UIView *)firstResponder;
- (void)shakeView;

@end

NS_ASSUME_NONNULL_END
