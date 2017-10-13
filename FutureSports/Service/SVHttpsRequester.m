//
//  HWHttpsRequester.m
//  indentify
//
//  Created by administrator on 16/7/25.
//  Copyright © 2016年 双向认证. All rights reserved.
//

#import "NSString+AES256.h"
#import "SVHttpsRequester.h"

#import "SVTimeUtil.h"
static NSString *const PARAM_KEY = @"param";
static NSString *const KEY_KEY = @"Key";

#define DEFAULT_CONNECT_TIMEOUT 30
#define DEFAULT_BOUNDARYSTR @"--"

#define DEFAULT_RANDOMIDSTR @"speedprohaha" #define DEFAULT_UPLOAD_ID @"uploadfilehaha"
@implementation SVHttpsRequester
{
    NSMutableData *dataQueue;
    CompletionHandler completionHandler;
    NSString *urlString;
    BOOL useCert;
    BOOL isFinished;
    long sendStartTime;
}

//初始化，创建开始测试时间
- (instancetype)init
{

    self = [super init];
    if (self)
    {
        //开始测试时间刻
        sendStartTime = [SVTimeUtil currentMilliSecondStamp];
    }

    return self;
}


/**
 *  访问https协议的urlString网址,并通过completionHandler Block回调函数对结果进行处理
 *
 *  @param urlString Https协议URL的字符串
 *  @param completionHandler Block回调函数对结果进行处理
 *
 *  @return HWHttpsRequester Https协议网址访问器
 */
