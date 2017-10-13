//
//  HWHttpsRequester.h
//  indentify
//
//  Created by administrator on 16/7/25.
//  Copyright © 2016年 双向认证. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CompletionHandler) (NSData *responseData, NSError *error);

@interface SVHttpsRequester : NSObject <NSURLConnectionDelegate, NSURLConnectionDataDelegate>

/**
 *  访问https协议的urlString网址,并通过completionHandler Block回调函数对结果进行处理
 *
 *  @param urlString Https协议URL的字符串
 *  @param completionHandler Block回调函数对结果进行处理
 *
 *  @return HWHttpsRequester Https协议网址访问器
 */
+ (id)requestData:(NSString *)urlString completionHandler:(CompletionHandler)completionHandler;


/**
 *  访问https协议的urlString网址, 并通过completionHandler Block回调函数对结果进行处理.
 *  通过设置useCert属性确定是否使用自定义证书进行验证.
 *
 *  @param urlString Https协议URL的字符串
 *  @param useCert TRUE|YES 使用自定义证书进行验证.  FALSE|NO 忽略证书验证
 *  @param completionHandler Block回调函数对结果进行处理
 *
 *  @return HWHttpsRequester Https协议网址访问器
 */
+ (id)requestData:(NSString *)urlString
         WithCert:(BOOL)useCert
completionHandler:(CompletionHandler)completionHandler;

/**
 *  访问https协议的urlString网址, 并通过completionHandler Block回调函数对结果进行处理.
 *  通过 timeout 设置请求超时时间
 *
 *  @param urlString Https协议URL的字符串
 *  @param timeout 请求超时时间
 *  @param completionHandler Block回调函数对结果进行处理
 *
 *  @return HWHttpsRequester Https协议网址访问器
 */
+ (id)requestData:(NSString *)urlString
          timeout:(int)timeout
completionHandler:(CompletionHandler)completionHandler;

/**
 *  访问https协议的urlString网址, 并通过completionHandler Block回调函数对结果进行处理.
 *  通过设置useCert属性确定是否使用自定义证书进行验证. 通过 timeout 设置请求超时时间
 *
 *  @param urlString Https协议URL的字符串
 *  @param timeout 请求超时时间
 *  @param useCert TRUE|YES 使用自定义证书进行验证.  FALSE|NO 忽略证书验证
 *  @param completionHandler Block回调函数对结果进行处理
 *
 *  @return HWHttpsRequester Https协议网址访问器
 */
+ (id)requestData:(NSString *)urlString
          timeout:(int)timeout
         WithCert:(BOOL)useCert
completionHandler:(CompletionHandler)completionHandler;

/**
 *  将data对象通过https协议发送到urlString指定的服务器地址,并通过completionHandler
 *  Block回调函数对结果进行处理
 *
 *  @param urlString Https协议URL的字符串
 *  @param data 发送到服务器的数据
 *  @param completionHandler Block回调函数对结果进行处理
 *
 *  @return HWHttpsRequester Https协议网址访问器
 */
+ (id)sendDataToServer:(NSString *)urlString
                  data:(NSData *)data
     completionHandler:(CompletionHandler)completionHandler;

/**
 *  将data对象通过https协议发送到urlString指定的服务器地址,并通过completionHandler
 *  Block回调函数对结果进行处理. 通过设置useCert属性确定是否使用自定义证书进行验证.
 *
 *  @param urlString Https协议URL的字符串
 *  @param data 发送到服务器的数据
 *  @param useCert TRUE|YES 使用自定义证书进行验证.  FALSE|NO 忽略证书验证
 *  @param completionHandler Block回调函数对结果进行处理
 *
 *  @return HWHttpsRequester Https协议网址访问器
 */
+ (id)sendDataToServer:(NSString *)urlString
                  data:(NSData *)data
              WithCert:(BOOL)useCert
     completionHandler:(CompletionHandler)completionHandler;

/**
 *  将data对象通过https协议发送到urlString指定的服务器地址,并通过completionHandler
 *  Block回调函数对结果进行处理. 通过 timeout 设置请求超时时间
 *
 *  @param urlString Https协议URL的字符串
 *  @param data 发送到服务器的数据
 *  @param timeout 请求超时时间
 *  @param completionHandler Block回调函数对结果进行处理
 *
 *  @return HWHttpsRequester Https协议网址访问器
 */
+ (id)sendDataToServer:(NSString *)urlString
                  data:(NSData *)data
               timeout:(int)timeout
     completionHandler:(CompletionHandler)completionHandler;

/**
 *  将data对象通过https协议发送到urlString指定的服务器地址,并通过completionHandler
 *  Block回调函数对结果进行处理. 通过设置useCert属性确定是否使用自定义证书进行验证. 通过 timeout
 *  设置请求超时时间
 *
 *  @param urlString Https协议URL的字符串
 *  @param data 发送到服务器的数据
 *  @param timeout 请求超时时间
 *  @param useCert TRUE|YES 使用自定义证书进行验证.  FALSE|NO 忽略证书验证
 *  @param completionHandler Block回调函数对结果进行处理
 *
 *  @return HWHttpsRequester Https协议网址访问器
 */
+ (id)sendDataToServer:(NSString *)urlString
                  data:(NSData *)data
               timeout:(int)timeout
              WithCert:(BOOL)useCert
     completionHandler:(CompletionHandler)completionHandler;

/**
 *  通过https协议上传文件指定的服务器地址,并通过completionHandler
 *  Block回调函数对结果进行处理. 通过设置useCert属性确定是否使用自定义证书进行验证.
 *
 *  @param request NSURLRequest
 *  @param useCert TRUE|YES 使用自定义证书进行验证.  FALSE|NO 忽略证书验证
 *  @param completionHandler Block回调函数对结果进行处理
 *
 *  @return HWHttpsRequester Https协议网址访问器
 */
+ (id)uploadFile:(NSURLRequest *)request
         WithCert:(BOOL)useCert
completionHandler:(CompletionHandler)completionHandler;

@end
