//
//  EXampleNavSetVC.swift
//  WYASwiftEnv
//
//  Created by 李俊恒 on 2018/8/16.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

import UIKit

class EXampleNavSetVC: BaseViewController {
    let dataSources = ["右侧添加一个文字按钮","右侧添加多个文字按钮","导航栏背景色改变","改变导航栏标题字体颜色","导航栏字体变大","导航栏字体变小"]
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
        self.navTitle = "设置导航栏基本格式"
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

extension EXampleNavSetVC:UITableViewDelegate, UITableViewDataSource{
    
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
            self.createNavigationItemRightBarButtonWithNormalTitle("按钮1", nil)
            break
        case 1:
            self.createNavigationItemsRightBarButtonsWithNormalTitles(["按钮1","按钮2",
                                                                       "按钮3"], titleNormalColor: nil, font: nil)
            break
        case 2:
            self.navBackGroundColor = randomColor()
            break
        case 3:
            self.navTitleColor = randomColor()
            break
        case 4:
            self.navtitleFont = 20
            self.rightBarButtonItemTitleFont = 18
            break
        case 5:
            self.navtitleFont = 10
            self.rightBarButtonItemTitleFont = 9
            break
        default:
            break
        }
    }
}

