//
//  WYAAgentRingModel.swift
//  WYASwiftMaterial
//
//  Created by 李世航 on 2019/6/20.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

import UIKit

class WYAAgentRingModel : Codable {
    class WYAAgentRingListModel : Codable {
        class WYAAgentRingListItemModel : Codable {
            class CommentItem : Codable {
                var comment_id : Int?
                var agent_name : String?
                var content : String?
                var show : Bool?
            }

            enum CircleStatus : Int, Codable {
                case waiting = 1
                case pass = 2
                case fail = 3
            }

            var circle_status : CircleStatus?
            var circle_id : Int?
            var agent_id : Int?
            var agent_name : String?
            var content : String?
            var point_num : Int?
            var agent_level_name : String?
            var is_collect : WYABaseType?
            var is_point : WYABaseType?
            var image : [String]? = []
            var comment : [CommentItem]? = []
            var create_time : String?
            var circle_pass_id : Int?
            var refuse_reason : String?

            var contentShow : Bool?
            var contentHeight: Float {
                var height = UILabel.getHeightByWidth(ScreenWidth - 74 * SizeAdapter, title: content, font: FONT(s: 16))
                if height > 38 * SizeAdapter {
                    height = 39 * SizeAdapter
                }
                return Float(height)
            }
            var imageSuperHeight: Float {
                let height = WYAAgentRingModel.getISH(model: self)

                return height
            }
            var cellHeight : Float {
                return WYAAgentRingModel.cellH(model: self)
            }
            var footHeight : Float {
                return Float(WYAAgentRingModel.footH(model: self))
            }
            var commentHeight : CGFloat?
            var commentHeightArray : [CGFloat]?



//            // 自定义字段，覆盖返回参数的键需要在实现里声明所有的key
//            enum CodingKeys : String, CodingKey {
//                case agentName = "agent_name"
//            }
            
//            required init(from decoder : Decoder) throws {
//                let values = try decoder.container(keyedBy: CodingKeys.self)
//                circle_status = WYAAgentRingModel.WYAAgentRingListModel.WYAAgentRingListItemModel.CircleStatus(rawValue: try values.decode(Int.self, forKey: .circle_status))
//                circle_id = try values.decode(Int.self, forKey: .circle_id)
//                agent_id = try values.decode(Int.self, forKey: .agent_id)
//                agent_name = try values.decode(String.self, forKey: .agent_name)
//                content = try values.decode(String.self, forKey: .content)
//                point_num = try values.decode(Int.self, forKey: .point_num)
//                agent_level_name = try values.decode(String.self, forKey: .agent_level_name)
//                is_collect = try values.decode(WYABaseType.self, forKey: .is_collect)
//                is_point = try values.decode(WYABaseType.self, forKey: .is_point)
//
//                create_time = try values.decode(String.self, forKey: .create_time)
//                circle_pass_id = try values.decode(Int.self, forKey: .circle_pass_id)
//                refuse_reason = try values.decode(String.self, forKey: .refuse_reason)
//                contentShow = (try values.decode(Bool.self, forKey: .contentShow))
//
//            }
        }

        var list : [WYAAgentRingListItemModel]?
    }
    var data : WYAAgentRingListModel?

}

extension WYAAgentRingModel {
    static func getISH(model : WYAAgentRingModel.WYAAgentRingListModel.WYAAgentRingListItemModel) -> Float {
        guard model.image!.count > 0 else {
            return Float(0.0)
        }
        guard model.image!.count > 2 else {
            return Float(ScreenWidth - 190.5 * SizeAdapter)
        }
        var height : Float = 0.0

        let itemHeight = (ScreenWidth - 130 * SizeAdapter) / 3
        let row = model.image!.count / 3
        let column = model.image!.count % 3
        if column == 0 {
            // 整除的
            if row > 1 {
                let allItemHeight = Float(itemHeight) * Float(row)
                let allPadding = Float(5 * SizeAdapter) * Float(row - 1)

                height = allItemHeight + allPadding;
            } else {
                height = Float(itemHeight);
            }
        } else {
            if row > 0 {
                let allItemHeight = Float(itemHeight) * Float(row + 1)
                let allPadding = Float(5 * row) * Float(SizeAdapter)

                height = allItemHeight + allPadding;
            } else {
                height = Float(itemHeight);
            }
        }
        return height
    }

