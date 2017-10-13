//
//  UploadImageManager.h
//  FutureSports
//
//  Created by wangbin on 2017/10/9.
//  Copyright © 2017年 wangbin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^UploadImageProgress)(CGFloat progress);

@interface UploadImageManager : NSObject

- (instancetype)initWithImage:(UIImage *)uploadImage;

@property (nonatomic, readonly) CGFloat progress;

@property (nonatomic, readonly) BOOL isUploading;
@property (nonatomic, readonly) BOOL uploadFail;
@property (nonatomic, copy) NSString *md5;

@property (nonatomic, copy) UploadImageProgress uploadImageProgress;


/**
 开始上传图片
 */
- (void)beingUploadImage;

/**
 取消当前请求
 */
- (void)cancelUploadImage;

@end
