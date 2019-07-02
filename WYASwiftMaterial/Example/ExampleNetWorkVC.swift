//
//  ExampleNetWorkVC.swift
//  WYASwiftEnv
//
//  Created by 李俊恒 on 2018/8/16.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

import UIKit

class ExampleNetWorkVC: BaseViewController {
    lazy var netWorkButton = {()->UIButton in
        let button = UIButton(frame: CGRect(x: (ScreenWidth - 100*SizeAdapter)*0.5, y: WYATopHeight+20*SizeAdapter, width: 100*SizeAdapter, height: 80*SizeAdapter))
        button.backgroundColor = UIColor.yellow
        button.setTitle("get", for: UIControlState.normal)
        button.addTarget(self, action: #selector(buttongetClicked(sender:)), for: UIControlEvents.touchUpInside)
        button.setTitleColor(UIColor.black, for: UIControlState.normal)
        return button
        }()
    lazy var postButton = {()->UIButton in
        let button = UIButton(frame: CGRect(x: (ScreenWidth - 100*SizeAdapter)*0.5, y: WYATopHeight+160*SizeAdapter, width: 100*SizeAdapter, height: 80*SizeAdapter))
        button.backgroundColor = UIColor.yellow
        button.setTitle("post", for: UIControlState.normal)
        button.addTarget(self, action: #selector(buttonpostClicked(sender:)), for: UIControlEvents.touchUpInside)
        button.setTitleColor(UIColor.black, for: UIControlState.normal)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navTitle = "网络请求"
        self.view.addSubview(self.netWorkButton)
        self.view.addSubview(self.postButton)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ExampleNetWorkVC{
    
    @objc func buttongetClicked(sender:UIButton) -> Void {
        // get请求
        let token = UserDefaults.standard.object(forKey: "token") as!String
        
        let dic = ["access_token":token,"category_id":"274","page":"1"]
        BaseNetWork.requestData(.get, URLString: "https://app-wsapp.ruishan666.com/article/list",paramenters: dic) { (result) in
            debugPrint(result)
        }
    }
    
    @objc func buttonpostClicked(sender:UIButton) -> Void {
        // post请求
        let loginDic = ["password":"admin","user_name":"Admin"]
        BaseNetWork.requestData(.post, URLString: "https://app-wsapp.ruishan666.com/app/login", paramenters: loginDic) { (result) in
            debugPrint(result)
            // 将获取到的result转换为字典由于都是any类型需要指定类型[AnyHashable:Any]可以将any转换为字典类型
            let data:[AnyHashable:Any] = result as! [AnyHashable : Any]
            //将result里的data解析出来由于所有key值为String类型,所以指定类型为[String:Any]
            let dict:[String:Any] = data["data"] as! [String : Any]
            // access_token这个key值对应的value值是String类型指定类型
            let access_token:String = dict["access_token"] as! String
            // 获取到access_token的值存入本地
            UserDefaults.standard.set(access_token, forKey: "token")
            debugPrint(access_token)
            
        }
    }
}
