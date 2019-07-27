//
//  cameraCell.swift
//  WYASwiftMaterial
//
//  Created by 李世航 on 2019/7/26.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

import UIKit

class cameraCell: UICollectionViewCell {

    lazy var imageView : UIImageView = {
        let view = UIImageView(image: UIImage(named: "icon_add"))
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addView(views: [imageView])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView.frame = self.contentView.frame
    }
}
