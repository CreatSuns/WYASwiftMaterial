//
//  WYABaseAgentRingCell.swift
//  WYASwiftMaterial
//
//  Created by 李世航 on 2019/6/20.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

import UIKit

class WYABaseAgentRingCell: UITableViewCell {
    var viewModel : (Any)? = nil
    var indexPath : IndexPath? = nil

    lazy var userHeaderImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "pic_pingluntouxiang"))
        return imageView
    }()

    lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "占位文字"
        label.font = FONT(s: 16)
        label.textColor = wya_textLightBlackColor
        return label
    }()

    lazy var userLevelImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "icon_huizhang"))
        return imageView
    }()

    lazy var userLevelLabel: UILabel = {
        let label = UILabel()
        label.text = "占位文字"
        label.font = FONT(s: 11)
        label.textColor = wya_goldenLevelTextColor
        return label
    }()

    lazy var userReleaseContentLabel: UILabel = {
        let label = UILabel()
        label.text = "占位文字占位文字占位文字占位文字占位文字占位文字占位文字占位文字占位文字占位文字占位文字占位文字占位文字占位文字"
        //        label.font = FONT(s: 11)
        //        label.textColor = wya_goldenLevelTextColor
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byCharWrapping
        return label
    }()

    lazy var showButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("全文", for: .normal)
        button.setTitleColor(wya_blueColor, for: .normal)
        button.titleLabel?.font = FONT(s: 15)
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        button.addTarget(self, action: #selector(showClick), for: .touchUpInside)
        return button
    }()

    lazy var forwardingButton: UIButton = {
        let space = 6.0
        let button = UIButton(type: .custom)
        button.setTitle("转发", for: .normal)
        button.setTitleColor(wya_textBlackColor, for: .normal)
        button.setImage(UIImage(named: "icon_zhuanfa"), for: .normal)
        button.titleLabel?.font = FONT(s: 13)
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.right
        button.imageEdgeInsets = UIEdgeInsetsMake(0, CGFloat(-space / 2.0), 0, CGFloat(space / 2.0));
        button.titleEdgeInsets = UIEdgeInsetsMake(0, CGFloat(space / 2.0), 0, CGFloat(-space / 2.0));
        return button
    }()

    public lazy var userReleaseImagesView: WYAImageContainerView = {
        let view = WYAImageContainerView()
        return view
    }()

    public lazy var actionBar: WYAActionBar = {
        let view = WYAActionBar()
        return view
    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        contentView.addView(views: [userHeaderImageView,userNameLabel,userLevelImageView,userLevelLabel,userReleaseContentLabel,showButton,forwardingButton,userReleaseImagesView])
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
        userHeaderImageView.snp_remakeConstraints { (make) in
            make.left.equalTo(contentView).offset(12 * SizeAdapter)
            make.top.equalTo(contentView).offset(18.5 * SizeAdapter)
            make.size.equalTo(CGSize(width: 40 * SizeAdapter, height: 40 * SizeAdapter))
        }

        userNameLabel.snp_remakeConstraints { (make) in
            make.top.equalTo(userHeaderImageView).offset(1.5 * SizeAdapter)
            make.left.equalTo(userHeaderImageView.snp_right).offset(10 * SizeAdapter)
            make.width.equalTo(200 * SizeAdapter)
            make.height.equalTo(15 * SizeAdapter)
        }

        userLevelImageView.snp_remakeConstraints { (make) in
            make.left.equalTo(userNameLabel)
            make.top.equalTo(userNameLabel.snp_bottom).offset(7 * SizeAdapter)
            make.size.equalTo(CGSize(width: 15 * SizeAdapter, height: 15 * SizeAdapter))
        }

        userLevelLabel.snp_remakeConstraints { (make) in
            make.left.equalTo(userLevelImageView.snp_right).offset(6.5 * SizeAdapter)
            make.right.equalTo(contentView.snp_right).offset(-12 * SizeAdapter)
            make.centerY.equalTo(userLevelImageView.snp_centerY)
            make.height.equalTo(11 * SizeAdapter)
        }

        forwardingButton.snp_remakeConstraints { (make) in
            make.right.equalTo(contentView).offset(-15 * SizeAdapter)
            make.centerY.equalTo(userNameLabel.snp_centerY)
            make.size.equalTo(CGSize(width: 50 * SizeAdapter, height: 15 * SizeAdapter))
        }

        userReleaseContentLabel.snp_remakeConstraints { (make) in
            make.left.equalTo(userNameLabel)
            make.right.equalTo(contentView.snp_right).offset(-12 * SizeAdapter)
            make.top.equalTo(userLevelImageView.snp_bottom).offset(10.5 * SizeAdapter)
            make.height.equalTo(38 * SizeAdapter)
        }

        showButton.snp_remakeConstraints { (make) in
            make.left.equalTo(userReleaseContentLabel)
            make.top.equalTo(userReleaseContentLabel.snp_bottom)
            make.size.equalTo(CGSize(width: 50 * SizeAdapter, height: 15 * SizeAdapter))
        }

        userReleaseImagesView.snp_remakeConstraints { (make) in
            make.left.equalTo(userReleaseContentLabel)
            make.right.equalTo(contentView.snp_right).offset(-58 * SizeAdapter)
            make.top.equalTo(showButton.snp_bottom)
            make.height.equalTo(0)
        }
    }

    public func bindViewModel(viewModel:Any) {
        self.viewModel = viewModel
    }

    public func configCellWithIndexPath(indexPath:IndexPath) {
        self.indexPath = indexPath
    }

    @objc func showClick() {
        
    }
}

extension WYABaseAgentRingCell {

}

