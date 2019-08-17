//
//  UITableViewCell+LYCocoaDevKit.m
//  LYCocoaDevKit
//
//  Created by Polly polly on 8/17/19.
//  Copyright © 2019 zhangliyong. All rights reserved.
//

#import "UITableViewCell+LYCocoaDevKit.h"

@implementation UITableViewCell (LYCocoaDevKit)

+ (NSString *)reuseIdentifier {
    return NSStringFromClass(self);
}

@end
