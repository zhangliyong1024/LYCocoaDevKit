//
//  UIView+LYCocoaDevKit.m
//  LYCocoaDevKit
//
//  Created by Polly polly on 10/8/19.
//  Copyright © 2019 zhangliyong. All rights reserved.
//

#import "UIView+LYCocoaDevKit.h"

@implementation UIView (LYCocoaDevKit)

- (UIView *)firstResponder {
    if ([self isFirstResponder]) {
        return self;
    }
    
    for (UIView *item in self.subviews) {
        if ([item isFirstResponder]) {
            return item;
        }
    }
    
    return nil;
}

- (void)shakeView {
    CALayer *viewLayer = self.layer;
    CGPoint position = viewLayer.position;
    CGPoint x = CGPointMake(position.x + 10, position.y);
    CGPoint y = CGPointMake(position.x - 10, position.y);
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [animation setFromValue:[NSValue valueWithCGPoint:x]];
    [animation setToValue:[NSValue valueWithCGPoint:y]];
    
    [animation setAutoreverses:YES];
    [animation setDuration:.05];
    [animation setRepeatCount:3];
    
    [viewLayer addAnimation:animation forKey:nil];
}

@end
