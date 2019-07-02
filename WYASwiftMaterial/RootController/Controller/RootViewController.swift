//
//  RootViewController.swift
//  WYASwiftEnv
//
//  Created by 李俊恒 on 2018/8/14.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

import UIKit

class RootViewController: UITabBarController {
    var normalTitleColor : UIColor = UIColor.init(red: 102.0/255.0, green: 102.0/255.0, blue: 102.0/255.0, alpha: 1.0){
        didSet{
            UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor:normalTitleColor,NSAttributedStringKey.font:UIFont.systemFont(ofSize: tabBarTitleFont)], for: UIControlState.normal)
        }
    }
    var selectedTitleColor : UIColor = UIColor.init(red: 77.0/255.0, green: 154.0/255.0, blue: 247.0/255.0, alpha: 1.0) {
        didSet{
              UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor:selectedTitleColor], for: UIControlState.selected)
        }
    }
    
    var tabBarTitleFont : CGFloat = 14.0{
        didSet{
            UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor:normalTitleColor,NSAttributedStringKey.font:UIFont.systemFont(ofSize: tabBarTitleFont)], for: UIControlState.normal)
        }
    }
    
    
    // MARK: 设置成员变量
   private var tabBarModelArray = Array<RootControllerModel>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.isTranslucent = false
        self.createTabBarModelArray()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
extension RootViewController{
    // MARK: - createModelArray
    func createTabBarModelArray() -> Void {
        let homeModel = RootControllerModel.rootCOntrollerModel(tabBarTitle: "首页", className: "HomeViewController", normalImageName: "icon_shouye", selectefImageName: "icon_shouye_press")
        let materialModel = RootControllerModel.rootCOntrollerModel(tabBarTitle: "素材", className: "MaterialViewController", normalImageName: "icon_sucai", selectefImageName: "icon_sucai_press")
        let mineModel = RootControllerModel.rootCOntrollerModel(tabBarTitle: "我的", className: "MineViewController", normalImageName: "icon_me", selectefImageName: "icon_me_press")
        tabBarModelArray.append(homeModel)
        tabBarModelArray.append(materialModel)
        tabBarModelArray.append(mineModel)
        
        self.createViewControllers()
    }
    // MARK: - 初始化tabBarItems
    func createViewControllers() -> Void {
        var viewControllers = Array<UINavigationController>()
        for model in tabBarModelArray {
            // 通过类名动态创建控制器
            let className = model.className
            let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
            let cls = NSClassFromString(namespace+"."+className!)as!BaseViewController.Type
            let viewController = cls.init()
            let nav = UINavigationController.init(rootViewController: viewController)
            nav.tabBarItem.title = model.tabBarTitle
            nav.tabBarItem.image = model.normalImag()
            nav.tabBarItem.selectedImage = model.selectedImg()
            UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor:normalTitleColor,NSAttributedStringKey.font:UIFont.systemFont(ofSize: tabBarTitleFont)], for: UIControlState.normal)
            
            UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor:selectedTitleColor], for: UIControlState.selected)
            
            viewControllers.append(nav)
        }
        self.viewControllers = viewControllers
        
        // 调整文字和图片的间距
        for item in self.tabBar.items! {
            item.titlePositionAdjustment = UIOffsetMake(0, 2)
            item.imageInsets = UIEdgeInsetsMake(-1, 0, 1, 0)
        }
    }

}
