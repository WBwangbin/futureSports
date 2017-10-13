//
//  main.m
//  FutureSports
//
//  Created by wangbin on 2017/9/21.
//  Copyright © 2017年 wangbin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    @autoreleasepool
        {
            int value = -1;
            @try
            {
                NSLog(@"******FutureSports start******");
                value = UIApplicationMain (argc, argv, nil, NSStringFromClass ([AppDelegate class]));
            }
            @catch (NSException *exception)
            {
                NSLog (@"FutureSports start fail. Exception:%@", exception);
            }
            
            return value;
        }
}
