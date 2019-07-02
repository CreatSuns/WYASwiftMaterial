//
//  WYABaseConfig.swift
//  WYASwiftEnv
//
//  Created by 李俊恒 on 2018/8/14.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

import Foundation
import UIKit

func WYA_RGB_COLOR(r:CGFloat, g:CGFloat, b:CGFloat) -> UIColor {
    return UIColor.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
}

func random(r:CGFloat,g:CGFloat,b:CGFloat,a:CGFloat) -> UIColor {
     return UIColor.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}

func randomColor() -> UIColor {
    return random(r: CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b:  CGFloat(arc4random_uniform(256)), a:  CGFloat(arc4random_uniform(256)))
}

func FONT(s:CGFloat) -> UIFont {
   return UIFont.systemFont(ofSize: s*SizeAdapter)
}

func FONTS(s:CGFloat) -> UIFont {
    return UIFont.boldSystemFont(ofSize: s*SizeAdapter)
}

let ScreenWidth = UIScreen.main.bounds.size.width

let ScreenHeight = UIScreen.main.bounds.size.height

let ScreenBounds = UIScreen.main.bounds

/// 以iphone6为基准
let SizeAdapter = ScreenWidth/375

let RectStatus = UIApplication.shared.statusBarFrame

let WYAStatusBarHeight = RectStatus.size.height

let WYANavBarHeight = CGFloat(44.0)

let WYATabBarHeight = CGFloat((WYAStatusBarHeight > 20 ? 83:49))

let WYABottomHeight = CGFloat((WYAStatusBarHeight > 20 ? 34:0))

let WYATopHeight = (WYAStatusBarHeight + WYANavBarHeight)

let isiphoneX = (WYAStatusBarHeight > 20 ? true:false)

let Window = UIApplication.shared.keyWindow

/// 自定义debug和release模式下的打印输出控住
///
/// - Parameter item: 需要打印的内容类型为Any
func wyaPrint(_ item:Any) -> Void {
    PrintTool.debugPrint(item)
}

