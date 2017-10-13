//
//  ApiTool.h
//  FutureSports
//
//  Created by wangbin on 2017/9/28.
//  Copyright © 2017年 wangbin. All rights reserved.
//


/**
 *** 网络请求管理类AFN
 **/

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface ApiTool : NSObject

+ (instancetype _Nullable )shareApiTool;

//get请求
- (void)get:(NSString *_Nullable)url params:(NSDictionary *_Nullable)params success:(void(^_Nullable)(NSDictionary * _Nullable jsonDic))success    failure:(void(^_Nullable)(NSError * _Nullable error))failure;

//post请求
- (void)post:(NSString *_Nullable)url params:(NSDictionary *_Nullable)params success:(void(^_Nullable)(NSDictionary * _Nullable jsonDic))success    failure:(void(^_Nullable)(NSError * _Nullable error))failure;

//put请求
- (void)put:(NSString *_Nullable)url params:(NSDictionary *_Nullable)params success:(void(^_Nullable)(NSDictionary * _Nullable jsonDic))success failure:(void(^_Nullable)(NSError * _Nullable error))failure;

//upLoadImage
- (NSURLSessionDataTask *_Nullable)upLoadImage:(NSString *_Nullable)url params:(NSDictionary *_Nullable)params upLoadImage:(UIImage *_Nullable)image progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress success:(void (^_Nullable)(NSDictionary * _Nullable jsonDic))success failure:(void (^_Nullable)(NSError * _Nullable error))failure;


@end
