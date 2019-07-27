//
//  WYAAgentRingFooterView.swift
//  WYASwiftMaterial
//
//  Created by 李世航 on 2019/7/3.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

import UIKit

class WYAAgentRingFooterView: UITableViewHeaderFooterView {
    var viewModel : (Any)? = nil
    var index : Int = 0

    typealias callback = (_ model:WYAAgentRingModel.WYAAgentRingListModel.WYAAgentRingListItemModel) -> Void
    public var moreCommentCallback : callback!

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
        button.isHidden = true
        button.contentVerticalAlignment = .top
        button.addTarget(self, action: #selector(moreCommentClick), for: .touchUpInside)
        return button
    }()

    let commentsView: WYACommentsView = {
        let view = WYACommentsView(frame: CGRect(x: 0, y: 0, width: ScreenWidth - 74 * SizeAdapter, height: 55))
        view.isHidden = true
        return view
    }()

    let line : UIView = {
        let view = UIView()
        view.backgroundColor = wya_lineColor
        return view
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        bgView.addView(views: [commentsView,showCommentsButton])
        self.addView(views: [bgView])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let model = (self.viewModel as! WYAAgentRingViewModel).list[index]

        commentsView.frame = CGRect(x: 0, y: 0, width: ScreenWidth - 74 * SizeAdapter, height: model.commentHeight ?? 0)
        showCommentsButton.frame = CGRect(x: commentsView.cmam_left, y: commentsView.cmam_bottom, width: commentsView.cmam_width, height: showCommentsButton.isHidden ? 0 : 25 * SizeAdapter)
        bgView.frame = CGRect(x: 62 * SizeAdapter, y: 0, width: ScreenWidth - 74 * SizeAdapter, height: commentsView.cmam_height + showCommentsButton.cmam_height)
        line.frame = CGRect(x: 0, y: contentView.cmam_height - 1.0/UIScreen.main.scale, width: ScreenWidth, height: 1.0/UIScreen.main.scale)
    }

    @objc func moreCommentClick(){
        self.moreCommentCallback((self.viewModel as! WYAAgentRingViewModel).list[self.index])
    }
}

extension WYAAgentRingFooterView {
    public func bindViewModel(viewModel:Any) {
        self.viewModel = viewModel
    }

    public func configFootWithIndexPath(section:Int) {
        index = section
        let list = (self.viewModel as! WYAAgentRingViewModel).list[section].comment
        commentsView.viewModel = self.viewModel
        commentsView.index = self.index
        commentsView.list = list
        commentsView.isHidden = true
        showCommentsButton.isHidden = true
        if list!.count > 0 {
            commentsView.isHidden = false
        }

        if list!.count > 2 {
            showCommentsButton.isHidden = false
        }
    }
}

class WYACommentsView: UIView {
    var viewModel : (Any)? = nil
    var index : Int = 0
    var list : [WYAAgentRingModel.WYAAgentRingListModel.WYAAgentRingListItemModel.CommentItem]? {
        didSet {
            wyaPrint(list as Any)
            setList(listModels: list!)
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setList(listModels:[WYAAgentRingModel.WYAAgentRingListModel.WYAAgentRingListItemModel.CommentItem]) {
        func commentsAttributedString(commentModel:WYAAgentRingModel.WYAAgentRingListModel.WYAAgentRingListItemModel.CommentItem) -> NSMutableAttributedString {
            let closeString = "收起"
            let content = String.stringReplace(patten: "(\r?\n(\\s*\r?\n)+)", str: commentModel.content ?? "", replaceString:"\n\n")
            var string : String
            var closeRange : NSRange = NSMakeRange(0, 0)

            if commentModel.show == true {
                string = commentModel.agent_name! + content + closeString
                closeRange = string.nsRange(from: string.range(of: closeString)!)
            } else {
                string = commentModel.agent_name! + content
            }
            let text = NSMutableAttributedString(string: string)
            let commentRange = string.nsRange(from: string.range(of: commentModel.content!)!)

            let nameRange = string.nsRange(from: string.range(of: commentModel.agent_name!)!)

            text.yy_setFont(FONT(s: 14), range: nameRange)
            text.yy_setColor(UIColor(hexString: "#666666"), range: nameRange)
            text.yy_setFont(FONT(s: 14), range: commentRange)
            text.yy_setColor(UIColor(hexString: "#000000"), range: commentRange)
            text.yy_lineSpacing = 2 * SizeAdapter
            text.yy_kern = 1 * SizeAdapter as NSNumber
            if commentModel.show == true {
                text.yy_setFont(FONT(s: 14), range: closeRange)
                text.yy_setColor(wya_blueColor, range: closeRange)
                let textHighlight = YYTextHighlight()
                textHighlight.setColor(.red)
                textHighlight.tapAction = { view, text, range, rect in
                    commentModel.show = false
                }
                text.yy_setTextHighlight(textHighlight, range: closeRange)
            }
            return text
        }

        func addSeeMoreButton(label:YYLabel, commentModel:WYAAgentRingModel.WYAAgentRingListModel.WYAAgentRingListItemModel.CommentItem) {
            let text = NSMutableAttributedString(string: "...展开")
            let textHighlight = YYTextHighlight()
            textHighlight.setColor(.blue)
            textHighlight.tapAction = { view, text, range, rect in
                commentModel.show = true
            }
            var range = text.string.nsRange(from: text.string.range(of: "展开")!)
            text.yy_setColor(wya_blueColor, range: range)
            text.yy_setTextHighlight(textHighlight, range: range)
            text.yy_font = FONT(s: 14)
            text.yy_baselineOffset = -2
            let seeMore = YYLabel()
            seeMore.attributedText = text
            seeMore.sizeToFit()
            let truncationToken = NSMutableAttributedString.yy_attachmentString(withContent: seeMore, contentMode: .bottom, attachmentSize: seeMore.cmam_size, alignTo: text.yy_font!, alignment: .bottom)
            label.truncationToken = truncationToken
        }

        func configYYLabelWithModel(commentModel:WYAAgentRingModel.WYAAgentRingListModel.WYAAgentRingListItemModel.CommentItem) -> YYLabel {


            let text = commentsAttributedString(commentModel: commentModel)
            let width = ScreenWidth - 94 * SizeAdapter

            let label = YYLabel()
            label.preferredMaxLayoutWidth = width
            label.numberOfLines = 2;
            label.text = (commentModel.agent_name ?? "") + ":" + (commentModel.content ?? "")
            label.textVerticalAlignment = .center
            if commentModel.show != true {
                let height = UILabel.getHeightByWidth(width, title: text.string, font: FONT(s: 14))
                if height > 19 * SizeAdapter {
                    addSeeMoreButton(label: label, commentModel: commentModel)
                }
            }
            return label
        }   

        for view in self.subviews {
            view.removeFromSuperview()
        }
        if list!.count > 0 {
            let cou = list!.count > 2 ? 2 : list!.count

            var lastView : YYLabel? = nil

            for i in 0..<cou {
                let model = listModels[i]
                let label = configYYLabelWithModel(commentModel: model)
                let superModel = (self.viewModel as! WYAAgentRingViewModel).list[self.index]
                let height = superModel.commentHeightArray?[i]
                let y = (lastView?.cmam_bottom ?? 0) + (i == 0 ? 10 * SizeAdapter : 6 * SizeAdapter)

                label.frame = CGRect(x: 10 * SizeAdapter, y: y, width: ScreenWidth - 94 * SizeAdapter, height: height ?? 0)
                self.addSubview(label)
                lastView = label
            }
        }

    }
}
