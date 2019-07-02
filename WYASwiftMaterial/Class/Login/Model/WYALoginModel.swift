//
//  WYALoginModel.swift
//  WYASwiftMaterial
//
//  Created by 李世航 on 2019/6/20.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

import UIKit

class WYALoginModel: BaseNetWork {
    public class func login (_ userName : String, _ password : String) {
        let params = ["mobile":userName,
                      "pwd":password,
                      "device_type":1,
                      "device_token":"",
                      "timestamp":NSDate.getNowTimeTimesSeconds(),
                      "nonce_str":NSString.wya_randomString(withLength: 32)] as [String : Any]

        WYALoginModel.requestData(.post, URLString: loginUrl, paramenters: params) { (result) in
            print(result)
        }
    }
}
