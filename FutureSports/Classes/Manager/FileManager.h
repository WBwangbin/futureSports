//
//  FileManager.h
//  FutureSports
//
//  Created by wangbin on 2017/10/9.
//  Copyright © 2017年 wangbin. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 文件夹操作
 */
@interface FileManager : NSObject
/**
 *  用户第一次登录时初始化操作(和创建缓存文件夹)
 *
 *  @param account 用户唯一标识
 */
+ (void)initAppWithAcount:(NSString *)account;


+ (NSString *)documentPath;

/**
 *  用户数据库路径
 *
 *  @return return value description
 */
+ (NSString *)databaseFile;

+ (NSString *)accountMainPath;

+ (NSString *)accountMainPathForUid:(NSString *)uid;


/**
 *  创建缓存文件夹
 */
+ (void)createCacheFile;

/**
 *  缓存目录
 *
 *  @return 缓存目录
 */
+ (NSString *)cacheFileMainPath;
+ (NSString *)cachesPath;

#pragma mark - 文件是否存在
+ (BOOL)existsAtPath:(NSString *)path;

#pragma mark - 文件重命名
/**
 *  文件重命名
 *
 *  @param sourcePath 源文件路径
 *  @param outPath    重命名文件路径
 *
 *  @return 是否成功
 */
+ (BOOL)fileRename:(NSString *)sourcePath outPath:(NSString *)outPath;

#pragma mark - 文件保存
/**
 *  文件保存
 *
 *  @param path      预存储路径
 *  @param image     图片
 *  @param imageName 图片名
 *
 *  @return 是否保存成功
 */
+ (BOOL)fileSave:(NSString *)path data:(UIImage *)image name:(NSString *)imageName;

+ (BOOL)writeData:(NSString *)path data:(NSString *)exception;

+ (NSData *)readDataFromPath:(NSString *)path;

@end
