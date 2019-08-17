//
//  UIButton+LYCocoaDevKit.m
//  LYCocoaDevKit
//
//  Created by Polly polly on 8/17/19.
//  Copyright © 2019 zhangliyong. All rights reserved.
//

#import "UIButton+LYCocoaDevKit.h"
#import "UIImage+LYCocoaDevKit.h"

@implementation UIButton (LYCocoaDevKit)

+ (instancetype)buttonWithTitleColor:(UIColor *)titleColor
                     backgroundColor:(UIColor *)backgroundColor
                         cornerRadii:(CGSize)cornerRadii {
    return [self buttonWithTitleColor:titleColor
                      backgroundColor:backgroundColor
                          borderColor:nil
                          cornerRadii:cornerRadii];
}

+ (instancetype)buttonWithTitleColor:(UIColor *)titleColor
                     backgroundColor:(UIColor *)backgroundColor
                         borderColor:(UIColor *)borderColor
                         cornerRadii:(CGSize)cornerRadii {
    UIButton *btn = [self buttonWithType:UIButtonTypeCustom];
    
    [btn setTitleColor:titleColor
       backgroundColor:backgroundColor
           borderColor:borderColor
           cornerRadii:cornerRadii];
    
    return btn;
}

- (void)setTitleColor:(UIColor *)titleColor
      backgroundColor:(UIColor *)backgroundColor
          borderColor:(UIColor *)borderColor
          cornerRadii:(CGSize)cornerRadii {
    
    [self setTitleColor:titleColor forState:UIControlStateNormal];
    
    if (backgroundColor) {
        CGSize imgSize = CGSizeMake(cornerRadii.width * 2, cornerRadii.height * 2);
        UIImage *image = [[UIImage imageWithColor:backgroundColor
                                             size:imgSize
                                byRoundingCorners:UIRectCornerAllCorners
                                      cornerRadii:cornerRadii] stretchableImageWithLeftCapWidth:cornerRadii.width topCapHeight:cornerRadii.height];
        
        [self setBackgroundImage:image forState:UIControlStateNormal];
    }
    
    CALayer *layer = self.layer;
    if (borderColor) {
        layer.borderColor = borderColor.CGColor;
        layer.borderWidth = 1;
        layer.cornerRadius = cornerRadii.height;
    }
    else {
        layer.borderWidth = .0;
        layer.borderColor = [UIColor clearColor].CGColor;
    }
}

@end
