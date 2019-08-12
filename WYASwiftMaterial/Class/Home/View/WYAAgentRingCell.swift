//
//  WYAAgentRingCell.swift
//  WYASwiftMaterial
//
//  Created by 李世航 on 2019/6/19.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

import UIKit

class WYAAgentRingCell: WYABaseAgentRingCell {
    var height : Float = 0.1
    var imageHeight : Float = 0.0

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
        userReleaseContentLabel.snp_updateConstraints { (make) in
            make.height.equalTo(height)
        }

        showButton.snp_updateConstraints { (make) in
            make.top.equalTo(userReleaseContentLabel.snp_bottom).offset(showButton.isHidden ? 0 : 6.5 * SizeAdapter)
            make.height.equalTo(showButton.isHidden ? 0 : 15 * SizeAdapter)
        }

        userReleaseImagesView.snp_updateConstraints { (make) in
            make.top.equalTo(showButton.snp_bottom).offset(imageHeight > 0 ? 10.5 * SizeAdapter : 0)
            make.height.equalTo(imageHeight)
        }

        actionBar.snp_remakeConstraints { (make) in
            make.left.right.equalTo(userReleaseContentLabel)
            make.top.equalTo(userReleaseImagesView.snp_bottom).offset(10.5 * SizeAdapter)
            make.height.equalTo(20 * SizeAdapter)
        }
    }
    
    override func configCellWithIndexPath(indexPath: IndexPath) {
        super.configCellWithIndexPath(indexPath: indexPath)
        let model = (self.viewModel as! WYAAgentRingViewModel).list[indexPath.section]
        wyaPrint(model)
        setModel(model: model)
    }

    public func setModel(model:WYAAgentRingModel.WYAAgentRingListModel.WYAAgentRingListItemModel) {
        self.userNameLabel.text = model.agent_name
        self.userLevelLabel.text = model.agent_level_name
        self.userReleaseContentLabel.text = model.content
        height = model.contentHeight
        userReleaseImagesView.images(model.image!)
        imageHeight = model.imageSuperHeight
        if model.contentHeight > Float(38 * SizeAdapter) {
            self.showButton.isHidden = false
        } else {
            self.showButton.isHidden = true
        }
        actionBar.praiseButton.setTitle(String(model.point_num!), for: .normal)
        self.layoutIfNeeded()
    }
}

extension WYAAgentRingCell {

}

