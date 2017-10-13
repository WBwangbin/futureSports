//
//  SVSyncHttpsRequester.m
//  SpeedPro
//
//  Created by SQM on 16/8/3.
//  Copyright © 2016年 Huawei. All rights reserved.
//

#import "SVSyncHttpsRequester.h"
#import "SVTimeUtil.h"

@implementation SVSyncHttpsRequester
{
    BOOL isFinished;
    NSError *err;
}


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
- (NSData *)requestData:(NSString *)urlString timeout:(int)timeout WithCert:(BOOL)useCert
{
    NSLog (@"start request url = %@ ", urlString);

    __block NSData *resultData = [[NSData alloc] init];

    [SVHttpsRequester
          requestData:urlString
              timeout:timeout
             WithCert:useCert
    completionHandler:^(NSData *responseData, NSError *error) {
      if (error)
      {
          NSLog (@"request url[%@] fail, error:%@", urlString, error);
      }

      resultData = responseData;
      err = error;

      [self performSelectorOnMainThread:@selector (setEnd) withObject:nil waitUntilDone:NO];

    }];

    while (!isFinished)
    {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }


    return resultData;
}

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
- (NSData *)requestData:(NSString *)urlString
                timeout:(int)timeout
               WithCert:(BOOL)useCert
      completionHandler:(CompletionHandler)completionHandler
{
    __block NSData *resultData = [[NSData alloc] init];
    [SVHttpsRequester
          requestData:urlString
              timeout:timeout
             WithCert:useCert
    completionHandler:^(NSData *responseData, NSError *error) {
      if (error)
      {
          NSLog (@"request url[%@] fail, error:%@", urlString, error);
      }

      resultData = responseData;
      err = error;

      [self performSelectorOnMainThread:@selector (setEnd) withObject:nil waitUntilDone:NO];

    }];

    while (!isFinished)
    {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }

    completionHandler (resultData, err);
    return resultData;
}

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
- (NSData *)sendDataToServer:(NSString *)urlString
                        data:(NSData *)data
                     timeout:(int)timeout
                    WithCert:(BOOL)useCert
{
    __block NSData *resultData = [[NSData alloc] init];
    [SVHttpsRequester
     sendDataToServer:urlString
                 data:data
              timeout:timeout
             WithCert:useCert
    completionHandler:^(NSData *responseData, NSError *error) {
      if (error)
      {
          NSLog (@"request url[%@] fail, error:%@", urlString, error);
      }

      resultData = responseData;
      err = error;

      [self performSelectorOnMainThread:@selector (setEnd) withObject:nil waitUntilDone:NO];
    }];

    while (!isFinished)
    {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }

    return resultData;
}

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
- (NSData *)sendDataToServer:(NSString *)urlString
                        data:(NSData *)data
                     timeout:(int)timeout
                    WithCert:(BOOL)useCert
           completionHandler:(CompletionHandler)completionHandler
{

    __block NSData *resultData = [[NSData alloc] init];
    [SVHttpsRequester
     sendDataToServer:urlString
                 data:data
              timeout:timeout
             WithCert:useCert
    completionHandler:^(NSData *responseData, NSError *error) {
      if (error)
      {
          NSLog (@"request url[%@] fail, error:%@", urlString, error);
      }

      resultData = responseData;
      err = error;

      [self performSelectorOnMainThread:@selector (setEnd) withObject:nil waitUntilDone:NO];
    }];

    while (!isFinished)
    {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }

    completionHandler (resultData, err);
    return resultData;
}

- (void)setEnd
{
    isFinished = YES;
}
- (void)reset
{
    isFinished = NO;
}


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
- (NSData *)uploadFile:(NSURLRequest *)request
              WithCert:(BOOL)useCert
     completionHandler:(CompletionHandler)completionHandler
{
    __block NSData *resultData = [[NSData alloc] init];
    [SVHttpsRequester
           uploadFile:request
             WithCert:useCert
    completionHandler:^(NSData *responseData, NSError *error) {

      if (error)
      {

          NSLog (@"request url[%@] fail, error:%@", [request.URL absoluteString], error);
      }

      resultData = responseData;
      err = error;

      [self performSelectorOnMainThread:@selector (setEnd) withObject:nil waitUntilDone:NO];
    }];

    while (!isFinished)
    {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }

    completionHandler (resultData, err);
    return resultData;
}


@end
