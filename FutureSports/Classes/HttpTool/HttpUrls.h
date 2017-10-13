//
//  HttpUrls.h
//  FutureSports
//
//  Created by wangbin on 2017/9/25.
//  Copyright © 2017年 wangbin. All rights reserved.
//




/**
 *** 网络头
 **/

#ifndef HttpUrls_h
#define HttpUrls_h

//测试服
#define HTTP_ROOT1 @"http://114.215.26.64:8111/"
#define HTTP_ROOT2 @"http://139.129.212.94:8098/"
#define HTTP_ROOT3 @"http://test.ejianmo.com/"

//正式服
//#define HTTP_ROOT1 @"http://3d.ejianmo.com/"
//#define HTTP_ROOT2 @"http://user.emoding.com/"
//#define HTTP_ROOT3 @"http://api.ejianmo.com/"


/**********************省钱排行************************/
#pragma mark - 省钱排行

//企业省钱排行
#define HTTP_USER_SAVE_ORDER_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT2,@"user/enterprise-save-order.action"]


/**********************我的模型************************/
#pragma mark - 我的模型
//获取我的模型列表
#define HTTP_PROJECT_MY_MODEL_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT1,@"project/my-model.action"]

//删除模型
#define HTTP_PROJECT_REMOVE_MODEL_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT1,@"project/remove-model.action"]

/**********************关注************************/
#pragma mark - 关注
//我的关注列表
#define HTTP_USER_GETFUNS_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"user/focus/getfuns.action"]

//取消关注
#define HTTP_USER_DELFOCUS_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"user/focus/delfocus.action"]

//添加关注
#define HTTP_USER_ADDFOCUS_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"user/focus/addfocus.action"]

//我的粉丝数量
#define HTTP_USER_GETFUNNUM_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"user/focus/getfunnum.action"]


/**********************H5页面************************/
#pragma mark - h5
//水平认证
#define HTTP_HTML_LEVEL_CER_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"html/level_cer.html"]

//企业认证
#define HTTP_HTML_AUTHENTICATION_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"html/authentication.html"]

//注册协议
#define HTTP_HTML_REGIST_PROTOCOL_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"html/regist_protocol.html"]

//用户指南
#define HTTP_HTML_USER_GUIDE_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"html/user_guide.html"]

//蜂贝账户
#define HTTP_HTML_WITHDRAWALS_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"html/withdrawals.html"]

//等级说明
#define HTTP_HTML_GRADE_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"html/grade.html"]


/**********************消息************************/
#pragma mark - 消息
//消息首页  查询分类消息以及未读消息数量
#define HTTP_NEWS_LIST_NEWS_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"comm/news/list-news.action"]

//查询消息详情，列表
#define HTTP_NEWS_GET_NEWSLIST_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"comm/news/get-news-list.action"]

//需求变更列表，续单列表
#define HTTP_PROJECT_LIST_DEMANDS_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"project/list-demands.action"]

//需求变更金额减少退款
#define HTTP_PROJECT_BACK_DEMAND_MONEY_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"project/back-demand-money.action"]

//拒绝需求变更，续单
#define HTTP_PROJECT_REFUSE_DEMAND_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"project/refuse-demand.action"]

//待处理续单列表
#define HTTP_RENEW_LIST_RENEW_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"project/renew/list-renew.action"]

//查询未读未处理消息总数
#define HTTP_NEWS_GET_NOREAD_COUNT_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"comm/news/get-no-read-count.action"]


/**********************设置************************/
#pragma mark - 设置
//版本更新
#define HTTP_VERSION_SEARCH_APP_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"comm/version/search-app-version.action"]

//判断是否存在支付密码
#define HTTP_USER_EXIST_PAYPWD_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"user/existPayPassWord.action"]

//设置支付密码
#define HTTP_USER_SET_PAYPWD_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT2,@"user/setpaypasswd.action"]

//修改支付密码
#define HTTP_USER_RESET_PAYPWD_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT2,@"user/resetpaypasswd.action"]

//发送重置支付密码验证码
#define HTTP_USER_SEND_PAYWD_VALIDATECODE_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT2,@"user/send-paywd-validatecode.action"]

//验证验证码或者密码正确性
#define HTTP_USER_PAYWD_VALIDATECODE_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT2,@"user/paywd-validatecode.action"]

//重置密码
#define HTTP_USER_RESET_PAYPASSWORD_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT2,@"user/reset-paypwd.action"]


/**********************钱包************************/
#pragma mark - 钱包
//可提现列表
#define HTTP_FINANCE_WITHDRAW_CANLIST_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"finance/withdraw/canwithdraw-list.action"]

