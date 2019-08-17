//
//  CommonInterface.m
//  LYCocoaDevKit
//
//  Created by Polly polly on 8/17/19.
//  Copyright © 2019 zhangliyong. All rights reserved.
//

#import "CommonInterface.h"

@interface InterfaceLogger : NSObject

@end

@implementation InterfaceLogger

+ (instancetype)sharedClient {
    static dispatch_once_t onceToken;
    static InterfaceLogger *client = nil;
    dispatch_once(&onceToken, ^{
        client = [InterfaceLogger new];
    });
    
    return client;
}

- (instancetype)init {
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(AFNetworkingTaskDidResume:)
                                                     name:AFNetworkingTaskDidResumeNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(AFNetworkingTaskDidComplete:)
                                                     name:AFNetworkingTaskDidCompleteNotification
                                                   object:nil];
    }
    
    return self;
}

- (void)AFNetworkingTaskDidResume:(NSNotification *)noti {
    NSURLSessionTask *task = noti.object;
    NSURLRequest *request = task.originalRequest;
    
    NSLog(@"%@ %@", request.HTTPMethod, request.URL);
    
    NSData *headerData = [NSJSONSerialization dataWithJSONObject:request.allHTTPHeaderFields options:NSJSONWritingPrettyPrinted error:nil];
    NSString *prettyPrintedHeader = [[[NSString alloc] initWithData:headerData encoding:NSUTF8StringEncoding] stringByReplacingOccurrencesOfString:@" : " withString:@": "];
    
    if (request.HTTPBody.length) {
        id jsonObject = [NSJSONSerialization JSONObjectWithData:request.HTTPBody options:0 error:nil];
        if (jsonObject) {
            NSData *prettyJsonData = [NSJSONSerialization dataWithJSONObject:jsonObject options:NSJSONWritingPrettyPrinted error:nil];
            NSString *prettyPrintedJson = [[[NSString alloc] initWithData:prettyJsonData encoding:NSUTF8StringEncoding] stringByReplacingOccurrencesOfString:@" : " withString:@": "];
            
            NSLog(@"headers: %@, parameters: %@", prettyPrintedHeader, prettyPrintedJson);
        }
        else {
            NSLog(@"headers: %@, parameters: %@", prettyPrintedHeader, [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding]);
        }
    }
    else {
        NSLog(@"headers: %@", prettyPrintedHeader);
    }
}

- (void)AFNetworkingTaskDidComplete:(NSNotification *)noti {
    NSURLSessionTask *task = noti.object;
    NSURLRequest *request = task.originalRequest;
    
    NSError *error = noti.userInfo[AFNetworkingTaskDidCompleteErrorKey];
    NSData *data = noti.userInfo[AFNetworkingTaskDidCompleteResponseDataKey];
    if (error) {
        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if (string.length > 1) {
            string = [string substringToIndex:MIN(string.length - 1, 4096)];
        }
        NSLog(@"%@ %@ error:\n%@\ndata: %@", request.HTTPMethod, request.URL, [error localizedDescription], string);
    }
    else {
        NSString *string = request.allHTTPHeaderFields[@"request-time"];
        NSTimeInterval interval = [NSDate date].timeIntervalSince1970 - string.doubleValue;
        id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        if (jsonObject) {
            NSData *prettyJsonData = [NSJSONSerialization dataWithJSONObject:jsonObject options:NSJSONWritingPrettyPrinted error:nil];
            NSString *prettyPrintedJson = [[[NSString alloc] initWithData:prettyJsonData encoding:NSUTF8StringEncoding] stringByReplacingOccurrencesOfString:@" : " withString:@": "];
            
            NSLog(@"%@ %@ elapsed: %0.3fs size: %lu Bytes returns:\n%@", request.HTTPMethod, request.URL, interval, (unsigned long)data.length, prettyPrintedJson);
        }
        else {
            NSLog(@"%@ %@ elapsed: %0.3fs size: %lu Bytes returns: null", request.HTTPMethod, request.URL, interval, (unsigned long)data.length);
        }
    }
}

@end

@implementation CommonInterface

+ (instancetype)sharedClient {
    NSAssert(NO, @"should implemented in your sub-class");
    return nil;
}

- (instancetype)initWithBaseURL:(NSURL *)url sessionConfiguration:(NSURLSessionConfiguration *)configuration {
    [InterfaceLogger sharedClient];
    
    return [super initWithBaseURL:url sessionConfiguration:configuration];
}

- (nullable NSURLSessionTask *)doWithMethod:(HttpMethod)method
                                  urlString:(NSString *)urlString
                                    headers:(NSDictionary *)headers
                                 parameters:(NSDictionary *)parameters
                  constructingBodyWithBlock:(void (^)(id<AFMultipartFormData> _Nonnull))constructingBlock
                                   progress:(void (^)(NSProgress * _Nonnull))progress
                                    success:(void (^)(NSURLSessionDataTask * _Nonnull, NSDictionary * _Nullable))success
                                    failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure {
    
    [headers enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [self.requestSerializer setValue:obj forHTTPHeaderField:key];
    }];
    
    [self.requestSerializer setValue:[NSString stringWithFormat:@"%0.3f", [NSDate date].timeIntervalSince1970] forHTTPHeaderField:@"request-time"];
    
    if (method == HttpPost) {
        if (constructingBlock) {
            return [self POST:urlString
                   parameters:parameters
    constructingBodyWithBlock:constructingBlock
                     progress:progress
                      success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                          if (success) {
                              success(task, responseObject);
                          }
                      }
                      failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                          if (failure) {
                              failure(task, error);
                          }
                      }];
        }
        else {
            return [self POST:urlString
                   parameters:parameters
                     progress:progress
                      success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                          if (success) {
                              success(task, responseObject);
                          }
                      }
                      failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                          if (failure) {
                              failure(task, error);
                          }
                      }];
        }
    }
    else if (method == HttpPut) {
        return [self PUT:urlString
              parameters:parameters
                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                     if (success) {
                         success(task, responseObject);
                     }
                 }
                 failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                     if (failure) {
                         failure(task, error);
                     }
                 }];
    }
    else if (method == HttpDelete) {
        return [self DELETE:urlString
                 parameters:parameters
                    success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        if (success) {
                            success(task, responseObject);
                        }
                    }
                    failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        if (failure) {
                            failure(task, error);
                        }
                    }];
    }
    else if (method == HttpGet) {
        return [self GET:urlString
              parameters:parameters
                progress:progress
                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                     if (success) {
                         success(task, responseObject);
                     }
                 }
                 failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                     if (failure) {
                         failure(task, error);
                     }
                 }];
    }
    
    NSAssert(NO, @"method error");
    return nil;
}

@end
