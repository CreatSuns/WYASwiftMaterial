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
    public var loginButtonback : callback!

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

    lazy var usernameTF: WYABottomLineTextField = {
        let rec = tuple((phoneLab.cmam_left,
                         phoneLab.cmam_bottom + 15 * SizeAdapter,
                         self.cmam_width - 62 * SizeAdapter,
                         45 * SizeAdapter))

        let textField = WYABottomLineTextField()
        textField.frame = rec
        textField.keyboardType = .numberPad
        textField.font = FONT(s: 20)
        textField.placeholder = "请输入手机号"
        textField.isPhoneNumber = true
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        button.setImage(UIImage(named: "icon_delete_normal"), for: .normal)
        button.addCallBackAction({ (button) in
            textField.text = ""
        })
        textField.rightView = button
        textField.rightViewMode = .whileEditing
        textField.tintColor = wya_whiteColor
        textField.textColor = wya_whiteColor
        textField.setPlaceholderColor(wya_textGrayColor)
        textField.editingBlock = {
            if textField.text!.count > 0 {
                if self.passwordTF.text!.count > 0 {
                    self.loginButton.isEnabled = true
                } else {
                    self.loginButton.isEnabled = false
                }
            } else {
                self.loginButton.isEnabled = false
            }
        }
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

    lazy var passwordTF: WYABottomLineTextField = {
        let rec = tuple((passwordLab.cmam_left,
                         passwordLab.cmam_bottom + 15 * SizeAdapter,
                         self.cmam_width - 62 * SizeAdapter,
                         45 * SizeAdapter))

        let textField = WYABottomLineTextField()
        textField.frame = rec
        textField.isSecureTextEntry = true
        textField.tintColor = .white
        textField.returnKeyType = .done
        textField.placeholder = "请输入密码"
        textField.setPlaceholderColor(wya_textGrayColor)
        textField.font = FONT(s: 20)
        textField.textColor = .white
        textField.returnKeyType = .done
        textField.editingBlock = {
            if textField.text!.count > 0 {
                if self.usernameTF.text!.count > 0 {
                    self.loginButton.isEnabled = true
                } else {
                    self.loginButton.isEnabled = false
                }
            } else {
                self.loginButton.isEnabled = false
            }
        }
        return textField
    }()

    lazy var loginButton: UIButton = {
        let button = UIButton(frame: CGRect(x: (self.cmam_width - 315 * SizeAdapter) / 2,
                                            y: passwordTF.cmam_bottom + 56 * SizeAdapter,
                                            width: 315 * SizeAdapter,
                                            height: 44 * SizeAdapter))
        button.setTitle("登录", for: UIControlState.normal)
        button.setTitleColor(wya_textBlackColor, for: UIControlState.normal)
        button.setTitleColor(wya_textWhitColorl, for: .disabled)
        button.setBackgroundImage(UIImage.wya_createImage(with: wya_whiteColor), for: .normal)
        button.setBackgroundImage(UIImage.wya_createImage(with: wya_whiteColor.withAlphaComponent(0.5)), for: .disabled)
        button.layer.cornerRadius = 22 * SizeAdapter
        button.layer.masksToBounds = true
        button.titleLabel?.font = FONT(s: 16)
        button.isEnabled = false
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
        loginButtonback(usernameTF.text, passwordTF.text)
    }
}
