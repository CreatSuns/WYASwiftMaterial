//
//  UIView.swift
//  WYASwiftMaterial
//
//  Created by 李世航 on 2019/6/19.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

import Foundation

extension UIView {
    func addView(views:[UIView]) -> Void {
        for view in views {
            self.addSubview(view)
        }
    }
}
