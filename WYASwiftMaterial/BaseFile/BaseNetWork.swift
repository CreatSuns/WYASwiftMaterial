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

typealias success = (Any) -> ();
typealias failure = (String) -> ();

class BaseNetWork: NSObject {
    /// 网络请求
    ///
    /// - Parameters:
    ///   - type: 请求方式r传入参数为.get .post 默认为get
    ///   - urlString: url
    ///   - parameters: 参数
    ///   - success: 成功
    ///   - failure: 失败
   class func requestData(_ type : MethodType, urlString : String, parameters : [String : Any]?, success : @escaping success, failure : @escaping failure) -> (){
        let method : HTTPMethod
        var coding : ParameterEncoding
        switch type {
        case .get:do {
            method = .get
            coding = URLEncoding.default
            break
            }
        case .post:do {
            method = .post
            coding = JSONEncoding.prettyPrinted
            break
            }
        default:do {
            method = .get
            coding = URLEncoding.default
            }
        }
        var params : [String : Any]
        if parameters == nil {
            params = [String : Any]()
        } else {
            params = parameters!
        }
        params["timestamp"] = NSDate.getNowTimeTimesSeconds()
        params["nonce_str"] = NSString.wya_randomString(withLength: 32)
        // 2.发送网络请求
        let infoDictionary = Bundle.main.infoDictionary!
        let majorVersion = infoDictionary["CFBundleShortVersionString"]
        var headers : HTTPHeaders = ["version" : majorVersion as! String,
                                     "platform" : "ios"+UIDevice.current.systemVersion,
                                     "sign" : BaseNetWork.paramsTurnString(params)]
        if let token = UserDefaults.standard.string(forKey: "token") {
            headers["token"] = token
        }
        wyaPrint("请求方式:\(method)\n请求地址:\(urlString)\n请求头:\(headers)\n请求参数:\(params)")
        Alamofire.request(urlString, method: method, parameters: parameters,encoding: coding, headers:headers).responseJSON { (response) in
            switch response.result{
            case .success:
                if let value = response.result.value as? [String : Any]{
                    let status:Int = value["status"] as! Int
                    if status == 1{
                        wyaPrint("请求成功results:\(value)")
                        success(value as Any)
                    }else if status == 0 {
                        if(value["msg"] as! String == "请先选择产品线后再继续操作"){
                            // 回到登录界面
                            Window?.rootViewController = UINavigationController.init(rootViewController: LoginViewController())
                        }else{
                        UIView.wya_showCenterToast(withMessage: value["msg"] as! String)
                        }
                    }else if status == -1{
                        UIView.wya_showCenterToast(withMessage: value["msg"] as! String)
                        Window?.rootViewController = UINavigationController.init(rootViewController: LoginViewController())
                    }

                }
            case .failure(let error):
                wyaPrint("error:\(error.localizedDescription)")
                failure(error.localizedDescription)
            }
        }
    }
}

extension BaseNetWork {
    class func paramsTurnString(_ params : [String : Any]) -> String {
        let dic = params.sorted { (str1, str2) -> Bool in
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

                } else if item.1 is Int {
                    print(item.1)
                    let aaa = item.1 as! Int

                    str = item.0 + "=" + String(aaa)
                    arr.append(str)
                }
            }
        }
        let sss = arr.joined(separator: "&")

        let resultString = (sss + "il3qTF7xaXLsiXff4YqYCeNrsI9Ne3ev") as NSString
        wyaPrint("加密前：\(resultString)")
        let md5String = NSString.wya_md5With(resultString)() as String
        wyaPrint("加密后：\(md5String)")
        return md5String 
    }
}


//class BaseNetWork: NSObject {
//
//   /// get post 请求
//   ///
//   /// - Parameters:
//   ///   - type: 请求方式传入参数为.get .post
//   ///   - URLString: 请求的URlString
//   ///   - paramenters: 需要拼接的参数如果为get请求可以不填写
//   ///   - finishedCallback: 请求数据返回
//   class func requestData(_ type:MethodType,
//                          URLString:String,
//                          paramenters:[String : Any]? = nil,
//                          finishedCallback:@escaping(_ result : Any)->()) {
//        // 1.获取请求的类型
//        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
//        var params : [String : Any]
//        if paramenters == nil {
//            params = [String : Any]()
//        } else {
//            params = paramenters!
//        }
//        params["timestamp"] = NSDate.getNowTimeTimesSeconds()
//        params["nonce_str"] = NSString.wya_randomString(withLength: 32)
//        // 2.发送网络请求
//        let infoDictionary = Bundle.main.infoDictionary!
//        let majorVersion = infoDictionary["CFBundleShortVersionString"]
//
//        var headers : HTTPHeaders = ["version" : majorVersion as! String,
//                                     "platform" : "ios"+UIDevice.current.systemVersion,
//                                     "sign" : BaseNetWork.paramsTurnString(params)]
//
//        if let token = UserDefaults.standard.string(forKey: "token") {
//            headers["token"] = token
//        }
//
//        var coding : ParameterEncoding
//        if type == .post {
//            coding = JSONEncoding.prettyPrinted
//        } else {
//            coding = URLEncoding.default
//        }
//        wyaPrint("请求方式:\(method)")
//        wyaPrint("请求地址:\(URLString)")
//        wyaPrint("请求头:\(headers)")
//        wyaPrint("请求参数:\(params)")
//
//        Alamofire.request(URLString, method: method, parameters: params, encoding: coding, headers:headers).responseJSON { (response) in
//                // 3.获取结果
//            guard response.result.value != nil else {
//                    print(response.result.error!)// 请求出现错误会输出error
//                    return
//                }
//                // 4.将结果回调出去
//            wyaPrint("请求结果:\(response.result)")
//                finishedCallback(response.data as Any)
//            }
//        }
//}
