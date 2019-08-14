//
//  WYALoginLocalModel.swift
//  WYASwiftMaterial
//
//  Created by 李俊恒 on 2019/8/8.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

import UIKit
import RealmSwift
class WYALoginLocalModel: Object {
    /// 产品id
    @objc dynamic var admin_id: Int = 0
    /// 代理商id
    @objc dynamic var agent_id:  Int = 0
    /// 商户id
    @objc dynamic var merchant_id:  Int = 0
    /// 系统id
    @objc dynamic var system_id:  Int = 0
    /// 产品名称
    @objc dynamic var product_line_name: String? = ""
    /// 代理商微信号
    @objc dynamic var agent_wechat: String? = ""
    /// 代理等级名称
    @objc dynamic var agent_level_name: String? = ""
    /// 代理商等级
    @objc dynamic var agent_level: Int = 0
    /// 公司名称
    @objc dynamic var company_name: String? = ""
    /// 手机号前缀
    @objc dynamic var prefix_mobile: String? = ""
    /// 手机号
    @objc dynamic var agent_mobile: String? = ""
    /// 代理商头像
    @objc dynamic var agent_avatar: String? = ""
    /// 代理名称
    @objc dynamic var agent_name: String? = ""
    @objc dynamic var brand_logo: String? = ""
    @objc dynamic var member_id:  Int = 0
    /// 是否是被选中的产品线
    @objc dynamic var isChoose: Bool = false

}

/// Realm本地化存储的类
class WYALoginLocalModelTool: NSObject {

   /// 存储登录的代理产品线信息
   ///
   /// - Parameter agentLoginModels: 产品线信息模型
   static func saveLoginLocalModel(agentLoginModels:Array<WYALoginDataModel.WYALoginUserInfoModel.WYAAgentItem>) {
        let realm = try! Realm()
        for item in agentLoginModels{
            let adminId = item.admin_id?.int ?? 0
            let model = WYALoginLocalModel(value: ["admin_id":adminId,
                                                   "agent_id":item.agent_id ?? 0,
                                                   "merchant_id":item.merchant_id ?? 0,
                                                   "system_id":item.system_id ?? 0,
                                                   "product_line_name":item.product_line_name ?? "",
                                                   "agent_wechat":item.agent_wechat ?? "",
                                                   "agent_level_name":item.agent_level_name!,
                                                   "agent_level":item.agent_level ?? 0,
                                                   "company_name":item.company_name!,
                                                   "prefix_mobile":item.prefix_mobile!,
                                                   "agent_mobile":item.agent_mobile!,
                                                   "agent_avatar":item.agent_avatar!,
                                                   "agent_name":item.agent_name!,
                                                   "brand_logo":item.brand_logo!,
                                                   "member_id":item.member_id ?? 0,
                                                   "isChoose":item.ischoose ?? false])
            try! realm.write {
                realm.add(model)
            }
        }
    }

    /// 更新模型
    ///
    /// - Parameter model: 需要更新的模型
    static func updateLoginAgentListData(model:WYALoginDataModel.WYALoginUserInfoModel.WYAAgentItem){
        let  realm = try!Realm()
        let results = realm.objects(WYALoginLocalModel.self).filter("admin_id==%d",model.admin_id?.int ?? 0)
        let tempModel = results.first!

        try! realm.write {
            tempModel.admin_id = model.admin_id?.int ?? 0
            tempModel.isChoose = model.ischoose ?? false
        }
    }

    /// 按照条件查询获取数据模型
    ///
    /// - Parameter whereString: 需要查询的字符串
    /// - Returns: 返回一个产品线信息的模型
    static func lookpLoginAgentListData(whereString:String)->WYALoginLocalModel{
        let  realm = try!Realm()
        let results = realm.objects(WYALoginLocalModel.self).filter(whereString)
        let tempModel = results.first!
        return tempModel
    }

    /// 删除所有realm存储的数据
    static func deleteLoginAgentListData(){
        let  realm = try!Realm()
    let results = realm.objects(WYALoginLocalModel.self)
        guard results.count > 0 else {
            return
        }
        try!realm.write {
            realm.deleteAll()
        }
    }

    /// 删除指定的产品线模型
    ///
    /// - Parameter model: 需要删除的产品线模型
    static func deleteLoginAgentData(model:WYALoginLocalModel){
        let realm = try!Realm()
        realm.delete(model)

    }

}