+ (id)requestData:(NSString *)urlString completionHandler:(CompletionHandler)completionHandler
{
    return [SVHttpsRequester requestData:urlString
                                 timeout:DEFAULT_CONNECT_TIMEOUT
                                WithCert:NO
                       completionHandler:completionHandler];
}

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
completionHandler:(CompletionHandler)completionHandler
{
    return [SVHttpsRequester requestData:urlString
                                 timeout:DEFAULT_CONNECT_TIMEOUT
                                WithCert:useCert
                       completionHandler:completionHandler];
}

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
completionHandler:(CompletionHandler)completionHandler
{
    return [SVHttpsRequester requestData:urlString
                                 timeout:timeout
                                WithCert:NO
                       completionHandler:completionHandler];
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
+ (id)requestData:(NSString *)urlString
          timeout:(int)timeout
         WithCert:(BOOL)useCert
completionHandler:(CompletionHandler)completionHandler
{
    SVHttpsRequester *requester = [[SVHttpsRequester alloc] init];
    requester->urlString = urlString;
    requester->useCert = useCert;
    requester->completionHandler = completionHandler;

    NSURL *url = [[NSURL alloc] initWithString:requester->urlString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url
                                                  cachePolicy:NSURLRequestReloadIgnoringCacheData
                                              timeoutInterval:timeout];

    // 建立连接
    NSURLConnection *conn = [NSURLConnection connectionWithRequest:request delegate:requester];
    [conn start];
    return requester;
}

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
     completionHandler:(CompletionHandler)completionHandler
{
    return [SVHttpsRequester sendDataToServer:urlString
                                         data:data
                                      timeout:DEFAULT_CONNECT_TIMEOUT
                                     WithCert:NO
                            completionHandler:completionHandler];
}

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
     completionHandler:(CompletionHandler)completionHandler
{
    return [SVHttpsRequester sendDataToServer:urlString
                                         data:data
                                      timeout:DEFAULT_CONNECT_TIMEOUT
                                     WithCert:useCert
                            completionHandler:completionHandler];
}

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
     completionHandler:(CompletionHandler)completionHandler
{
    return [SVHttpsRequester sendDataToServer:urlString
                                         data:data
                                      timeout:timeout
                                     WithCert:NO
                            completionHandler:completionHandler];
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
+ (id)sendDataToServer:(NSString *)urlString
                  data:(NSData *)data
               timeout:(int)timeout
              WithCert:(BOOL)useCert
     completionHandler:(CompletionHandler)completionHandler
{
    SVHttpsRequester *requester = [[SVHttpsRequester alloc] init];
    requester->urlString = urlString;
    requester->useCert = useCert;
    requester->completionHandler = completionHandler;

    NSURL *url = [[NSURL alloc] initWithString:requester->urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPBody:data];
    [request setTimeoutInterval:timeout];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];

    // 建立连接
    NSURLConnection *conn = [NSURLConnection connectionWithRequest:request delegate:requester];
    [conn start];
    return requester;
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
+ (id)uploadFile:(NSURLRequest *)request
         WithCert:(BOOL)useCert
completionHandler:(CompletionHandler)completionHandler
{
    SVHttpsRequester *requester = [[SVHttpsRequester alloc] init];
    requester->urlString = request.URL.absoluteString;
    requester->useCert = useCert;
    requester->completionHandler = completionHandler;

    // 建立连接
    NSURLConnection *conn = [NSURLConnection connectionWithRequest:request delegate:requester];
    [conn start];
    return requester;
}

#pragma mark - NSURLConnectionDataDelegate

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (data)
    {
        if (!dataQueue)
        {
            dataQueue = [[NSMutableData alloc] init];
        }

        [dataQueue appendData:data];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (dataQueue)
    {
        NSLog (@"request finished. data length:%zd", dataQueue.length);
    }
    else
    {
        NSLog (@"request finished. data length:0");
    }

    //成功结束测试时间刻
    long sendEndTime = [SVTimeUtil currentMilliSecondStamp];

    //成功测试消耗时间
    long wastTime = sendEndTime - sendStartTime;
    NSLog (@" %@ response success, startTime:%ld , endTime:%ld ,  wast time is %ld ms", urlString,
            sendStartTime, sendEndTime, wastTime);

    if (completionHandler)
    {
        completionHandler (dataQueue, nil);
    }
}

#pragma mark - NSURLConnectionDelegate

- (BOOL)connectionShouldUseCredentialStorage:(NSURLConnection *)connection
{
    NSLog (@"connectionShouldUseCredentialStorage %@", self);
    return YES;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (completionHandler)
    {
        completionHandler (nil, error);
    }


    //失败结束测试时间刻
    long sendEndTime = [SVTimeUtil currentMilliSecondStamp];
    //失败测试消耗时间
    long wastTime = sendEndTime - sendStartTime;

    NSLog (@" %@ response failed, startTime:%ld , endTime:%ld ,  wast time is %ld ms", urlString,
            sendStartTime, sendEndTime, wastTime);

    NSLog (@"request url[%@] fail, error:%@", urlString, error);
}

// 双向认证参考:https://developer.apple.com/library/ios/technotes/tn2232/_index.html#//apple_ref/doc/uid/DTS40012884-CH1-SECNSURLCONNECTION
//
//
// Note: Support for the -connection:willSendRequestForAuthenticationChallenge: delegate method was
// introduced in OS X 10.7 and iOS 5.0. If you need to support older systems, implement the
// -connection:canAuthenticateAgainstProtectionSpace: and
// -connection:didReceiveAuthenticationChallenge: delegate methods as well.

// 服务器回调函数，验证证书
- (void)connection:(NSURLConnection *)connection
willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    NSLog (@"authenticationMethod:%@", challenge.protectionSpace.authenticationMethod);

    if (!useCert)
    {
        [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust]
             forAuthenticationChallenge:challenge];
        NSLog (@"useCert is nil ,return");
        return;
    }

    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodClientCertificate])
    {
        [self clientCertificate:challenge];
    }
    else if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
    {
        [self serverTrust:challenge];
    }
}

/**
 *  验证客户端证书
 */
- (void)clientCertificate:(NSURLAuthenticationChallenge *)challenge
{
    SecIdentityRef identity = NULL;
    SecTrustRef trust = NULL;

    // 导入证书
    NSString *certPath = [[NSBundle mainBundle] pathForResource:@"client" ofType:@"p12"]; // client

    //    NSString *certPath = [[NSBundle mainBundle] pathForResource:@"client" ofType:@"p12"];
    NSData *inPKCS12Data = [[NSData alloc] initWithContentsOfFile:certPath];
    [self extractIdentity:inPKCS12Data identity:&identity andTrust:&trust];


    SecTrustResultType clientTrustResult;
    SecTrustEvaluate (trust, &clientTrustResult);
    SecCertificateRef myReturnedCertificate = NULL;
    OSStatus status = SecIdentityCopyCertificate (identity, &myReturnedCertificate);

    if (status == errSecSuccess &&
        (clientTrustResult == kSecTrustResultProceed || clientTrustResult == kSecTrustResultUnspecified))
    {
        SecCertificateRef certs[1] = { myReturnedCertificate };
        CFArrayRef array = CFArrayCreate (NULL, (const void **)certs, 1, NULL);
        NSArray *myArray = (__bridge NSArray *)array;

        NSURLCredential *newCredential =
        [NSURLCredential credentialWithIdentity:identity
                                   certificates:myArray
                                    persistence:NSURLCredentialPersistenceForSession];
        CFRelease (array);
        [challenge.sender useCredential:newCredential forAuthenticationChallenge:challenge];
    }
    else
    {
        // 验证失败，取消这次验证流程
        [challenge.sender cancelAuthenticationChallenge:challenge];
    }
}

