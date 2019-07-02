//
//  WYAAgentRingCell.swift
//  WYASwiftMaterial
//
//  Created by 李世航 on 2019/6/19.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

import UIKit

class WYAAgentRingCell: WYABaseAgentRingCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(actionBar)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        actionBar.snp_remakeConstraints { (make) in
            make.left.right.equalTo(userReleaseContentLabel)
            make.top.equalTo(userReleaseImagesView.snp_bottom).offset(10.5 * SizeAdapter)
            make.height.equalTo(20 * SizeAdapter)
        }
    }
}


