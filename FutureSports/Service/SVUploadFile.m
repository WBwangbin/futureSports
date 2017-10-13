//
//  SVUploadFile.m
//  SpeedPro
//
//  Created by WBapple on 16/2/26.
//  Copyright © 2016年 chinasofti. All rights reserved.
//


#import "SVSyncHttpsRequester.h"
#import "SVTimeUtil.h"
#import "SVUploadFile.h"


@implementation SVUploadFile

//设置头
static NSString *useragent = @"Mozilla/5.0 (iPhone; CPU iPhone OS 6_1_1 like Mac OS X) "
                             @"AppleWebKit/601.3.9 (KHTML, like Gecko) Version/9.0.2 Mobile/9B206 "
                             @"Safari/601.3.9";

// 拼接字符串
static NSString *boundaryStr = @"--"; // 分隔字符串
static NSString *randomIDStr; // 本次上传标示字符串
static NSString *uploadID; // 上传(php)脚本中，接收文件字段

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        randomIDStr = @"speedpro";
        uploadID = @"uploadFile";
    }
    return self;
}

- (void)setShowToast:(BOOL)isShowToast
{
    _isShowToast = isShowToast;
}

#pragma mark - 私有方法
- (NSString *)topStringWithMimeType:(NSString *)mimeType uploadFile:(NSString *)uploadFile
{
    NSMutableString *strM = [NSMutableString string];
    [strM appendFormat:@"%@%@\n", boundaryStr, randomIDStr];
    [strM appendFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\n", uploadID, uploadFile];
    [strM appendFormat:@"Content-Type: %@\n\n", mimeType];
    return [strM copy];
}

- (NSString *)bottomString
{
    NSMutableString *strM = [NSMutableString string];
    [strM appendFormat:@"%@%@\n", boundaryStr, randomIDStr];
    [strM appendString:@"Content-Disposition: form-data; name=\"submit\"\n\n"];
    [strM appendString:@"Submit\n"];
    [strM appendFormat:@"%@%@--\n", boundaryStr, randomIDStr];
    return [strM copy];
}

#pragma mark - 上传文件

- (void)uploadFile:(NSString *)filePath
           withUrl:(NSString *)uploadUrl
     withRequester:(SVSyncHttpsRequester *)httpsRequester
{

    NSLog (@"upload log file[%@] to Server[%@]", filePath, uploadUrl);

    //提示
//    [self showToastForUser:I18N (@"Uploading")];

    NSData *data = [NSData dataWithContentsOfFile:filePath];

    // 1> 数据体
    NSString *topStr = [self topStringWithMimeType:@"image/png" uploadFile:@"uploadFileName.png"];
    NSString *bottomStr = [self bottomString];
    NSMutableData *dataM = [NSMutableData data];
    [dataM appendData:[topStr dataUsingEncoding:NSUTF8StringEncoding]];
    [dataM appendData:data];
    [dataM appendData:[bottomStr dataUsingEncoding:NSUTF8StringEncoding]];
    // 1. Request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:uploadUrl]];

    // dataM出了作用域就会被释放,因此不用copy
    request.HTTPBody = dataM;

    // 2> 设置Request的头属性
    request.HTTPMethod = @"POST";

    // 3> 设置Content-Length
    NSString *strLength = [NSString stringWithFormat:@"%ld", (long)dataM.length];
    [request setValue:strLength forHTTPHeaderField:@"Content-Length"];

    // 4> 设置Content-Type
    NSString *strContentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", randomIDStr];
    [request setValue:strContentType forHTTPHeaderField:@"Content-Type"];

    // 5> 设置User-Agent(请求头)
    [request setValue:useragent forHTTPHeaderField:@"User-Agent"];
    [request setTimeoutInterval:60];


    [httpsRequester
           uploadFile:request
             WithCert:YES
    completionHandler:^(NSData *responseData, NSError *error) {

      if (_isShowToast)
      {
          //当配置变化时，发送广播通知其他应用进行处理
          [[NSNotificationCenter defaultCenter] postNotificationName:SVUploadLogFinishNotification
                                                              object:self];
      }

      // 上报结果失败
      if (error)
      {
//          NSLog (@"retry send result to server. result push error:%@ ", error);
//          [self showToastForUser:I18N (@"Upload Failed")];


          return;
      }

      NSString *mesg = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
      NSLog (@"upload log file success. response data from server:%@", mesg);
//      [self showToastForUser:I18N (@"Upload Success")];

    }];
}

/**
 * 弹出提示信息，告知用户
 */
- (void)showToastForUser:(NSString *)mesg
{
    if (!_isShowToast)
    {
        return;
    }

    // 弹出提示信息，告知用户上传日志成功
    dispatch_async (dispatch_get_main_queue (), ^{
//      [SVToast showWithText:mesg];

    });
}

@end
