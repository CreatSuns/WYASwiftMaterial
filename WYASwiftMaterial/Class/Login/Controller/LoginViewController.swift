//
//  LoginViewController.swift
//  WYASwiftMaterial
//
//  Created by 李世航 on 2019/6/19.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        let loginV = LoginView(frame: self.view.frame)
        self.view.addSubview(loginV)
        loginV.nativeCallback = { (name, password) in
            WYALoginModel.login(name ?? "", password ?? "")
        }

    }

}

extension LoginViewController {

}





