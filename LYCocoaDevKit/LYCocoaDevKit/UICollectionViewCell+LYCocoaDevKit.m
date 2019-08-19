//
//  UICollectionViewCell+LYCocoaDevKit.m
//  LYCocoaDevKit
//
//  Created by Polly polly on 8/19/19.
//  Copyright © 2019 zhangliyong. All rights reserved.
//

#import "UICollectionViewCell+LYCocoaDevKit.h"

@implementation UICollectionViewCell (LYCocoaDevKit)

+ (NSString *)reuseIdentifier {
    return NSStringFromClass(self);
}

@end
