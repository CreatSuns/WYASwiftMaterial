//
//  WYAJSONDecode.swift
//  WYASwiftMaterial
//
//  Created by 李俊恒 on 2019/8/14.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

import UIKit

class JHJSONDecode: NSObject {
    public class func jhJSONdecode<T>(_ type:T.Type, from json:Any) throws -> T where T:Decodable{
        let data = try?JSONSerialization.data(withJSONObject: json, options: [])
        return try JSONDecoder().decode(type, from: data!)
    }
}