/**
 *  验证服务器端证书
 */
- (void)serverTrust:(NSURLAuthenticationChallenge *)challenge
{
    NSLog (@"serverTrust");

    SecIdentityRef identity = NULL;
    SecTrustRef trust = NULL;

    // 导入证书
    NSString *certPath = [[NSBundle mainBundle] pathForResource:@"server" ofType:@"p12"]; // server
    //    NSString *certPath = [[NSBundle mainBundle] pathForResource:@"server" ofType:@"p12"];
    NSData *inPKCS12Data = [[NSData alloc] initWithContentsOfFile:certPath];
    [self extractIdentity:inPKCS12Data identity:&identity andTrust:&trust];


    SecTrustResultType clientTrustResult;
    SecTrustEvaluate (trust, &clientTrustResult);
    SecCertificateRef myReturnedCertificate = NULL;
    OSStatus status = SecIdentityCopyCertificate (identity, &myReturnedCertificate);

    if (status == errSecSuccess &&
        (clientTrustResult == kSecTrustResultProceed || clientTrustResult == kSecTrustResultUnspecified))
    {
        // 验证成功，生成NSURLCredential凭证cred，告知challenge的sender使用这个凭证来继续连接
        NSURLCredential *cred = [NSURLCredential credentialForTrust:trust];
        [challenge.sender useCredential:cred forAuthenticationChallenge:challenge];
    }
    else
    {
        // 验证失败，取消这次验证流程
        [challenge.sender cancelAuthenticationChallenge:challenge];
    }
}

#pragma mark - 证书操作


- (BOOL)extractIdentity:(NSData *)inPKCS12Data
               identity:(SecIdentityRef *)identity
               andTrust:(SecTrustRef *)trust
{
    OSStatus securityError = errSecSuccess;

    NSString *keyStr = [self getKeyStr];
    CFStringRef password = (__bridge CFStringRef) (keyStr);
    const void *keys[] = { kSecImportExportPassphrase };
    const void *values[] = { password };
    CFDictionaryRef options = CFDictionaryCreate (NULL, keys, values, 1, NULL, NULL);


    CFArrayRef items = NULL;
    securityError = SecPKCS12Import ((CFDataRef)inPKCS12Data, options, &items);

    if (securityError == 0)
    {
        CFDictionaryRef myIdentityAndTrust = CFArrayGetValueAtIndex (items, 0);
        const void *tempIdentity = NULL;
        tempIdentity = CFDictionaryGetValue (myIdentityAndTrust, kSecImportItemIdentity);
        CFRetain (tempIdentity);
        *identity = (SecIdentityRef)tempIdentity;
        const void *tempTrust = NULL;
        tempTrust = CFDictionaryGetValue (myIdentityAndTrust, kSecImportItemTrust);
        CFRetain (tempTrust);
        *trust = (SecTrustRef)tempTrust;

        // certs数组中包含了所有的证书
        CFArrayRef certs = (CFArrayRef)CFDictionaryGetValue (myIdentityAndTrust, kSecImportItemCertChain);
        securityError = SecTrustSetAnchorCertificates (*trust, certs);
    }

    if (options)
    {
        CFRelease (options);
    }


    if (items)
    {
        CFRelease (items);
    }

    return securityError;
}

