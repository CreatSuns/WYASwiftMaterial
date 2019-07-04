//
//  WYAAgentRingFooterView.swift
//  WYASwiftMaterial
//
//  Created by 李世航 on 2019/7/3.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

import UIKit

class WYAAgentRingFooterView: UITableViewHeaderFooterView {

    let bgView: UIView = {
        let view = UIView(frame: CGRect(x: 62 * SizeAdapter, y: 0, width: ScreenWidth - 74 * SizeAdapter, height: 80))
        view.backgroundColor = wya_bgColor
        view.layer.cornerRadius = 5 * SizeAdapter
        view.layer.masksToBounds = true
        return view
    }()

    let showCommentsButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 55, width: ScreenWidth - 74 * SizeAdapter, height: 25)
        button.setTitle("更多评论", for: .normal)
        button.setTitleColor(wya_blueColor, for: .normal)
        button.wya_setBackgroundColor(wya_bgColor, for: .normal)
        button.titleLabel?.font = FONT(s: 13)
        button.isHidden = false
        button.contentVerticalAlignment = .top
        button.addCallBackAction({ (button) in

        })
        return button
    }()

    let commentsView: WYACommentsView = {
        let view = WYACommentsView(frame: CGRect(x: 0, y: 0, width: ScreenWidth - 74 * SizeAdapter, height: 55))
        return view
    }()
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        bgView.addView(views: [commentsView,showCommentsButton])
        self.addView(views: [bgView])
        commentsView.model = ["sd","dsd"]
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

class WYACommentsView: UIView {
    var model : Any? {
        didSet {
            wyaPrint(model as Any)
            for item in 0..<2 {
                let label = YYLabel()
                label.preferredMaxLayoutWidth = ScreenWidth - 94 * SizeAdapter
                label.numberOfLines = 2;
                label.text = "陌生人：宏颜获水，彦面尽湿"
                label.textAlignment = .center
                label.frame = CGRect(x: 0, y: 25 * item, width: Int(ScreenWidth - 94 * SizeAdapter), height: 20)
                self.addSubview(label)
            }

        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
