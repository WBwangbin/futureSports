//
//  ApiTool.m
//  FutureSports
//
//  Created by wangbin on 2017/9/28.
//  Copyright © 2017年 wangbin. All rights reserved.
//

#import "ApiTool.h"

static ApiTool *apiTool;

@implementation ApiTool

+ (instancetype _Nullable )shareApiTool
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        apiTool = [[ApiTool alloc]init];
    });
    return apiTool;
}

- (void)get:(NSString *_Nullable)url params:(NSDictionary *_Nullable)params success:(void(^_Nullable)(NSDictionary * _Nullable jsonDic))success    failure:(void(^_Nullable)(NSError * _Nullable error))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    policy.allowInvalidCertificates = YES;//允许不信任的证书通过
    policy.validatesDomainName = NO;//验证主机名
    manager.securityPolicy = policy;
    
    manager.requestSerializer.timeoutInterval = 20;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *result = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSDictionary *jsonDic = [self dictionaryWithJsonString:result];
        
        if (success) {
            success(jsonDic);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)post:(NSString *_Nullable)url params:(NSDictionary *_Nullable)params success:(void(^_Nullable)(NSDictionary * _Nullable jsonDic))success    failure:(void(^_Nullable)(NSError * _Nullable error))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    policy.allowInvalidCertificates = YES;
    policy.validatesDomainName = NO;
    manager.securityPolicy = policy;
    
    manager.requestSerializer.timeoutInterval = 20;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *result = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSDictionary *jsonDic = [self dictionaryWithJsonString:result];
        
        if (success) {
            success(jsonDic);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)put:(NSString *_Nullable)url params:(NSDictionary *_Nullable)params success:(void(^_Nullable)(NSDictionary * _Nullable jsonDic))success failure:(void(^_Nullable)(NSError * _Nullable error))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    policy.allowInvalidCertificates = YES;
    policy.validatesDomainName = NO;
    manager.securityPolicy = policy;

    manager.requestSerializer.timeoutInterval = 20;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager.requestSerializer setValue:@"application/octet-stream" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"aliy" forHTTPHeaderField:@"x-oss-meta-author"];
    
    [manager PUT:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *result = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSDictionary *jsonDic = [self dictionaryWithJsonString:result];
        
        if (success) {
            success(jsonDic);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (NSURLSessionDataTask *_Nullable)upLoadImage:(NSString *_Nullable)url params:(NSDictionary *_Nullable)params upLoadImage:(UIImage *_Nullable)image progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress success:(void (^_Nullable)(NSDictionary * _Nullable jsonDic))success failure:(void (^_Nullable)(NSError * _Nullable error))failure
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    policy.allowInvalidCertificates = YES;//允许不信任的证书通过
    policy.validatesDomainName = NO;//验证主机名
    manager.securityPolicy = policy;
    
    manager.requestSerializer.timeoutInterval = 20;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSURLSessionDataTask *dataTask = [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *imageData = UIImagePNGRepresentation(image);
        
        [formData appendPartWithFileData:imageData name:@"file"fileName:@"file.jpg" mimeType:@"image/jpg"];
        
    } progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *result = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        NSDictionary * jsonDic = [self dictionaryWithJsonString:result];
        
        if (success) {
            success(jsonDic);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
    return dataTask;
}

//字符串转字典
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    return [NSJSONSerialization JSONObjectWithData:jsonData
            options:NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:nil];
}

@end