// 读取证书内容
- (void)extractP12Data:(NSString *)certPath trust:(SecTrustRef)trust
{
    if (!certPath)
    {
        NSLog (@"certPath is nil ,return");
        return;
    }

    // 导入证书
    NSData *PKCS12Data = [[NSData alloc] initWithContentsOfFile:certPath];
    CFDataRef inP12Data = (__bridge CFDataRef) (PKCS12Data);

    OSStatus securityError = errSecSuccess;

    NSString *keyStr = [self getKeyStr];
    CFStringRef password = (__bridge CFStringRef) (keyStr);
    const void *keys[] = { kSecImportExportPassphrase };
    const void *values[] = { password };
    CFDictionaryRef options = CFDictionaryCreate (NULL, keys, values, 1, NULL, NULL);

    CFArrayRef items = CFArrayCreate (NULL, 0, 0, NULL);
    securityError = SecPKCS12Import (inP12Data, options, &items);
    if (securityError != 0)
    {
        if (options)
        {
            CFRelease (options);
        }

        if (items)
        {
            CFRelease (items);
        }
        NSLog (@"SecPKCS12Import certificate failed!");
        return;
    }

    CFDictionaryRef ident = CFArrayGetValueAtIndex (items, 0);
    const void *tempIdentity = NULL;
    tempIdentity = CFDictionaryGetValue (ident, kSecImportItemIdentity);
    SecIdentityRef identity = (SecIdentityRef)tempIdentity;

    if (securityError != errSecSuccess)
    {
        NSLog (@"Read certificate failed!");
        return;
    }

    SecCertificateRef certificate = NULL;
    SecIdentityCopyCertificate (identity, &certificate);
    const void *certs[] = { certificate };

    CFArrayRef trustedCerArr = CFArrayCreate (kCFAllocatorDefault, certs, 1, NULL);

    // 注意：这里将之前导入的证书设置成下验证的Trust Object的anchor certificate
    SecTrustSetAnchorCertificates (trust, trustedCerArr);

    if (options)
    {
        CFRelease (options);
    }

    if (items)
    {
        CFRelease (items);
    }

    if (trustedCerArr)
    {
        CFRelease (trustedCerArr);
    }
}

// 获取证书秘钥
- (NSString *)getKeyStr
{
    // 加载配置文件
    NSError *error;
    NSString *configPath = [[NSBundle mainBundle] pathForResource:@"config" ofType:@"properties"];
    NSData *configData = [[NSData alloc] initWithContentsOfFile:configPath
                                                        options:NSDataReadingMappedIfSafe
                                                          error:&error];
    if (error)
    {
        NSLog (@"Read config failed! error:%@", error);
        return nil;
    }

    NSMutableDictionary *configDic = [self getDicWithData:configData];

    NSString *paramPath = [[NSBundle mainBundle] pathForResource:@"params" ofType:@"properties"];
    NSData *paramData = [[NSData alloc] initWithContentsOfFile:paramPath
                                                       options:NSDataReadingMappedIfSafe
                                                         error:&error];
    if (error)
    {
        NSLog (@"Read param failed! error:%@", error);
        return nil;
    }
    NSMutableDictionary *paramDic = [self getDicWithData:paramData];

    NSString *certPath = [[NSBundle mainBundle] pathForResource:@"cert" ofType:@"properties"];
    NSData *certData =
    [[NSData alloc] initWithContentsOfFile:certPath options:NSDataReadingMappedIfSafe error:&error];
    if (error)
    {
        NSLog (@"Read cert failed! error:%@", error);
        return nil;
    }
    NSMutableDictionary *certDic = [self getDicWithData:certData];

    NSString *keyPath = [[NSBundle mainBundle] pathForResource:@"key" ofType:@"properties"];
    NSData *keyData =
    [[NSData alloc] initWithContentsOfFile:keyPath options:NSDataReadingMappedIfSafe error:&error];
    if (error)
    {
        NSLog (@"Read key failed! error:%@", error);
        return nil;
    }
    NSMutableDictionary *keyDic = [self getDicWithData:keyData];

    // 获取rootKey
    NSString *rootKey = [NSString
    stringWithFormat:@"%@%@%@%@", [configDic valueForKey:PARAM_KEY], [paramDic valueForKey:PARAM_KEY],
                     [certDic valueForKey:PARAM_KEY], [keyDic valueForKey:PARAM_KEY]];

    // 从文件中读取加密的key和密码

    // 解析出加密的key和密码
    NSString *encryKey = [configDic valueForKey:KEY_KEY];
    NSString *encryPW = [paramDic valueForKey:KEY_KEY];

    //解密Key
    NSString *key = [encryKey aes256_decrypt:rootKey];
    NSString *pw = [encryPW aes256_decrypt:key];

    return pw;
}

// 将文件内容解析为字典
- (NSMutableDictionary *)getDicWithData:(NSData *)fileData
{
    NSMutableDictionary *configDic = [[NSMutableDictionary alloc] init];
    NSString *contents = [[NSString alloc] initWithData:fileData encoding:NSUTF8StringEncoding];
    NSArray *lineArray = [contents componentsSeparatedByString:@"\n"];
    for (NSString *lineStr in lineArray)
    {
        NSArray *params = [lineStr componentsSeparatedByString:@":"];
        if ([params count] != 2)
        {
            continue;
        }

        [configDic setObject:params[1] forKey:params[0]];
    }
    return configDic;
}

@end
