//
//  String.swift
//  WYASwiftEnv
//
//  Created by 李俊恒 on 2018/8/15.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

import Foundation
import UIKit
extension String{
    
    /// 根据内容计算文字最大宽度
    ///
    /// - Parameters:
    ///   - font: 字体大小
    ///   - maxHeight: 最大高度
    /// - Returns: 返回最大宽度
    func getNormalStringMaxWidth(font:CGFloat, maxHeight:CGFloat) -> CGFloat {
        let attrs = [NSAttributedStringKey.font:UIFont.systemFont(ofSize: font)]
        let strSize = (self as NSString).boundingRect(with: CGSize(width: 0, height: maxHeight), options: [NSStringDrawingOptions.usesLineFragmentOrigin,.usesFontLeading,.truncatesLastVisibleLine], attributes: attrs, context: nil)
        return strSize.width
    }
    
    /// 根据内容计算文字最大高度
    ///
    /// - Parameters:
    ///   - font: 计算的文字字体大小
    ///   - maxWidth: 最大宽度
    /// - Returns: 返回最大高度
    func getNormalStringMaxHeight(font:CGFloat, maxWidth:CGFloat) -> CGFloat {
        let attrs = [NSAttributedStringKey.font:UIFont.systemFont(ofSize: font)]
        let strSize = (self as NSString).boundingRect(with: CGSize(width: maxWidth, height: 0), options: [NSStringDrawingOptions.usesLineFragmentOrigin,.usesFontLeading,.truncatesLastVisibleLine], attributes: attrs, context: nil)
        return strSize.height + font
    }
}