    static func cellH(model:WYAAgentRingModel.WYAAgentRingListModel.WYAAgentRingListItemModel) -> Float {
        var height : Float = 67.5 * Float(SizeAdapter)
        if model.contentShow == true {
            height = height + model.contentHeight
        } else {
            if model.contentHeight > Float(38 * SizeAdapter) {
                height = height + Float(38 * SizeAdapter)
            } else {
                height = height + model.contentHeight
            }
        }

        if model.contentHeight > Float(38 * SizeAdapter) {
            height = height + Float(21.5 * SizeAdapter);
        }

        if model.image!.count > 0 {
            height = height + Float(10.5 * SizeAdapter) + model.imageSuperHeight
        }

        if model.circle_status == .waiting {
            height = height + Float(48.5 * SizeAdapter);
        } else if model.circle_status == .pass {
            height = height + Float(30.5 * SizeAdapter)
            if model.comment!.count > 0 {
                height = height + Float(8.5 * SizeAdapter)
            } else {
                height = height + Float(18.5 * SizeAdapter)
            }
        } else if model.circle_status == .fail {

        }
        return height
    }

    static func commentH(model:WYAAgentRingListModel.WYAAgentRingListItemModel, array:[CGFloat]) -> CGFloat {
        var height = CGFloat(0.0)
        if model.comment!.count > 0 {
            var allHeight = CGFloat(0.0)
            let number = array.count > 2 ? 2 : array.count
            for i in 0..<number {
                let number = array[i]
                if i == 0 {
                    allHeight = allHeight + number + 10 * SizeAdapter
                } else {
                    allHeight = allHeight + number + 6 * SizeAdapter
                }
            }
            height = allHeight + 6 * SizeAdapter
        }
        return height
    }

    static func footH(model:WYAAgentRingListModel.WYAAgentRingListItemModel) -> CGFloat {
        var heightArray = [CGFloat]()

        func commentsAttributedString(model:WYAAgentRingListModel.WYAAgentRingListItemModel.CommentItem) -> NSMutableAttributedString {
            let closeString = "收起"
            let content = String.stringReplace(patten: "(\r?\n(\\s*\r?\n)+)", str: model.content ?? "", replaceString:"\n\n")
            var string : String
            var closeRange : NSRange = NSMakeRange(0, 0)

            if model.show == true {
                string = model.agent_name! + content + closeString
                closeRange = string.nsRange(from: string.range(of: closeString)!)
            } else {
                string = model.agent_name! + content
            }
            let text = NSMutableAttributedString(string: string)
            let commentRange = string.nsRange(from: string.range(of: model.content!)!)

            let nameRange = string.nsRange(from: string.range(of: model.agent_name!)!)

            text.yy_setFont(FONT(s: 14), range: nameRange)
            text.yy_setFont(FONT(s: 14), range: commentRange)
            text.yy_lineSpacing = 2 * SizeAdapter
            text.yy_kern = 1 * SizeAdapter as NSNumber
            if model.show == true {
                text.yy_setFont(FONT(s: 14), range: closeRange)
            }
            return text
        }

        func getEachCommentHeight(commentModel:WYAAgentRingListModel.WYAAgentRingListItemModel.CommentItem) {
            let text = commentsAttributedString(model: commentModel)
            let width = ScreenWidth - 94 * SizeAdapter
            let label = YYLabel()
            label.preferredMaxLayoutWidth = width
            label.numberOfLines = 0
            label.attributedText = text
            label.textVerticalAlignment = .top
            if commentModel.show == true {
                let size = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
                let layout = YYTextLayout.init(containerSize: size, text: text)
                label.textLayout = layout
                let height = layout?.textBoundingSize.height
                heightArray.append(height!)
            } else {
                let height = UILabel.getHeightByWidth(width, title: text.string, font: FONT(s: 14))
                if height > 19 * SizeAdapter {
                    heightArray.append(38 * SizeAdapter)
                } else {
                    heightArray.append(17 * SizeAdapter)
                }
            }
        }

        guard model.comment!.count > 0 else {
            return 1.0/UIScreen.main.scale
        }
        let number = model.comment!.count > 2 ? 2 : model.comment!.count
        for i in 0..<number {
            let item = model.comment![i]
            getEachCommentHeight(commentModel: item)
        }
        var height = CGFloat(0.0)
        var hei = CGFloat(0.0)
        if model.comment!.count > 2 {
            hei = 25 * SizeAdapter
        }
        model.commentHeight = commentH(model: model, array: heightArray)
        model.commentHeightArray = heightArray
        height = model.commentHeight! + hei + 20 * SizeAdapter
        return height
    }
    
}

struct WYACoverImageModel : Codable {
    struct Data : Codable {
        var cover_image : String = ""
    }
    var data : Data?

}
