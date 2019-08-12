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

    static func stringReplace(patten:String, str:String, replaceString:String) -> String {
        guard str.count > 0 else {
            return ""
        }
        var string = str.trimmingCharacters(in: .newlines)
        var regular : NSRegularExpression
        do {
            regular = try NSRegularExpression(pattern: patten, options: .caseInsensitive)
            string = regular.stringByReplacingMatches(in: string, options: .reportProgress, range: NSMakeRange(0, string.count), withTemplate: replaceString)
            return string
        } catch {
            return ""
        }
    }

    /// Range转换为NSRange
    func nsRange(from range: Range<String.Index>) -> NSRange {
        let from = range.lowerBound.samePosition(in: utf16)
        let to = range.upperBound.samePosition(in: utf16)
        return NSRange(location: utf16.distance(from: utf16.startIndex, to: from!),
                       length: utf16.distance(from: from!, to: to!))
    }

    /// NSRange转换为Range
    func range(from nsRange: NSRange) -> Range<String.Index>? {
        guard
            let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location,
                                     limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: nsRange.length,
                                   limitedBy: utf16.endIndex),
            let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self)
            else { return nil }
        return from ..< to
    }
}
