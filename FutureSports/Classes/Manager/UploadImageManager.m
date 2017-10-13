//
//  UploadImageManager.m
//  FutureSports
//
//  Created by wangbin on 2017/10/9.
//  Copyright © 2017年 wangbin. All rights reserved.
//

#import "UploadImageManager.h"

@interface UploadImageManager()

@property (nonatomic, strong) UIImage *uploadImage;
@property (nonatomic, readwrite) CGFloat progress;
@property (nonatomic, readwrite) BOOL isUploading;
@property (nonatomic, readwrite) BOOL uploadFail;

@property (nonatomic, strong) NSURLSessionDataTask *dataTask;

@end

@implementation UploadImageManager

- (instancetype)initWithImage:(UIImage *)uploadImage{
    
    if (self = [super init]) {
        
        self.uploadImage = uploadImage;
        
    }
    return self;
}

- (void)beingUploadImage{
    
    self.isUploading = YES;
    self.uploadFail  = NO;
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *sign = [userDefault objectForKey:KSign];
    long userid = [[userDefault objectForKey:KLvUserid] longLongValue];
    NSDictionary *params = @{@"userid":@(userid),@"sign":sign};
    NSString *url = HTTP_FILE_UPLOAD_URL;
    
    __weak typeof(self)weakSelf = self;
    self.dataTask = [[ApiTool shareApiTool] upLoadImage:url params:params upLoadImage:_uploadImage progress:^(NSProgress * _Nonnull uploadProgress) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        if (strongSelf) {
            
            strongSelf.progress = (float)uploadProgress.completedUnitCount / (float)uploadProgress.totalUnitCount;
            
            if (strongSelf.uploadImageProgress) {
                
                strongSelf.uploadImageProgress(_progress);
            }
        }
    } success:^(NSDictionary * _Nullable jsonDic) {
        
        __strong typeof(weakSelf)strongSelf = weakSelf;
        if (strongSelf){
            
            strongSelf.isUploading = NO;
            
            if ([[jsonDic objectForKey:@"code"] intValue] == 0) {
                
                NSString *md5 = [jsonDic objectForKey:@"md5"];
                strongSelf.md5 = md5;
                
                NSLog(@"图片上传%@",jsonDic);
            }
            
            strongSelf.dataTask = nil;
        }
        

      } failure:^(NSError * _Nullable error) {
          self.uploadFail = YES;
          __strong typeof(weakSelf)strongSelf = weakSelf;
          if (strongSelf){
              
              strongSelf.isUploading = NO;
          }
    }];
}

- (void)cancelUploadImage{
    
    [_dataTask cancel];
}

@end
