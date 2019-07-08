//
//  WYAAgentRingCoverView.swift
//  WYASwiftMaterial
//
//  Created by 李世航 on 2019/6/19.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

import UIKit

class WYAAgentRingCoverView: UIView {

    public lazy var agentRingCoverImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0.0, y: self.cmam_height - 30.0 * SizeAdapter - 325 * SizeAdapter, width: self.cmam_width, height: 325 * SizeAdapter))
        imageView.image = UIImage(named: "pic_shouyebackground")
        return imageView
    }()

    lazy var userHeaderImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: self.cmam_right - 68 * SizeAdapter - 15 * SizeAdapter, y: self.cmam_height - 68 * SizeAdapter - 7 * SizeAdapter, width: 68 * SizeAdapter, height: 68 * SizeAdapter))
        imageView.image = UIImage(named: "pic_dongtaitouxiang")
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame:frame)
        self.addView(views: [agentRingCoverImageView,
                             userHeaderImageView])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