//获取余额明细接口
#define HTTP_ACCOUNT_LIST_BILL_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"finance/account/listbill.action"]

//获取微信充值接口
#define HTTP_PAY_RECHARGE_WX_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"user/pay/recharge-wx.action"]

//获取支付宝充值接口
#define HTTP_PAY_RECHARGE_ALI_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"user/pay/recharge-ali.action"]

//银行卡列表
#define HTTP_USER_BANKCARD_LIST_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT2,@"user/bankcardlist.action"]

//提现
#define HTTP_FINANCE_WITHDRAW_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"finance/withdraw/withdraw.action"]

//绑卡
#define HTTP_USER_BINDING_CARD_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT2,@"user/bindingcard.action"]

//银行列表
#define HTTP_USER_BANK_LIST_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT2,@"user/banklist.action"]

//删除银行卡
#define HTTP_DELETE_BANK_CARD_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT2,@"user/delbankcard.action"]

//钱包详情
#define HTTP_USER_AMOUNT_INFO_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT2,@"user/amount.action"]


/**********************上传文件*********************/
#pragma mark - 上传文件
//请求上传路径
#define HTTP_FILE_GET_UPLOADURL_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"comm/file/getuploadurlbymd5.action"]

//上传完成校验
#define HTTP_FILE_UPLOAD_FINISHED_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"comm/file/uploadfinished.action"]

//上传图片
#define HTTP_FILE_UPLOAD_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"comm/file/upload.action"]

//下载图片
#define HTTP_FILE_DOWNLOAD_MD5_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"comm/file/download-md5.action"]

/**********************发布*项目*********************/
#pragma mark - 发布-项目
//项目类型菜单
#define HTTP_TYPE_LIST_PROJECTTYPE_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"project/list-type.action"]

//发布项目第一页
#define HTTP_PROJECT_SAVEPROJECT_FIRST_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"project/save-project-first.action"]

//发布项目第二页
#define HTTP_PROJECT_SAVEPROJECT_SECOND_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"project/save-project-second.action"]

//计算项目价格(明细)
#define HTTP_PROJECT_GETPROJECT_PRICE_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"project/get-project-price.action"]

//项目方查询自己发布的项目列表
#define HTTP_PROJECT_LIST_MYPROJECTS_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"project/list-my-projects.action"]

//项目方查询项目详情
#define HTTP_PROJECT_DETAIL_PROJECT_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"project/detail-project.action"]

//取消项目
#define HTTP_PROJECT_CANCEL_PROJECT_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"project/cancel-project.action"]

//删除项目
#define HTTP_PROJECT_REMOVE_PROJECT_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"project/remove-project.action"]

//修改项目第一页
#define HTTP_PROJECT_ALERT_PROJECT_FIRST_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"project/alter-project-first.action"]

//修改项目第二页
#define HTTP_PROJECT_ALERT_PROJECT_SENCOND_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"project/alter-project-second.action"]

//支付
#define HTTP_USER_ACCOUNT_PAYORDER_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"finance/account/payorder.action"]

//项目方验收项目
#define HTTP_PROJECT_CONFIRM_CHECK_PROJECT_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"project/confirm-check-project.action"]

//代替发单申请
#define HTTP_PROJECT_REPLACE_PUSH_PROJECT_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"project/replace-push-project.action"]

//新增项目图片
#define HTTP_PROJECT_ADD_PROJECT_IMAGES_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"project/add-project-images.action"]

//申请续单，申请需求变更
#define HTTP_PROJECT_APPLY_DEMAND_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"project/apply-demand.action"]

//取消续单申请，取消需求变更申请
#define HTTP_PROJECT_CANCEL_DEMAND_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"project/cancel-demand.action"]

//服务方查看首页订单列表
#define HTTP_ORDER_SHOW_LIST_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"project/order/show-list.action"]

//服务方查看我的项目列表
#define HTTP_ORDER_MY_LIST_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"project/order/my-list.action"]

//服务方查看订单详情
#define HTTP_ORDER_ORDER_DETAIL_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"project/order/order-detail.action"]

//服务方抢单接口
#define HTTP_ORDER_LIGHTNING_ORDERS_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"project/order/lightning-orders.action"]

//项目方 未付款，工作中项目数量
#define HTTP_PROJECT_COUNT_PROJECT_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"project/count-project.action"]

//接单方工作中项目数量
#define HTTP_ORDER_COUNT_ORDER_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"order/count-order.action"]


/**********************评论**********************/
#pragma mark - 评论

