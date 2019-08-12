//
//  MoreCommentViewController.swift
//  WYASwiftMaterial
//
//  Created by 李世航 on 2019/7/25.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

import UIKit

class MoreCommentViewController: BaseViewController {
    public var model : WYAAgentRingModel.WYAAgentRingListModel.WYAAgentRingListItemModel?
    var viewModel = WYAMoreCommentViewModel()

    lazy var tableView = {()->UITableView in
        let tableView = UITableView(frame: CGRect(x: 0, y: WYATopHeight, width: ScreenWidth, height: ScreenHeight-WYATabBarHeight), style: .grouped)
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(WYAAgentRingCell.self, forCellReuseIdentifier: "CellId")
        tableView.register(MoreCommentCell.self, forCellReuseIdentifier: "comments")
        tableView.estimatedSectionHeaderHeight = 0.0
        tableView.estimatedSectionFooterHeight = 0.0
        return tableView
    }()

    override func viewDidLoad() {
        self.view.addView(views: [tableView])
        tableView.mj_header = MJRefreshStateHeader.init(refreshingBlock: {
            self.viewModel.getMoreCommentsForAgentRing(params: ["circle_id":self.model!.circle_id!, "page":1, "pageSize":15], handler: { (result) in
                self.tableView.mj_header.endRefreshing()
                self.tableView.reloadData()
            })
        })

        tableView.mj_footer = MJRefreshBackNormalFooter.init(refreshingBlock: {

        })
        tableView.mj_header.beginRefreshing()
    }
}

extension MoreCommentViewController:UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return self.viewModel.list?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath)) as! WYAAgentRingCell
            cell.setModel(model: model!)
            return cell
        } else {
            let cell = (tableView.dequeueReusableCell(withIdentifier: "comments", for: indexPath)) as! MoreCommentCell
            cell.bindViewModel(viewModel: self.viewModel)
            cell.configCellModel(indexPath: indexPath)
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return CGFloat(model!.cellHeight)
        }
        return 60
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
