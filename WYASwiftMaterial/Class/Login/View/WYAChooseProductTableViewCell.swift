//
//  WYAChooseProductTableViewCell.swift
//  WYASwiftMaterial
//
//  Created by 李俊恒 on 2019/7/24.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

import UIKit

class WYAChooseProductTableViewCell: UITableViewCell {
    let leftMargin = 20*SizeAdapter
    var model:WYALoginDataModel.WYALoginUserInfoModel.WYAAgentItem?

    lazy var leftIconImageView:UIImageView = {
        let leftIconImageView = UIImageView.init()
        leftIconImageView.layer.cornerRadius = 4 * SizeAdapter
        leftIconImageView.layer.masksToBounds = true
        return leftIconImageView
    }()

    lazy var leftTitleLabel:UILabel = {
        let leftTitleLabel = UILabel.init()
        leftTitleLabel.textColor = wya_blackColor
        leftTitleLabel.font = FONT(s: 16)
        return leftTitleLabel
    }()

    lazy var leftContentLabel: UILabel = {
        let leftContentLabel = UILabel.init()
        leftContentLabel.textColor = wya_textGrayColor
        leftContentLabel.font = FONT(s: 12)

        return leftContentLabel
    }()

    lazy var lineView: UIView = {
        let lineView = UIView.init()
        lineView.backgroundColor = wya_lineColor
        return lineView
    }()

    lazy var rightImgView: UIImageView = {
        let rightImgView = UIImageView.init()
        rightImgView.image = UIImage.init(named: "icon_selected")
        rightImgView.layer.cornerRadius = 11 * SizeAdapter
        rightImgView.layer.masksToBounds = true
        return rightImgView
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addView(views: [self.leftIconImageView,
                             self.leftTitleLabel,
                             self.leftContentLabel,
                             self.rightImgView,
                             self.lineView])
        self.selectionStyle = UITableViewCellSelectionStyle.none
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
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
        self.leftIconImageView.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(self.leftMargin)
            make.centerY.equalTo(self.contentView.snp.centerY)
            make.size.equalTo(CGSize(width: 40 * SizeAdapter, height: 40 * SizeAdapter))
        }

        self.leftTitleLabel.snp.makeConstraints {
            (make) in
            make.top.equalTo(self.leftIconImageView.snp.top)
            make.left.equalTo(self.leftIconImageView.snp.right).offset(8 * SizeAdapter)
            make.size.equalTo(CGSize(width: ScreenWidth - (160 * SizeAdapter), height: self.leftMargin))
        }

        self.leftContentLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.leftIconImageView.snp.bottom)
            make.left.equalTo(self.leftIconImageView.snp.right).offset(8 * SizeAdapter)
            make.size.equalTo(CGSize(width: ScreenWidth - (160 * SizeAdapter), height: self.leftMargin))
        }

        self.rightImgView.snp.makeConstraints { (make) in
            make.right.equalTo(self.contentView.snp.right).offset(-30 * SizeAdapter)
            make.centerY.equalTo(self.contentView.snp.centerY)
            make.size.equalTo(CGSize(width: 22 * SizeAdapter, height: 22 * SizeAdapter))
        }

        self.lineView.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView.snp.left).offset(self.leftMargin)
            make.right.bottom.equalToSuperview()
            make.height.equalTo(0.5)
        }
    }
}

extension WYAChooseProductTableViewCell{
    func setModel(model: WYALoginDataModel.WYALoginUserInfoModel.WYAAgentItem?) {
        if model != nil {
            self.model = model
            self.leftIconImageView.setImageWith(URL.init(string: self.model!.agent_avatar!)!, placeholderImage: UIImage.init(named: "pic_dongtaitouxiang"))
            self.leftTitleLabel.text = self.model?.product_line_name
            self.leftContentLabel.text = self.model?.company_name
            self.layoutIfNeeded()
        }

    }

}
