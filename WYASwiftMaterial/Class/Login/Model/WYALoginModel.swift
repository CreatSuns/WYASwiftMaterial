//
//  WYALoginModel.swift
//  WYASwiftMaterial
//
//  Created by 李世航 on 2019/6/20.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

import UIKit

struct WYALoginDataModel : Codable {
    struct WYALoginUserInfoModel : Codable {
        struct WYAAgentItem : Codable {
            var prefix_mobile : String?
            var agent_mobile : String?
            var admin_id : WYABaseType?
            var agent_level_name : String?
            var agent_level : Int?
            var agent_avatar : String?
            var agent_wechat : String?
            var agent_id : Int?
            var system_id : Int?
            var merchant_id : Int?
            var product_line_name : String?
            var company_name : String?
            var agent_name : String?
            var brand_logo : String?
            var member_id : Int?
            var ischoose : Bool?
        }
        var user_id : Int?
        var access_token : String?
        var login_time : String?
        var agent : [WYAAgentItem]?

        var expiration_time : Int?
        var mobile : String?
    }
    var status : Int?
    var msg : String?
    var data : WYALoginUserInfoModel?

}

class WYALoginModel: BaseNetWork {

    public class func login (_ userName : String, _ password : String, handle:@escaping (WYALoginDataModel) -> Void) {
        let params = ["mobile":userName.replacingOccurrences(of: " ", with: ""),
                      "pwd":password,
                      "device_type":"1",
                      "device_token":""] as [String : Any]

        WYALoginModel.requestData(.post, URLString: loginUrl, paramenters: params) { (result) in
            wyaPrint("请求结果:\(result)")
            var model : WYALoginDataModel? = nil
            do {
                model = try JSONDecoder().decode(WYALoginDataModel.self, from: result as! Data)
                let agentArray:Array<WYALoginDataModel.WYALoginUserInfoModel.WYAAgentItem> = (model?.data?.agent!)!
                guard agentArray.count >= 1 else{
                    return
                }
                for var item in agentArray{
                        item.ischoose = false
                }
            } catch let error {
                wyaPrint(error)
            }
            UserDefaults.standard.set(model?.data?.access_token, forKey: "token")
            UserDefaults.standard.synchronize()
            handle(model ?? WYALoginDataModel())
        }
    }

    static func chooseProductLin(adminId:Int,handle:@escaping (Any)-> Void){
        let params = ["admin_id":adminId]
        WYALoginModel.requestData(.post, URLString: chooseProductLine, paramenters: params) { (result) in
            handle(result)
        }

    }

}
