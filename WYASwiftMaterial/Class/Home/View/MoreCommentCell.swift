//
//  MoreCommentCell.swift
//  WYASwiftMaterial
//
//  Created by 李世航 on 2019/7/25.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

import UIKit

class MoreCommentCell: UITableViewCell {
    var viewModel : WYAMoreCommentViewModel?

    lazy var userHeaderButton : UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 4 * SizeAdapter
        button.layer.masksToBounds = true
        button.contentMode = .scaleAspectFill
        button.imageView?.contentMode = .scaleAspectFill
        return button
    }()

    lazy var userNameLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.wya_hex("#666666")
        label.font = FONT(s: 12)
        return label
    }()

    lazy var timeLabel : UILabel = {
        let label = UILabel()
        label.textColor = wya_textGrayColor
        label.font = FONT(s: 11)
        label.textAlignment = .right
        return label
    }()

    lazy var commentsLabel : UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = FONT(s: 14)
        label.numberOfLines = 0
        return label
    }()

    lazy var line : UIView = {
        let view = UIView()
        view.backgroundColor = wya_lineColor
        return view
    }()

    lazy var bgView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.wya_hex("#F2F2F5")
        return view
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        contentView.addSubview(bgView)
        bgView.addView(views: [userHeaderButton, userNameLabel, timeLabel, commentsLabel, line])
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
        bgView.snp_remakeConstraints { (make) in
            make.left.equalTo(contentView.snp_left).offset(15 * SizeAdapter)
            make.right.equalTo(contentView.snp_right).offset(-15 * SizeAdapter)
            make.top.bottom.equalTo(contentView)
        }

        userHeaderButton.snp_remakeConstraints { (make) in
            make.left.equalTo(bgView.snp_left).offset(15 * SizeAdapter)
            make.top.equalTo(bgView.snp_top).offset(10 * SizeAdapter)
            make.size.equalTo(CGSize(width: 30 * SizeAdapter, height: 30 * SizeAdapter))
        }

        userNameLabel.snp_remakeConstraints { (make) in
            make.left.equalTo(userHeaderButton.snp_right).offset(11 * SizeAdapter)
            make.top.equalTo(bgView.snp_top).offset(10 * SizeAdapter)
            make.size.equalTo(CGSize(width: 100 * SizeAdapter, height: 12 * SizeAdapter))
        }

        timeLabel.snp_remakeConstraints { (make) in
            make.right.equalTo(bgView.snp_right).offset(-13 * SizeAdapter)
            make.bottom.equalTo(userNameLabel.snp_bottom)
            make.left.equalTo(userNameLabel.snp_right).offset(10 * SizeAdapter)
            make.height.equalTo(15 * SizeAdapter)
        }

        commentsLabel.snp_remakeConstraints { (make) in
            make.left.equalTo(userNameLabel.snp_left)
            make.right.equalTo(bgView.snp_right).offset(-19 * SizeAdapter)
            make.top.equalTo(userNameLabel.snp_bottom).offset(3.5 * SizeAdapter)
            let height = UILabel.getHeightByWidth(ScreenWidth - 105 * SizeAdapter, title: commentsLabel.text, font: commentsLabel.font)
            make.height.equalTo(height)
        }

        line.snp_remakeConstraints { (make) in
            make.left.equalTo(bgView.snp_left).offset(15 * SizeAdapter)
            make.right.equalTo(bgView.snp_right).offset(-13 * SizeAdapter)
            make.bottom.equalTo(bgView.snp_bottom)
            make.height.equalTo(0.5 * SizeAdapter)
        }
    }
}

extension MoreCommentCell {
    public func bindViewModel(viewModel : WYAMoreCommentViewModel) {
        self.viewModel = viewModel
    }

    public func configCellModel(indexPath:IndexPath) {
        let model = self.viewModel?.list![indexPath.row]
        self.userNameLabel.text = model?.agent_name
        userHeaderButton.sd_setImage(with: URL(string: model!.agent_avatar!), for: .normal, placeholderImage: UIImage(named: "pic_pingluntouxiang"), options: .retryFailed, context: nil)
        timeLabel.text = model?.create_time
        commentsLabel.text = String.stringReplace(patten: "(\r?\n(\\s*\r?\n)+)", str: model!.content!, replaceString: "\n\n")
    }
}
