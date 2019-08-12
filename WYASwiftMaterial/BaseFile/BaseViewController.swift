//
//  BaseViewController.swift
//  WYASwiftEnv
//
//  Created by 李俊恒 on 2018/8/14.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController,WYANavBarDelegate,UIGestureRecognizerDelegate{
    /// 导航栏视图
    lazy var navBar:WYANavBar = {
        let object = WYANavBar.init()
        object.delegate = self
        object.navTitle = "素材库"
        object.isShowLine = true
        object.rightBarButtonItemTitleFont = 15
        object.leftBarButtonItemTitleFont = 15
        object.navTitleColor = wya_textWhitColorl
        object.backgroundColor = wya_blackColor
        object.navTitleFont = 18
        return object
    }()

    var navTitle:String = "" {
        didSet{
            self.navBar.navTitle = navTitle
        }
    }

    var navTitleColor:UIColor = .black{
        didSet{
            self.navBar.navTitleColor = navTitleColor;
        }
    }

    var navTitleFont:CGFloat = 18{
        didSet{
            self.navBar.navTitleFont = navTitleFont
        }
    }

    var leftBarButtonItemTitleFont:CGFloat = 15{
        didSet{
            self.navBar.leftBarButtonItemTitleFont = leftBarButtonItemTitleFont
        }
    }

    var rightBarButtonItemTitleFont:CGFloat = 15{
        didSet{
            self.navBar.rightBarButtonItemTitleFont = rightBarButtonItemTitleFont
        }
    }

    var isShowNavLine:Bool = true{
        didSet{
            self.navBar.isShowLine = isShowNavLine
        }
    }

    var navBackGroundColor:UIColor = .white{
        didSet{
            self.navBar.backgroundColor = navBackGroundColor
        }
    }

    var navBackGroundImageNamed:String = ""{
        didSet{
            self.navBar.backgroundImage = UIImage.init(named: navBackGroundImageNamed)!
        }
    }

    var hiddenNavBar:Bool = false{
        didSet{
                self.navBar.isHidden = hiddenNavBar
        }
    }


    /// 用于创建多个右侧按钮时调整按钮之间的间距，在创建之前先赋值，然后再创建按钮顺序不要搞错了默认为0，一般情况下建议不设置
    /// example：
    /// self.itemsSpace = 10;
    /// [self createNavigationItemsRightBarButtonWithNormalImg:@[@"img1",@"img2"] highlightedImg:nil];
    var itemSpace:CGFloat = 0{
        didSet{
            self.navBar.space = itemSpace
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 检测是否小上传pushDevicetoken
        self.navigationController?.isNavigationBarHidden = true
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if (self.navigationController?.viewControllers.count ?? 0) > 1 {
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        }else{
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = wya_bgColor
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.addCustomNavBar()
        self.wya_versionUpdateAlertview()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.bringSubview(toFront: self.navBar)
    }

    override var prefersStatusBarHidden: Bool {
        get{
            return false
        }
    }

    override var preferredStatusBarStyle: UIStatusBarStyle{
        get{
            return UIStatusBarStyle.lightContent
        }
    }

    override var shouldAutorotate: Bool{
        get{
            return false
        }
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        get{
            return UIInterfaceOrientationMask.portrait
        }
    }

    override func didReceiveMemoryWarning() {

    }
// MARK: public event methods
    func wya_goback() {
        self.navigationController?.popViewController(animated: true)
    }

    func wya_customleftBarButtonItemPressed(sender:UIButton) {
        wyaPrint(sender.titleLabel?.text ?? "")
    }

    func wya_customrRightBarButtonItemPressed(sender:UIButton) {
        wyaPrint(sender.titleLabel?.text ?? "")
    }

}

// MARK: private methods
extension BaseViewController{
    private func addCustomNavBar(){
        let arrViewControllers:Array<UIViewController> = self.navigationController!.viewControllers
        if (arrViewControllers.index(of: self)! > 0){
            self.navBar.wya_goBackButton(withImage: "icon_back")
        }
        self.view.addSubview(self.navBar)

    }
}

// MARK: public methods
extension BaseViewController{
    // MARK: about navBar custom leftBarButton
    func wya_addleftNavbarButton(normalTitles:Array<String>) {
        self.navBar.wya_addLeftNavBarButton(withNormalTitle: normalTitles)
    }

    func wya_addLeftNavBarButton(normalTitles:Array<String>,normalColors:Array<UIColor>,highlightedColors:Array<UIColor>) {
        self.navBar.wya_addLeftNavBarButton(withNormalTitle: normalTitles, normalColor: normalColors, highlightedColor: highlightedColors)
    }

    func wya_addLeftNavBarButton(normalImages:Array<String>,highlightedImgs:Array<String>) {
        self.navBar.wya_addLeftNavBarButton(withNormalImage: normalImages, highlightedImg: highlightedImgs)
    }

    // MARK: about navBar custom rightBarButton
    func wya_addRightNavbarButton(normalTitles:Array<String>) {
        self.navBar.wya_addRightNavBarButton(withNormalTitle: normalTitles)
    }

    func wya_addRightNavBarButton(normalTitles:Array<String>,normalColors:Array<UIColor>,highlightedColors:Array<UIColor>) {
        self.navBar.wya_addRightNavBarButton(withNormalTitle: normalTitles, normalColor: normalColors, highlightedColor: highlightedColors)
    }

    func wya_addRightNavBarButton(normalImages:Array<String>,highlightedImgs:Array<String>) {
        self.navBar.wya_addRightNavBarButton(withNormalImage: normalImages, highlightedImg: highlightedImgs)
    }
}
// MARK: WYANavBarDelegate
extension BaseViewController{
    func wya_goBackPressed(_ sender: UIButton) {
        self.wya_goback()
    }

    func wya_leftBarButtonItemPressed(_ sender: UIButton) {
        self.wya_customleftBarButtonItemPressed(sender: sender)
    }

    func wya_rightBarButtonItemPressed(_ sender: UIButton) {
        self.wya_customrRightBarButtonItemPressed(sender: sender)
    }
}




// MARK: 是否需要更新提示
extension BaseViewController{
    private func wya_versionUpdateAlertview() {
//        let url = "http://itunes.apple.com/lookup?id=1461432717"
//        self.postPath(path: url)
    }

    private func postPath(path:String) {

//        let url:URL = URL.init(string: path)!
//        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 10)
//        request.httpMethod = "POST"
//        let session = URLSession.shared
//
//        let dataTask = session.dataTask(with: request) { (data, respons, error) in
//            wyaPrint(error as Any)
//            if data == nil {return}
//            if respons == nil {return}
//            let str = String(data: data!,encoding: .utf8)
//            wyaPrint(str as Any)
//            wyaPrint(respons!)
//        }
//        dataTask.resume()



    }
}