//项目方发布评论
#define HTTP_EVALUATE_ADD_EVALUATE_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"evaluate/add-evaluate.action"]

//服务方等级页面, 客户评价列表
#define HTTP_EVALUATE_SERVER_EVALUATE_LIST_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"evaluate/server-evaluate-list.action"]

//服务方等级页面, 项目经理评价列表
#define HTTP_EVALUATE_PROJECT_EVALUATE_LIST_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"evaluate/project-evaluate-list.action"]

//服务方等级说明页面
#define HTTP_EVALUATE_LEVEL_DETAILS_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"evaluate/level-details.action"]


/**********************首页**********************/
#pragma mark - 首页
//项目方首页查询用户作品列表
#define HTTP_HOME_WORK_LISTSERVER_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"user/work/list-users.action"]

//项目方首页banner图
#define HTTP_HOME_LIST_BANNERS_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"comm/list-banners.action"]

//项目方首页查询 交易项目数量和服务方注册数量
#define HTTP_HOME_COUNTS_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"comm/counts.action"]

//根据用户id查询用户作品
#define HTTP_WORK_LISTUSERWORKS_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"user/work/search-works.action"]

//获得筛选条件
#define HTTP_USER_GETWORK_PARAMS_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"user/work/get-work-params.action"]

/**********************用户**********************/
#pragma mark - 用户
//更新sign
#define HTTP_USER_UP_SIGN_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT2,@"user/up-sign.action"]

//获取验证码
#define HTTP_USER_GET_PHONE_CODE_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT2,@"user/receive-phone-code.action"]

//注册
#define HTTP_USER_USERREG_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT2,@"user/user-reg.action"]

//登录
#define HTTP_USER_LOGIN_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT2,@"user/login.action"]

//手机号快捷登录
#define HTTP_USER_PHONE_LOGIN_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT2,@"user/phone-login.action"]

//重置密码
#define HTTP_USER_UPDATE_PASSWORD_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT2,@"user/update-password.action"]

//查询个人信息
#define HTTP_USER_GET_INFO_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"user/get-info.action"]

//修改角色
#define HTTP_USER_UPDATE_EXTINFO_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"user/update-extinfo.action"]

//判断第三方账号是否绑定
#define HTTP_USER_ISEXIST_THIRD_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT2,@"user/isexist-thirdparty.action"]

//第三方登录
#define HTTP_USER_THIRD_LOGIN_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT2,@"user/thirdparty-login.action"]

//上传头像
#define HTTP_HEAD_UPLOAD_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT2,@"head/upload-original-head.action"]

//更新用户信息    
#define HTTP_USER_UPDATEUSER_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT2,@"user/updateuser.action"]


/**********************发票*********************/
#pragma mark - 发票
//可开发票列表
#define HTTP_FINANCE_INVOICE_CANBILL_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"finance/invoice/canbill-projects.action"]

//发票内容列表
#define HTTP_FINANCE_INVOICE_BILLCONTENT_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"finance/invoice/billcontent-type.action"]

//最近提交的公司抬头
#define HTTP_FINANCE_INVOICE_BILLTITLE_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"finance/invoice/billtitle.action"]

//申请发票
#define HTTP_FINANCE_INVOICE_INVOICING_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"finance/invoice/invoicing.action"]

//发票列表
#define HTTP_FINANCE_INVOICE_BILLLIST_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"finance/invoice/billlist.action"]

//发票详情
#define HTTP_FINANCE_INVOICE_BILL_INFO_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"finance/invoice/bill-info.action"]

//收货地址列表
#define HTTP_ADDRESS_LIST_ADDRESS_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"user/address/listAddress.action"]

//新增用户地址
#define HTTP_ADDRESS_SAVE_ADDRESS_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"user/address/saveAddress.action"]

//修改用户地址
#define HTTP_ADDRESS_UPDATE_ADDRESS_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"user/address/updateAddress.action"]

//设置默认地址
#define HTTP_ADDRESS_DEFAULF_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"user/address/default.action"]

//删除地址
#define HTTP_ADDRESS_REMOVE_ADDRESS_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"user/address/removeAddress.action"]

//查询用户默认地址
#define HTTP_ADDRESS_GET_DEFAULT_ADDRESS_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT3,@"user/address/getDefaultAddress.action"]


/*******************实名认证*******************/
#pragma mark - 实名认证

//申请实名认证
#define HTTP_AUTH_ADD_USERAUTH_URL [NSString stringWithFormat:@"%@%@",HTTP_ROOT2,@"auth/add-userauth-info.action"]


#endif /* HttpUrls_h */
