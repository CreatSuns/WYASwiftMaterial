//
//  ExampleNavBarVC.swift
//  WYASwiftEnv
//
//  Created by 李俊恒 on 2018/8/16.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

import UIKit

class ExampleNavBarVC: BaseViewController{
    let dataSources = ["右侧添加一个图片按钮","右侧添加多个图片按钮","导航栏添加背景图"]
    // 懒加载模式
    lazy var tableView = {()->UITableView in
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight-WYATabBarHeight))
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellId")
        tableView.tableFooterView = UIView()
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navTitle = "设置图片格式按钮背景色"
        self.view.addSubview(self.tableView)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func rightButtonClicked(sender: UIButton) {
        debugPrint("\(String(describing: sender.titleLabel?.text))")
    }
}
extension ExampleNavBarVC:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSources.count
    }
    
    //设置section的数量
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //设置tableview的cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath)) as UITableViewCell
        cell.textLabel?.text = dataSources[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            self.createNavigationItemRightBarButtonWithNormalTitle(nil, "搜索")
            break
        case 1:
            
            self.createNavigationItemsRightBarButtonsWithNormalImages(["搜索","更多"])
            break
            
        case 2:
            self.navBackGroundImageNamed = "navbgimg"
            break
        default:
            break
        }
    }
}
