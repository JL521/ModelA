//
//  Constant.swift
//  Rencaiyoujia
//
//  Created by zhangyu on 2019/9/6.
//  Copyright © 2019 zhangyu. All rights reserved.
//

import UIKit

public var screen_width     = UIScreen.main.bounds.width
///screen height
public var screen_height    = UIScreen.main.bounds.height

public var currentLanguages = UserDefaults.standard.object(forKey: "AppleLanguages")

enum SysCode:String{
    case register = "REGISTER"
    case forget   = "FORGOTPASSWORD"
    case modify   = "MODIFYPHONE"
    case enterprise_register = "ENTERPRISE_REGISTER"
    case enterprise_forget   = "ENTERPRISE_FORGOTPASSWORD"
    case enterprise_modify   = "ENTERPRISE_MODIFYPHONE"
    case wechat   = "wechat"
}

enum APIConst:String{
    case device = "iOS"
}

enum StoryBoardName:String{
    case Main               = "Main"
    case Login              = "Login"
    case News               = "News"
    case Mine               = "Mine"
    case Bank               = "Bank"
    case Order              = "Order"
    case Funds              = "Funds"
    case Recruit            = "Recruit"
    case SocailStatusDetail = "SocailStatusDetail"
    case TeamSocialStatus   = "TeamSocialStatus"
    case Empowerment        = "Empowerment"
    case Publish            = "Publish"
    case OrderList            = "OrderList"
    case MyShop            = "MyShop"
    case Demand            = "Demand"
    case Financial  = "Financial"
    case GorvernmentJob  = "GorvernmentJob"
    case WorkQuickAccess  = "WorkQuickAccess"
    case Jobwanted  = "Jobwanted"
    case ManagerPosition  = "ManagerPosition"
}

enum StroyBoardViewcontrollerIdentity:String{
    case LoginViewcontroller                  = "LoginViewcontroller"
    case SettingTableViewController           = "SettingTableViewControllerNav"
    case UserInfoViewController               = "UserInfoViewController"
    case RealNameAuthenticationViewController = "RealNameAuthenticationViewController"
    case EnterpriseAuthViewController         = "EnterpriseAuthViewController"
    case EnterpriseStatusViewController         = "EnterpriseStatusViewController"
    case ContainPayViewController             = "ContainPayViewController"
    case ProductDetailViewController          = "ProductDetailViewController"
    case AccessSelectViewController           = "AccessSelectViewController"
    case MyTeamViewControllerNav              = "MyTeamViewControllerNav"
    case TeamDetailViewController             = "TeamDetailViewController"
    case MyTeamViewController                 = "MyTeamViewController"
    case CreateGroupViewController            = "CreateGroupViewController"
    case HasMeTeamViewController              = "HasMeTeamViewController"
    case WaitReciveViewController            = "WaitReciveViewController"
    case SocialStatusDetailViewController     = "SocialStatusDetailViewController"
    case WalletViewController                 = "WalletViewController"
    case WalletViewControllerNav              = "WalletViewControllerNav"
    case NewsViewController                   = "NewsViewController"
    case BankViewController                   = "BankViewController"
    case BankViewControllerNav                = "BankViewControllerNav"
    case OrderDetailViewController            = "OrderDetailViewController"
    case FundsViewControllerNav               = "FundsViewControllerNav"
    case ProductViewController                = "ProductViewController"
    case InsuranceDetailViewController        = "InsuranceDetailViewController"
    case FundsDetailViewController            = "FundsDetailViewController"
    case RecruitViewControllerNav             = "RecruitViewControllerNav"
    case RecruitViewControllerEdit            = "RecruitViewControllerEdit"
    case JobWantedViewControllerNav           = "JobWantedViewControllerNav"
    case JobWantedViewController              = "JobWantedViewController"
    case SeekJobInfoNav                       = "SeekJobInfoNav"
    case RegisterSuccessViewController        = "RegisterSuccessViewController"
    case BindPhoneNumViewController           = "BindPhoneNumViewController"
    case EmpowermentViewControllerNav           = "EmpowermentViewControllerNav"
    case EmpowerProductDetailViewController           = "EmpowerProductDetailViewController"
    case CreditGrantingViewController           = "CreditGrantingViewController"
    case CreditGrantingBaseInputViewController           = "CreditGrantingBaseInputViewController"
    case PublishViewController                     = "PublishViewController"
    case PublishViewControllerNav                     = "PublishViewControllerNav"
    case EnterPrisePublishViewController           = "EnterPrisePublishViewController"
    case EnterPrisePublishViewControllerNav           = "EnterPrisePublishViewControllerNav"
    case ShopOrderListViewControllerNav           = "ShopOrderListViewControllerNav"
    case ShopOrderDetailViewController           = "ShopOrderDetailViewController"
    case MyShopNav                               = "MyShopNav"
    case DemandHallViewControllerNav                               = "DemandHallViewControllerNav"
    case FinancialServiceNav                               = "FinancialServiceNav"
    case ShopViewController                               = "ShopViewController"
    case DemandInfoViewController                               = "DemandInfoViewController"
    case DemandDetailViewController                               = "DemandDetailViewController"
    case MainTabBarViewController                               = "MainTabBarViewController"
    case ShopSettingViewController                               = "ShopSettingViewController"
    case PublishServersViewController                               = "PublishServersViewController"
    case PublishDemandViewController                               = "PublishDemandViewController"
    case ProductServiceManagerVC                               = "ProductServiceManagerVC"
    case GovmentHallViewController                               = "GovmentHallViewController"
    case BankSubmitInfoViewController                               = "BankSubmitInfoViewController"
    case MyBankCardViewController                               = "MyBankCardViewController"
    case PayCoinListViewController                               = "PayCoinListViewController"
    case StatementViewControllerNav                               = "StatementViewControllerNav"
    case ProductWebViewController                               = "ProductWebViewController"
    case WorkQuickAccessViewControllerNav                               = "WorkQuickAccessViewControllerNav"
    case JobWantListControllerViewController = "JobWantListControllerViewController"
    case ManagerPositionTableViewController = "ManagerPositionTableViewController"
    case UseIntroduceViewController                               = "UseIntroduceViewController"
    case CreditGrantingResultViewController                               = "CreditGrantingResultViewController"
    case ShopQRPayViewController                               = "ShopQRPayViewController"
    case InviteCodeViewController                               = "InviteCodeViewController"
}

enum UserDefaultKeys:String{
    case GlobalModelKey = "GlobalModelKey"
}

enum NotificationKey: String{
    case UpdateMineUI = "UpdateMineUI"
    case UpdateUserInfo = "UpdateUserInfo"
    case UpdateShopInfo = "UpdateShopInfo"
    case PublishRefreshPop = "PublishRefreshPop"
}

///文章ID，有很多都是固定写死的
enum ArticleId:Int{
    case accessStatement = 234
}

//Mark: -  Key区域维护

///微信APPID
let wechat_appid  = "wxcd47aaf4291d893d"
///微信wechat_secret
let wechat_secret  = "ea75c3a6ada6bbd0ab07a06ddf5a2bc9"
///universalLink
let universalLink = "https://atix.t4m.cn/"


///钉钉APPID
let dingTalk_appid  = "dingoazp4oyojlfzpvswwo"


///QQ APPID
let qq_appid  = "1108743822"
let qq_secret  = "72sezzOc4RLu1ZbB"


//是否是开发环境

#if DEBUG
let develop = true
let buglyAppid = "a4f7b51ead"
#else
let develop = false
let buglyAppid = "9ca8374172"
#endif
