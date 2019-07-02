//
//  LoginView.swift
//  WYASwiftMaterial
//
//  Created by 李世航 on 2019/6/19.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

import UIKit

class LoginView: UIView {

    typealias callback = (String?, String?) -> Void
    public var nativeCallback : callback!

    lazy var bgImageView : UIImageView = {
        let bgImageView = UIImageView(frame: self.frame)
        bgImageView.image = UIImage(named: "1125-2436")
        return bgImageView
    }()

    lazy var coverView : UIView = {
        let coverView = UIView(frame: bgImageView.frame)
        coverView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return coverView
    }()

    lazy var iconImageView : UIImageView = {
        let rect = CGRect(x: 33.0 * SizeAdapter,
                          y: 90.0 * SizeAdapter,
                          width: 40.0 * SizeAdapter,
                          height: 40.0 * SizeAdapter)
        let iconImageView = UIImageView(frame: rect)
        iconImageView.image = UIImage(named: "icon_logo")
        return iconImageView
    }()

    lazy var materialLabel : UILabel = {
        let materialLabel = UILabel(frame: CGRect(x: iconImageView.cmam_right + 5.0,
                                                  y: iconImageView.cmam_top - 3,
                                                  width: 140 * SizeAdapter,
                                                  height: 40 * SizeAdapter))
        materialLabel.text = "云素材"
        materialLabel.textColor = wya_whiteColor
        materialLabel.font = FONT(s: 25)
        return materialLabel
    }()

    lazy var phoneLab : UILabel = {
        let phoneLab = UILabel(frame: CGRect(x: iconImageView.cmam_left,
                                             y: iconImageView.cmam_bottom + 47 * SizeAdapter,
                                             width: 55 * SizeAdapter,
                                             height: 12 * SizeAdapter))
        phoneLab.textColor = wya_whiteColor
        phoneLab.text = "手机号码"
        phoneLab.font = FONT(s: 12)
        return phoneLab
    }()

    lazy var usernameTF: UITextField = {
        let rec = tuple((phoneLab.cmam_left,
                         phoneLab.cmam_bottom + 15 * SizeAdapter,
                         self.cmam_width - 62 * SizeAdapter,
                         45 * SizeAdapter))

        let textField = UITextField(frame: rec)
        textField.borderStyle = .roundedRect
        textField.placeholder = "请输入账号"
        textField.backgroundColor = .clear
        textField.text = "17858629460"
        return textField
    }()

    lazy var passwordLab: UILabel = {
        let label = UILabel(frame: CGRect(x: usernameTF.cmam_left,
                                          y: usernameTF.cmam_bottom + 18 * SizeAdapter,
                                          width: 50 * SizeAdapter,
                                          height: 12 * SizeAdapter))
        label.text = "密码"
        label.textColor = wya_whiteColor
        label.font = FONT(s: 12)
        return label
    }()

    lazy var passwordTF: UITextField = {
        let rec = tuple((passwordLab.cmam_left,
                         passwordLab.cmam_bottom + 15 * SizeAdapter,
                         self.cmam_width - 62 * SizeAdapter,
                         45 * SizeAdapter))

        let textField = UITextField(frame: rec)
        textField.borderStyle = .roundedRect
        textField.placeholder = "请输入账号"
        textField.backgroundColor = .clear
        textField.text = "123456"
        return textField
    }()

    lazy var loginButton: UIButton = {
        let button = UIButton(frame: CGRect(x: (self.cmam_width - 315 * SizeAdapter) / 2,
                                            y: passwordTF.cmam_bottom + 56 * SizeAdapter,
                                            width: 315 * SizeAdapter,
                                            height: 44 * SizeAdapter))
        button.setTitle("登录", for: UIControlState.normal)
        button.setTitleColor(wya_textBlackColor, for: UIControlState.normal)
        button.addTarget(self, action: #selector(buttonClick), for: UIControlEvents.touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addView(views: [bgImageView,
                             coverView,
                             iconImageView,
                             materialLabel,
                             phoneLab,
                             usernameTF,
                             passwordLab,
                             passwordTF,
                             loginButton])
    }
    func tuple(_ tuple:(CGFloat,CGFloat,CGFloat,CGFloat)) -> CGRect {
        return CGRect(x: tuple.0, y: tuple.1, width: tuple.2, height: tuple.3)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func buttonClick() {
        nativeCallback(usernameTF.text, passwordTF.text)
    }
}
