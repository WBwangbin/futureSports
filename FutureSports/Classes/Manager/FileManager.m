//
//  FileManager.m
//  FutureSports
//
//  Created by wangbin on 2017/10/9.
//  Copyright © 2017年 wangbin. All rights reserved.
//

#import "FileManager.h"
#import "FMDatabase.h"

static NSString * App_acountId;

@implementation FileManager


+ (void)initAppWithAcount:(NSString *)account
{
    App_acountId = account;
    
    NSFileManager * fm = [NSFileManager defaultManager];
    NSString * accountPath = [FileManager accountMainPath];
    
    NSError * error;
    if (![fm fileExistsAtPath:accountPath]) {
        //没有用户账号目录
        [fm createDirectoryAtPath:accountPath withIntermediateDirectories:NO attributes:nil error:&error];
    }else
    {
        return;
    }
    
    NSString * databaseFile = [FileManager databaseFile];
    if (![fm fileExistsAtPath:databaseFile]) {
        //用户数据库
        FMDatabase * fmdb = [[FMDatabase alloc] initWithPath:databaseFile];
        if ([fmdb open]) {
            NSLog(@"数据库%@创建并打开成功",@"userdb");
            
            [fmdb close];
        }else
        {
            NSLog(@"数据库打开失败或者已存在%@",@"userdb");
        }
    }
}

//用户数据库目录   /Documents/1/userdb.sqlite
+ (NSString *)databaseFile
{
    return [[FileManager accountMainPath] stringByAppendingPathComponent:@"userdb.sqlite"];
}

//   /Documents
+ (NSString *)documentPath
{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
}

//  /Documents/1
+ (NSString *)accountMainPath
{
    if (App_acountId) {
        return [FileManager accountMainPathForUid:App_acountId];
    }
    else
    {
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        NSString * userNum = [defaults objectForKey:KLvUserid];
        return [FileManager accountMainPathForUid:userNum];
    }
}

//   /Documents/1
+ (NSString *)accountMainPathForUid:(NSString *)uid
{
    return [[FileManager documentPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",uid]];
}


+ (void)createCacheFile
{
    NSFileManager * fm = [NSFileManager defaultManager];
    NSString * cachePath = [FileManager cacheFileMainPath];
    
    NSError * error;
    
    if (![fm fileExistsAtPath:cachePath]) {
        //没有缓存目录
        [fm createDirectoryAtPath:cachePath withIntermediateDirectories:NO attributes:nil error:&error];
    }else
    {
        return;
    }
}

+ (NSString *)cacheFileMainPath
{
    return [[FileManager cachesPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",@"CacheFile"]];
}

+ (NSString *)cachesPath
{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
}

#pragma mark - 文件是否存在

+ (BOOL)existsAtPath:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:path]) {
        return YES;
    }else
    {
        return NO;
    }
}

#pragma mark - 文件重命名
+ (BOOL)fileRename:(NSString *)sourcePath outPath:(NSString *)outPath
{
    
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError * error;
    
    [fileManager moveItemAtPath:sourcePath toPath:outPath error:&error];
    //将源文件删除
    
    [fileManager removeItemAtPath:sourcePath error:&error];
    
    return YES;
}

#pragma mark - 文件保存
+ (BOOL)fileSave:(NSString *)path data:(UIImage *)image name:(NSString *)imageName
{
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:path isDirectory:&isDir];
    bool isSaved = false;
    
    NSString * cacheImagePath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", imageName, @"jpg"]];
    
    if ( isDir == YES && existed == YES )
    {
        NSData * data = UIImageJPEGRepresentation(image, 1.0);
        isSaved = [data writeToFile: cacheImagePath atomically:YES];
    }
    return isSaved;
}

+ (BOOL)writeData:(NSString *)path data:(NSString *)exception
{

    NSData *data = [exception dataUsingEncoding:NSUTF8StringEncoding];//将写入的字符串转换成NSData类型

    NSString *file = [NSString stringWithFormat:@"%@/file.txt",path];//在Documents里建立一个名为file.txt的文件
    BOOL result = [data writeToFile:file atomically:YES];//定义一个bool类型的变量，判断文件是否写入成功
    return result;
    
}

+(NSData *)readDataFromPath:(NSString *)path
{
    NSString *readstring = [NSString stringWithFormat:@"%@/file.txt",path];//找到我们的file文件
    
    NSData *data = [[NSData alloc]initWithContentsOfFile:readstring];//取出文件里面的数据
    
    return data;
}

@end
