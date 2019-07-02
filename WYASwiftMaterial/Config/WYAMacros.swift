//
//  Macros.swift
//  WYASwiftEnv
//
//  Created by 李俊恒 on 2018/8/14.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

import Foundation

/// 获取整个应用程序的Home目录
let homeDirectory = NSHomeDirectory()

/// 用户文档目录，苹果建议将程序中建立的或在程序中浏览到的文件数据保存在该目录下，iTunes备份和恢复的时候会包括此目录
let documentPath = NSHomeDirectory() + "/Documents"

/// 这个目录下有两个子目录：Caches 和 Preferences
///Library/Preferences目录，包含应用程序的偏好设置文件。不应该直接创建偏好设置文件，而是应该使用NSUserDefaults类来取得和设置应用程序的偏好。
let libraryPath = NSHomeDirectory() + "/Library"

/// Library/Caches目录，主要存放缓存文件，iTunes不会备份此目录，此目录下文件不会再应用退出时删除
let cachePath = NSHomeDirectory() + "/Library/Caches"

/// 用于存放临时文件，保存应用程序再次启动过程中不需要的信息，重启后清空。
let tempDir = NSHomeDirectory() + "/tmp"



