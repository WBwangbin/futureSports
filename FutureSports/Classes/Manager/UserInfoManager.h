//
//  UserInfoManager.h
//  FutureSports
//
//  Created by wangbin on 2017/10/9.
//  Copyright © 2017年 wangbin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoManager : NSObject

+ (instancetype)shareUserInfoManager;

@property (nonatomic, copy) NSString *company;  //公司
@property (nonatomic, copy) NSString *headurl;  //头像
@property (nonatomic, copy) NSString *nickname; //昵称
@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *abilitylv; //技能等级
@property (nonatomic, copy) NSString *abilitytype; //技能类型 1模型 2渲染 3整包
@property (nonatomic, copy) NSString *city;     //城市
@property (nonatomic, copy) NSString *lvuserid; //用户id
@property (nonatomic, copy) NSString *praise;   //点赞数量
@property (nonatomic, copy) NSString *realauth; //实名认证 0未认证 1审核中 2认证通过 3认证失败
@property (nonatomic, copy) NSString *role;     //角色
@property (nonatomic, copy) NSString *sex;      //性别
@property (nonatomic, copy) NSString *skillauth;//技能认证 0未认证 1认证
@property (nonatomic, copy) NSString *strength; //体力值
@property (nonatomic, copy) NSString *realname; //真实姓名
@property (nonatomic, copy) NSString *identity; //身份证号
@property (nonatomic, copy) NSString *companyid; //0个人 其他企业
@property (nonatomic, copy) NSString *exitPayPwd; //0不存在 1存在
@property (nonatomic, copy) NSString *ismanager;//1主账户
@property (nonatomic, copy) NSString *bz;//审核未通过原因
@property (nonatomic, copy) NSString *fansnumber;//粉丝数量
@property (nonatomic, copy) NSString *email;//邮箱
@property (nonatomic, copy) NSString *profession;//职业
@property (nonatomic, copy) NSString *qq;
@property (nonatomic, copy) NSString *workingseriority;//工作年限
@property (nonatomic, copy) NSString *age;//年龄
@property (nonatomic, copy) NSString *signature;//个人简介
@property (nonatomic, copy) NSString *authstate;//0.实名未认证 1.实名待认证，2.实名认证成功，3.实名认证失败
@property (nonatomic, copy) NSString *skillauthstate;//0、技能未认证，1.技能待认证，2.技能认证成功，3.技能认证失败
@end
