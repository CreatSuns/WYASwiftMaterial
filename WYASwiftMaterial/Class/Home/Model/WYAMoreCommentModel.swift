//
//  WYAMoreCommentModel.swift
//  WYASwiftMaterial
//
//  Created by 李世航 on 2019/7/25.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

import Foundation

class WYAMoreCommentsListItem: Codable {
    var comment_id : WYABaseType?
    var content : String?
    var create_time : String?
    var agent_name : String?
    var agent_level_name : String?
    var agent_avatar : String?
}

class WYAMoreCommentResponse: Codable {
    var list : [WYAMoreCommentsListItem]?
}

class WYAMoreCommentModel: Codable {
    var data : WYAMoreCommentResponse?

}
