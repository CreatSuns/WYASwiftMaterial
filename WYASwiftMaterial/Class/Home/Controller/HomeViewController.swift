//
//  HomeViewController.swift
//  WYASwiftEnv
//
//  Created by 李俊恒 on 2018/8/14.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    var viewModel = WYAAgentRingViewModel()

    // 懒加载模式
    lazy var tableView = {()->UITableView in
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight-WYATabBarHeight), style: .grouped)
            tableView.backgroundColor = UIColor.white
            tableView.delegate = self
            tableView.dataSource = self
            tableView.separatorStyle = .none
            tableView.register(WYAAgentRingCell.self, forCellReuseIdentifier: "CellId")
            tableView.register(WYAAgentRingFooterView.self, forHeaderFooterViewReuseIdentifier: "foot")
            tableView.tableFooterView = UIView()
            tableView.tableHeaderView = WYAAgentRingCoverView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 255 * SizeAdapter))
        return tableView
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchAgentRingCoverImage { (string) in
            (self.tableView.tableHeaderView as! WYAAgentRingCoverView).agentRingCoverImageView.sd_setImage(with: URL(string: string), placeholderImage: UIImage(named: "pic_shouyebackground"), options: .retryFailed, context: nil)
        }
//        viewModel.fetchAgentRingList(params: ["pageSize":10,"circle_pass_id":0]) {
//            self.tableView.reloadData()
//        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.tableView)
        self.navTitle = "首页"
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }

        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // 设置section的数量
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.list.count
    }
    
    // 设置tableview的cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath)) as! WYAAgentRingCell
        cell.bindViewModel(viewModel: self.viewModel)
        cell.configCellWithIndexPath(indexPath: indexPath)
        return cell
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "foot")
        return footView
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(viewModel.list[indexPath.section].cellHeight)
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         var vc:BaseViewController?
        switch indexPath.row {
        case 0:
            vc = ExampleNavBarVC()
            break
        case 1:
            vc = EXampleNavSetVC()
            break
            
        case 2:
            vc = ExampleNetWorkVC()
            break
        default:
            break
        }
        vc?.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}


