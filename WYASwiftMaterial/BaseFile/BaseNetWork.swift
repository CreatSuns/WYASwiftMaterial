//
//  BaseNetWork.swift
//  WYASwiftEnv
//
//  Created by 李俊恒 on 2018/8/16.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

import UIKit
import Alamofire
enum MethodType {
    case get
    case post
}

class BaseNetWork: NSObject {
    
   /// get post 请求
   ///
   /// - Parameters:
   ///   - type: 请求方式传入参数为.get .post
   ///   - URLString: 请求的URlString
   ///   - paramenters: 需要拼接的参数如果为get请求可以不填写
   ///   - finishedCallback: 请求数据返回
   class func requestData(_ type:MethodType,URLString:String,paramenters:[String : Any]? = nil ,finishedCallback:@escaping(_ result : Any)->()) {
        // 1.获取请求的类型
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        // 2.发送网络请求
    let infoDictionary = Bundle.main.infoDictionary!
    let majorVersion = infoDictionary["CFBundleShortVersionString"]

    let headers = ["version": majorVersion as! String,
                   "platform":"ios"+UIDevice.current.systemVersion,
                   "sign":BaseNetWork.paramsTurnString(paramenters)]

    Alamofire.request(URLString, method: method, parameters: paramenters,encoding: JSONEncoding.prettyPrinted, headers:headers as? HTTPHeaders).responseJSON { (response) in
            // 3.获取结果
            guard let result = response.result.value else {
                print(response.result.error!)// 请求出现错误会输出error
                return
            }
            // 4.将结果回调出去
            finishedCallback(response.data)
        }
    }
}

extension BaseNetWork {
    class func paramsTurnString(_ params : [String : Any]?) -> String {
        guard (params != nil) else { return "" }

        let dic = params!.sorted { (str1, str2) -> Bool in
            return str1.0 < str2.0
        }
        var arr = [String]()

        for item in dic {
            var str : String

            if item.1 is Array<Any> {

            } else {
                if item.1 is String {
                    let aaa = item.1
                    let b = aaa as! String
                    let c = b.trimmingCharacters(in: CharacterSet.whitespaces)
                    if c.count > 0 {
                        str = item.0 + "=" + c
                        arr.append(str)
                    }

                } else {
                    print(item.1)
//                    str = item.0 + "=" + item.1
                }
            }
        }
        let sss = arr.joined(separator: "&")

        let resultString = (sss + "il3qTF7xaXLsiXff4YqYCeNrsI9Ne3ev") as NSString
        print(resultString)
        let md5String = NSString.wya_md5With(resultString)() as String

        return md5String 
    }
}
