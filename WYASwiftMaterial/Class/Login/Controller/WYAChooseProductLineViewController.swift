//
//  WYAChooseProductLineViewController.swift
//  WYASwiftMaterial
//
//  Created by 李俊恒 on 2019/7/24.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

import UIKit
let CELLID = "CHOOSE_CELLID"

class WYAChooseProductLineViewController: BaseViewController ,UITableViewDelegate,UITableViewDataSource{


    var loginUserModel: WYALoginDataModel.WYALoginUserInfoModel?
    var lastSelectIndexPath:IndexPath = IndexPath.init(row: 0, section: 0)

    var dataSources:Array<WYALoginDataModel.WYALoginUserInfoModel.WYAAgentItem>?{
        didSet{
            self.lastSelectIndexPath = IndexPath.init(row: 0, section: 0)
            var agentModel = dataSources!.first
            agentModel!.ischoose = true
            WYALoginLocalModelTool.updateLoginAgentListData(model: agentModel!)
        }
    }

    lazy var headerLabelView:UIView = {
        let object = UIView.init(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: 90 * SizeAdapter))
        let label = UILabel.init(frame: CGRect(x: 20 * SizeAdapter, y: 0, width: ScreenWidth - 40 * SizeAdapter, height: 90 * SizeAdapter))
        label.text = "请选择产品线"
        label.font = FONT(s: 24)
        label.textColor = wya_textBlackColor
        object.addSubview(label)
        return object
    }()

    lazy var tableView:UITableView = {
        let tableView = UITableView.init(frame: CGRect(x: 0, y: WYATopHeight, width: ScreenWidth, height: ScreenHeight - WYATopHeight - WYATabBarHeight), style: UITableViewStyle.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.tableHeaderView = self.headerLabelView
        tableView.register(WYAChooseProductTableViewCell.self, forCellReuseIdentifier: CELLID)
        return tableView
    }()

    lazy var enterButton:UIButton = {
        let enterbutton = UIButton.init()
        enterbutton.wya_setBackgroundColor(wya_blackColor, for: .normal)
        enterbutton.wya_setBackgroundColor(.black, for: .highlighted)
        enterbutton.setTitle("立即进入", for: .normal)
        enterbutton.addCallBackAction({ (button) in
            self.enterHome()
        })
        return enterbutton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "产品线"
        self.view.wya_addSubViews([self.tableView,self.enterButton])


        self.enterButton.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.bottom.equalTo(self.view.snp.bottom)
            make.height.equalTo(WYATabBarHeight)
        }
        // Do any additional setup after loading the view.
    }

}

extension WYAChooseProductLineViewController{

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSources?.count ?? 0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70 * SizeAdapter
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let choosecell:WYAChooseProductTableViewCell = tableView.dequeueReusableCell(withIdentifier: CELLID, for: indexPath) as! WYAChooseProductTableViewCell
        let model = self.dataSources?[indexPath.row] ?? nil
        choosecell.setModel(model: model)
        if self.lastSelectIndexPath == indexPath {
            choosecell.rightImgView.isHidden = false
        }else{
            choosecell.rightImgView.isHidden = true
        }
       return choosecell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        let lastChooseProductCell:WYAChooseProductTableViewCell? = tableView.cellForRow(at: self.lastSelectIndexPath) as? WYAChooseProductTableViewCell
        if lastChooseProductCell != nil {
            // 隐藏
            lastChooseProductCell!.model?.ischoose = false
            lastChooseProductCell!.rightImgView.isHidden = true
            // 更新数据库数据
            WYALoginLocalModelTool.updateLoginAgentListData(model: lastChooseProductCell!.model!)
        }
        let chooseProductCell:WYAChooseProductTableViewCell = tableView.cellForRow(at: indexPath) as! WYAChooseProductTableViewCell
        chooseProductCell.rightImgView.isHidden = false
        self.lastSelectIndexPath = indexPath
        // 保存到数据库中（下次登陆后如果数据库查询到保存的已有产品线，择直接进入首页，该功能暂未实现）
        chooseProductCell.model?.ischoose = true
        WYALoginLocalModelTool.updateLoginAgentListData(model: chooseProductCell.model!)
    }

}

extension WYAChooseProductLineViewController{
    func enterHome() {
        let model = WYALoginLocalModelTool.lookpLoginAgentListData(whereString: "isChoose=true")
        WYALoginModel.chooseProductLin(adminId: model.admin_id, success: { (data) in
            wyaPrint(data)
        }) { (error) in

        }
    }
}
