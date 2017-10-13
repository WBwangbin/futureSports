//
//  SVHtmlTools.m
//  FutureSports
//
//  Created by wangbin on 2017/9/27.
//  Copyright © 2017年 wangbin. All rights reserved.
//

#import "SVHtmlTools.h"

@implementation SVHtmlTools

/**
 * 加载内置网页
 */
- (void)loadHtmlWithFileName:(NSString *)fileName webView:(WKWebView *)webView
{
    //调用逻辑
    NSString *htmlPath = [NSString stringWithFormat:@"file://%@", [self getHtmlPathWithFileName:fileName]];
    NSLog (@"加载网页URL为:%@", htmlPath);
    NSURL *fileURL = [NSURL URLWithString:htmlPath];
    if (fileURL)
    {
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 9.0)
        {
            // iOS9. One year later things are OK.
            [webView loadFileURL:fileURL allowingReadAccessToURL:fileURL];
        }
        else
        {
            // iOS8. Things can be workaround-ed
            //   Brave people can do just this
            //   fileURL = try! pathForBuggyWKWebView8(fileURL)
            //   webView.loadRequest(NSURLRequest(URL: fileURL))
            NSURL *url = [self fileURLForBuggyWKWebView8:fileURL];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            [webView loadRequest:request];
        }
    }
}

//将文件copy到tmp目录
- (NSURL *)fileURLForBuggyWKWebView8:(NSURL *)fileURL
{
    NSError *error = nil;
    if (!fileURL.fileURL || ![fileURL checkResourceIsReachableAndReturnError:&error])
    {
        NSLog (@"fileURL.fileURL is nil ,return");
        return nil;
    }
    // Create "/temp/www" directory
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *temDirURL = [[NSURL fileURLWithPath:NSTemporaryDirectory ()] URLByAppendingPathComponent:@"www"];
    [fileManager createDirectoryAtURL:temDirURL
          withIntermediateDirectories:YES
                           attributes:nil
                                error:&error];

    NSURL *dstURL = [temDirURL URLByAppendingPathComponent:fileURL.lastPathComponent];
    // Now copy given file to the temp directory
    [fileManager removeItemAtURL:dstURL error:&error];
    [fileManager copyItemAtURL:fileURL toURL:dstURL error:&error];
    // Files in "/temp/www" load flawlesly :)
    return dstURL;
}

- (NSString *)getHtmlPathWithFileName:(NSString *)fileName
{
    // 资源目录
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *dirArray = [fileManager subpathsAtPath:resourcePath];
    NSString *playerHtmlPath;
    for (NSString *path in dirArray)
    {
        if ([path containsString:@"html"])
        {
            NSLog (@"扫描所有html文件,html的文件有:%@", path);
        }
        if ([path containsString:[NSString stringWithFormat:@"%@.html", fileName]])
        {
            playerHtmlPath = [resourcePath stringByAppendingPathComponent:path];
            NSLog (@"找到我需要的文件是:%@", path);
            break;
        }
    }

    return playerHtmlPath;
}

@end
