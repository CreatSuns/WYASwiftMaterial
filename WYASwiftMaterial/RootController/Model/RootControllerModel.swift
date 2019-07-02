//
//  RootControllerModel.swift
//  WYASwiftEnv
//
//  Created by 李俊恒 on 2018/8/14.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

import UIKit

class RootControllerModel: NSObject {
    var tabBarTitle : String?
    var className : String?
    var normalImageName : String?
    var selectedImageName : String?
    
    /// 获取一个tabBarItem的model
    ///
    /// - Parameters:
    ///   - tabBarTitle: tabBarTitle
    ///   - className: 类名称例如：HomeViewController
    ///   - normalImageName: normal状态图片
    ///   - selectefImageName: 选中状态图片
    /// - Returns: 返回一个赋值完成的model
    static func rootCOntrollerModel(tabBarTitle:String, className:String, normalImageName:String, selectefImageName:String) -> RootControllerModel {
        let model = RootControllerModel()
        model.tabBarTitle = tabBarTitle
        model.className = className
        model.normalImageName = normalImageName
        model.selectedImageName = selectefImageName
        return model
    }
    
    func normalImag() -> UIImage {
        let norImg = UIImage.init(named: normalImageName!)!.withRenderingMode(.alwaysOriginal)
        return norImg
    }
    
    func selectedImg() -> UIImage {
        let selectedImg = UIImage.init(named: selectedImageName!)!.withRenderingMode(.alwaysOriginal)
        return selectedImg
    }
}
