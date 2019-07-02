//
//  PrintTool.swift
//  WYASwiftEnv
//
//  Created by 李俊恒 on 2018/8/14.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

import UIKit

class PrintTool: NSObject {
    
   /// 自定义debug和release状态的打印
    /// 由于Swift没有宏的概念 所以:TARGET -> Build Setting -> Other Swift Flags 的Debug状态加一个 -D DebugType
    /// 可以通过release模式和debug模式控制是否需要输出
   /// - Parameter content: 需要打印的内容
   static func debugPrint(_ content:Any) -> Void {
        #if DEBUG
        print(content)
        #else
    
        #endif
    }
}
