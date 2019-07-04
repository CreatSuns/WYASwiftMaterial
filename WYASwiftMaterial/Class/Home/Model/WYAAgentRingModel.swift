//
//  WYAAgentRingModel.swift
//  WYASwiftMaterial
//
//  Created by 李世航 on 2019/6/20.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

import UIKit



struct WYAAgentRingListModel : Codable {
    struct WYAAgentRingListItemModel : Codable {
        struct CommentItem : Codable {
            var comment_id : Int?
            var agent_name : String?
            var content : String?

        }
        var circle_status : Int?
        var circle_id : Int?
        var agent_id : Int?
        var agentName : String?
        var content : String?
        var point_num : Int?
        var is_collect : Bool?
        var is_point : Bool?
        var image : [String]?
        var comment : [CommentItem]?
        var create_time : String?
        var circle_pass_id : Int?
        var refuse_reason : String?
        var contentHeight: CGFloat {
            let height = UILabel.getHeightByWidth(ScreenWidth - 74 * SizeAdapter, title: content, font: FONT(s: 16))
            return height
        }
        // 自定义字段，覆盖返回参数的键
        enum CodingKeys : String, CodingKey {
            case agentName = "agent_name"
        }
    }

    var list : [WYAAgentRingListItemModel]?
}

class WYAAgentRingModel: BaseNetWork {

    public class func fetchAgentRingCoverImage() {
        WYAAgentRingModel.requestData(.get, URLString: agentRingCoverImageUrl) { (result) in
            print(result)
        }

    }
}