class WYAImageContainerView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func images(_ images:[String]) {
        for view in self.subviews {
            view.removeFromSuperview()
        }
        for string in images {
            let button = UIButton(type: .custom)
            button.sd_setBackgroundImage(with: URL(string: string.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""), for: .normal) { (image, error, type, url) in
                print(error as Any)
                print(image as Any)
            }
            button.contentMode = .scaleAspectFill
            button.imageView?.contentMode = .scaleAspectFill
            button.contentHorizontalAlignment = .fill
            button.contentVerticalAlignment = .fill
            self.addSubview(button)
        }
        if self.subviews.count < 2 {
            let view = self.subviews.first
            view?.layer.cornerRadius = 3 * SizeAdapter
            view?.layer.masksToBounds = true
            view?.frame = CGRect(x: 0, y: 0, width: ScreenWidth - 190.5 * SizeAdapter, height: ScreenWidth - 190.5 * SizeAdapter)
        } else {
            for index in 0..<self.subviews.count {
                let view = self.subviews[index]

                view.layer.cornerRadius  = 2 * SizeAdapter
                view.layer.masksToBounds = true
                let row              = index / 3
                let column           = index % 3

                let view_width  = (ScreenWidth - 120 * SizeAdapter - 2 * 5 * SizeAdapter) / 3;
                let view_height = view_width;
                let view_x      = (view_width + 5 * SizeAdapter) * CGFloat(column);
                let view_y      = (view_width + 5 * SizeAdapter) * CGFloat(row);


                view.frame       = CGRect(x: view_x, y: view_y, width: view_width, height: view_height);
            }
        }
    }
}

class WYAActionBar: UIView {

    lazy var userReleaseTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "2019-06-20 11:38"
        label.textColor = wya_textGrayColor
        label.textAlignment = .left
        label.font = FONT(s: 12)
        return label
    }()

    lazy var commentsButton: UIButton = {
        let space = 6 * SizeAdapter
        let button = UIButton(type: .custom)
        button.setTitle("评论", for: .normal)
        button.setTitleColor(wya_textBlackColor, for: .normal)
        button.titleLabel?.font = FONT(s: 13)
        button.setImage(UIImage(named: "icon_pinglun"), for: .normal)
        button.setImage(UIImage(named: "icon_pinglunblack"), for: .highlighted)
        button.imageEdgeInsets = UIEdgeInsetsMake(0, -space / 2.0, 0, space / 2.0)
        button.titleEdgeInsets = UIEdgeInsetsMake(0, space / 2.0, 0, -space / 2.0);
        return button
    }()

    lazy var collectionButton: UIButton = {
        var space = CGFloat(6)
        let button = UIButton(type: .custom)
        button.setTitle("收藏", for: .normal)
        button.setTitleColor(wya_textBlackColor, for: .normal)
        button.titleLabel?.font = FONT(s: 13)
        button.setImage(UIImage(named: "icon_collect"), for: .normal)
        button.setImage(UIImage(named: "icon_collect_press"), for: .selected)
        button.imageEdgeInsets = UIEdgeInsetsMake(0, -space / 2.0, 0, space / 2.0)
        button.titleEdgeInsets = UIEdgeInsetsMake(0, space / 2.0, 0, -space / 2.0)
        button.addCallBackAction({ (button) in
            button!.isSelected = !button!.isSelected
            var anim = CAKeyframeAnimation(keyPath: "transform.scale")
            anim.values                = [ 1.0, 0.8, 1.0, 1.2, 1.0 ];
            anim.duration              = 0.5;
            button!.imageView!.layer.add(anim, forKey: nil)
        })
        return button
    }()

    lazy var praiseButton: UIButton = {
        var space = CGFloat(6)
        let button = UIButton(type: .custom)
        button.setTitleColor(wya_textBlackColor, for: .normal)
        button.setImage(UIImage(named: "icon_dianzan"), for: .normal)
        button.setImage(UIImage(named: "icon_dianzan_press"), for: .selected)
        button.imageEdgeInsets = UIEdgeInsetsMake(0, -space / 2.0, 0, space / 2.0)
        button.titleEdgeInsets = UIEdgeInsetsMake(0, space / 2.0, 0, -space / 2.0)
        button.addCallBackAction({ (button) in
            button!.isSelected = !button!.isSelected
            var anim = CAKeyframeAnimation(keyPath: "transform.scale")
            anim.values                = [ 1.0, 0.8, 1.0, 1.2, 1.0 ];
            anim.duration              = 0.5;
            button!.imageView!.layer.add(anim, forKey: nil)
        })
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addView(views: [userReleaseTimeLabel,commentsButton,collectionButton,praiseButton])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        userReleaseTimeLabel.snp_remakeConstraints { (make) in
            make.left.centerY.equalTo(self)
            make.size.equalTo(CGSize(width: 75 * SizeAdapter, height: 20 * SizeAdapter))
        }

        commentsButton.snp_remakeConstraints { (make) in
            make.left.equalTo(userReleaseTimeLabel.snp_right).offset(17 * SizeAdapter)
            make.centerY.equalTo(self)
            make.size.equalTo(CGSize(width: 50 * SizeAdapter, height: 20 * SizeAdapter))
        }

        collectionButton.snp_remakeConstraints { (make) in
            make.left.equalTo(commentsButton.snp_right).offset(25 * SizeAdapter)
            make.centerY.equalTo(self)
            make.size.equalTo(CGSize(width: 46 * SizeAdapter, height: 20 * SizeAdapter))
        }

        praiseButton.snp_remakeConstraints { (make) in
            make.left.equalTo(collectionButton.snp_right).offset(33 * SizeAdapter)
            make.centerY.equalTo(self)
            make.size.equalTo(CGSize(width: 50 * SizeAdapter, height: 20 * SizeAdapter))
        }
    }
    
}
