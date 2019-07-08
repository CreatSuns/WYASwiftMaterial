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

            var contentShow : Bool? {
                return false
            }
            var contentHeight: Float {
                let height = UILabel.getHeightByWidth(ScreenWidth - 74 * SizeAdapter, title: content, font: FONT(s: 16))
                if height > 38 * SizeAdapter {

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

//            // 自定义字段，覆盖返回参数的键需要在实现里声明所有的key
//            enum CodingKeys : String, CodingKey {
//                case agentName = "agent_name"
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
        if model.contentShow! {
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
}

struct WYACoverImageModel : Codable {
    struct Data : Codable {
        var cover_image : String = ""
    }
    var data : Data?

}
