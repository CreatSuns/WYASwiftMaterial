//
//  WYANetRequestUrl.swift
//  WYASwiftEnv
//
//  Created by 李俊恒 on 2018/8/14.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

import Foundation

let baseUrl = PrintTool.getBaseUrl()

/***登录***/
let loginUrl = baseUrl + "api/material-app/material-login.json"

let logOut = baseUrl + "api/material-app/logout.json"

let chooseProductLine = baseUrl + "material/account/set-admin-info.json"

let bdingPushToken = baseUrl + "api/material-app/update-device.json"

/***首页***/

let senderAgentCirclePermissions = baseUrl + "material/agent-circle/check-limit.json"

let agentRingCoverImageUrl = baseUrl + "material/agent-circle/cover-image.json"

let appHomeNotice =  baseUrl + "material/notice/notice-show.json"

let agentRingList = baseUrl + "material/agent-circle/get-list.json"

let sendAgentRingDynamic = "material/agent-circle/save.json"

let forwardAgentRing = baseUrl + "material/agent-circle/forward.json"

let praiseAgentRing = baseUrl + "material/agent-circle/point.json"

let commentAgentRing = baseUrl + "material/agent-circle/comment.json"

let collectionAgentRing = baseUrl + "material/agent-circle/collect.json"

let moreCommentsAgentRing = baseUrl + "material/agent-circle/comment-list.json"

let ossGetSign = baseUrl + "api/oss/get-sign.json"

/***素材***/

let senderMarerialPermissions = baseUrl + "material/image-text/check-limit.json"

let materialList = baseUrl + "material/image-text/image-text-list.json"

let materialLabelList = baseUrl + "material/image-text/label-list.json"

let materialCollectionItem = baseUrl + "material/image-text/collect-image-text.json"

let materialForwardItem = baseUrl + "material/image-text/forward-image-text.json"

let materialCreateItem = baseUrl + "material/image-text/add-image-text.json"

let articleList = baseUrl + "material/link/get-list.json"

let articleForwardItem = baseUrl + "material/link/forward.json"

//let articleInterviewDetail = baseUrl + "material/link/interview.json" 弃用

/***我的***/

let mineNoticeList = baseUrl + "material/account/get-history-message-list.json"

let mineNoticeRead = baseUrl + "material/notice/notice-read.json"

let mineCollectionMaterialList = baseUrl + "material/account/get-material-collect-list.json"

let mineCreateMaterialList = baseUrl + "material/account/get-my-material-list.json"

let mineDeleteMaterialItem = baseUrl + "material/image-text/del.json"

let mineCollectionDynamicList = baseUrl + "material/account/get-circle-collect-list.json"

let mineCreateDynamicList = baseUrl + "material/account/get-my-circle-list.json"

let deleteAgentRing = baseUrl + "material/agent-circle/del.json"

let mineGetUserInfo = baseUrl + "material/account/get-user-info.json"

