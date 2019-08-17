//
//  CommonInterface.h
//  LYCocoaDevKit
//
//  Created by Polly polly on 8/17/19.
//  Copyright © 2019 zhangliyong. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

typedef NS_ENUM(NSUInteger, HttpMethod) {
    HttpGet,
    HttpPost,
    HttpPut,
    HttpDelete,
    HttpHead
};

#define NSLog(FORMAT, ...) printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

NS_ASSUME_NONNULL_BEGIN

@interface CommonInterface : AFHTTPSessionManager

+ (instancetype)sharedClient;

- (nullable NSURLSessionTask *)doWithMethod:(HttpMethod)method
                                  urlString:(NSString *)urlString
                                    headers:(nullable NSDictionary *)headers
                                 parameters:(nullable NSDictionary *)parameters
                  constructingBodyWithBlock:(nullable void (^)(id <AFMultipartFormData> formData))constructingBlock
                                   progress:(nullable void (^)(NSProgress *progress))progress
                                    success:(nullable void (^)(NSURLSessionDataTask *task, NSDictionary * _Nullable responseObject))success
                                    failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure;

@end

NS_ASSUME_NONNULL_END

