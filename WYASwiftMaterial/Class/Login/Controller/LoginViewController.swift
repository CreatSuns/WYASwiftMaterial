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
            WYALoginModel.login(name ?? "", password ?? "", handle: {(model) in
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
                    WYALoginLocalModelTool.saveLoginLocalModel(agentLoginModels: model.data!.agent!)
                    self.choosePL(model.data?.agent?.first ?? nil)
                }
            })
        }

    }

}

extension LoginViewController {
  func choosePL(_ model : WYALoginDataModel.WYALoginUserInfoModel.WYAAgentItem?) -> Void {
    guard model != nil else{
        UIView.wya_showCenterToast(withMessage: "没有可以选择的产品线")
        return
    }
    WYALoginModel.chooseProductLin(adminId: (model?.admin_id!.int)!) { (result) in
        Window?.rootViewController = RootViewController()
    }
    }
}





