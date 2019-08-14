//
//  LoginViewController.swift
//  WYASwiftMaterial
//
//  Created by 李世航 on 2019/6/19.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navBar.isHidden = true
        WYALoginLocalModelTool.deleteLoginAgentListData()
        wyaUserDefaultRemoveObjectForKey(key: AccessToken)
        wyaUserDefaultRemoveObjectForKey(key: HomeCoverImageUrl)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navBar.isHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let loginV = LoginView(frame: self.view.frame)
        self.view.addSubview(loginV)
        loginV.loginButtonback = { (name, password) in
            self.loginRequest(name ?? "", password: password ?? "")
        }
    }
}

extension LoginViewController {

    func loginRequest(_ name:String ,password: String) {
        WYALoginModel.login(name, password , success: { (data) in
            let model = data as! WYALoginDataModel
            let agentCount = model.data?.agent?.count ?? 0
            WYALoginLocalModelTool.deleteLoginAgentListData()
            guard agentCount != 0 else{
                UIView.wya_showCenterToast(withMessage: "没有可以选择的产品线")
                return
            }
            if(agentCount > 1){
                WYALoginLocalModelTool.saveLoginLocalModel(agentLoginModels: model.data!.agent!)
                let chooseVC = WYAChooseProductLineViewController.init()
                chooseVC.dataSources = model.data?.agent
                self.navigationController?.pushViewController(chooseVC, animated: true)
            }else if(agentCount == 1){
                var tempModel = model.data?.agent?.first
                tempModel?.ischoose = true
                let agentListModels:Array<WYALoginDataModel.WYALoginUserInfoModel.WYAAgentItem> = [tempModel!]
                WYALoginLocalModelTool.saveLoginLocalModel(agentLoginModels: agentListModels)
                self.choosePL(model.data?.agent?.first ?? nil)
            }
        }, failure: { (error) in

        })
    }

   func choosePL(_ model : WYALoginDataModel.WYALoginUserInfoModel.WYAAgentItem?) -> Void {
        guard model != nil else{
            UIView.wya_showCenterToast(withMessage: "没有可以选择的产品线")
            return
        }
        WYALoginModel.chooseProductLin(adminId: model?.admin_id?.int ?? 0, success: { (data) in
            Window?.rootViewController = RootViewController()
        }) { (error) in

        }
    }
}





