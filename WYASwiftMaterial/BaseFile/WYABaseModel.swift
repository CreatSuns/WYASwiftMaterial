//
//  WYABaseModel.swift
//  WYASwiftMaterial
//
//  Created by 李世航 on 2019/7/4.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

import Foundation

struct WYABaseModel : Codable {

}

public struct WYABaseType : Codable {
    var bool: Bool {
        didSet {
            if bool {
                int = 1
                string = "1"
            } else {
                int = 0
                string = "0"
            }
        }
    }

    var int:Int {
        didSet {
            let stringValue = String(int)
            if  stringValue != string {
                string = stringValue
            }
            if int > 0 {
                bool = true
            } else {
                bool = false
            }
        }
    }

    var string:String {
        didSet {
            let boolValue = Int(string) ?? 0
            if boolValue > 0 {
                bool = true
            } else {
                bool = false
            }

            if let intValue = Int(string), intValue != int {
                int = intValue
            }
        }
    }

    //自定义解码(通过覆盖默认方法实现)
    public init(from decoder: Decoder) throws {
        let singleValueContainer = try decoder.singleValueContainer()

        if let stringValue = try? singleValueContainer.decode(String.self)
        {
            string = stringValue
            int = Int(stringValue) ?? 0
            if stringValue == "1" {
                bool = true
            } else {
                bool = false
            }

        } else if let intValue = try? singleValueContainer.decode(Int.self)
        {
            int = intValue
            string = String(intValue);
            if intValue == 1 {
                bool = true
            } else {
                bool = false
            }

        } else if let boolValue = try? singleValueContainer.decode(Bool.self)
        {
            bool = boolValue
            if boolValue {
                int = 1
                string = "1";
            } else {
                int = 0
                string = "0";
            }

        } else
        {
            int = 0
            string = ""
            bool = false
        }
    }
}
