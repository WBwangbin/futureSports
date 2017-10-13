//
//  SVUploadFile.h
//  SpeedPro
//
//  Created by WBapple on 16/2/26.
//  Copyright © 2016年 chinasofti. All rights reserved.
//

/**
 *  设置页面的上传日志方法
 */
#import <Foundation/Foundation.h>
@class SVSyncHttpsRequester;
@interface SVUploadFile : NSObject
{
    BOOL _isShowToast;
}

- (void)uploadFile:(NSString *)filePath
           withUrl:(NSString *)uploadUrl
     withRequester:(SVSyncHttpsRequester *)httpsRequester;

- (void)setShowToast:(BOOL)isShowToast;

@end
