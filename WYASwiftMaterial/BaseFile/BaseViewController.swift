//
//  BaseViewController.swift
//  WYASwiftEnv
//
//  Created by 李俊恒 on 2018/8/14.
//  Copyright © 2018年 WeiYiAn. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    //MARK: 可以外部访问继承的成员变量
    var navTitleColor : UIColor = UIColor.black
    {
        didSet{
            self.titleLabel.textColor = navTitleColor
        }
    }
    var navtitleFont : CGFloat = 18.0{
        didSet{
            self.titleLabel.font = FONT(s: navtitleFont)
            let width:CGFloat = navTitle.getNormalStringMaxWidth(font: navtitleFont*SizeAdapter, maxHeight: 44)
            self.titleLabel.frame = CGRect(x: 0, y: 0, width: width, height: 44)
        }
    }

    var leftBarButtonItemTitleFont : CGFloat = 13.0{
        didSet{
            
            self.leftButton.titleLabel?.font = FONT(s: leftBarButtonItemTitleFont)
        }
    }

    var rightBarButtonItemTitleFont : CGFloat = 13.0{
        didSet{
            self.rightButton.titleLabel?.font = FONT(s: rightBarButtonItemTitleFont)
            let buttonTitle = self.rightButton.titleLabel?.text
            let width:CGFloat = (buttonTitle?.getNormalStringMaxWidth(font: rightBarButtonItemTitleFont*SizeAdapter, maxHeight: 44))!
            self.rightButton.frame = CGRect(x: 0, y: 0, width: width, height: 44)
        }
    }
    
    var isShowNavLine : Bool = true{
        didSet{
            if !isShowNavLine {
                self.navLineView.removeFromSuperview()
            }
        }
    }

    var viewBackGroundColor : UIColor = UIColor.white{
        didSet{
            self.view.backgroundColor = viewBackGroundColor
        }
    }

    var navBackGroundColor : UIColor = UIColor.white{
        didSet{
            self.navigationController?.navigationBar.barTintColor = navBackGroundColor
        }
    }
    var navTitle:String = "微一案"{
        didSet{
            self.titleLabel.text = navTitle
            let width:CGFloat = navTitle.getNormalStringMaxWidth(font: navtitleFont*SizeAdapter, maxHeight: 44)
            self.titleLabel.frame = CGRect(x: 0, y: 0, width: width, height: 44)
        }
    }
    var navBackGroundImageNamed : String = " "{
        didSet{
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: navBackGroundImageNamed), for: UIBarMetrics.default)
        }
    }
    
    /// 用于创建多个右侧按钮时调整按钮之间的间距，在创建之前先赋值，然后再创建按钮顺序不要搞错了
    var itemsSpace : CGFloat = 10
    
    //MARK: 私有变量
    private lazy var navLineView = { ()->UIView in
        let LineView = UIView(frame: CGRect(x: 0, y: WYANavBarHeight, width: ScreenWidth, height: 1))
       
        LineView.backgroundColor = UIColor.groupTableViewBackground
        
        return LineView
    }()
    
    private lazy var rightButton : UIButton = {()->UIButton in
        
        let rightBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        
        rightBtn.titleLabel?.font = FONT(s: 13)
        
        rightBtn.titleLabel?.textAlignment = NSTextAlignment.center
        
        rightBtn.setTitleColor(UIColor.black, for: UIControlState.normal)
        
        rightBtn.setTitleColor(UIColor.groupTableViewBackground, for: UIControlState.highlighted)
       
        rightBtn.addTarget(self, action:#selector(rightButtonClicked(sender:)), for: UIControlEvents.touchUpInside)
        
        return rightBtn
    }()
    
   private lazy var leftButton = {()->UIButton in
        let leftBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))

        leftBtn.titleLabel?.font = FONT(s: 13)

        leftBtn.titleLabel?.textAlignment = NSTextAlignment.center

        leftBtn.setTitleColor(.black, for: .normal)
        leftBtn.setTitleColor(.groupTableViewBackground, for: .highlighted)

        leftBtn.addTarget(self, action: #selector(leftButtonCilcked(sender:)), for: UIControlEvents.touchUpInside)
        return leftBtn
    }()
    private lazy var titleLabel = {()->UILabel in
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200*SizeAdapter, height: 44))
        titleLabel.textColor = UIColor.black
        titleLabel.font = FONT(s: navtitleFont)
        titleLabel.textAlignment = NSTextAlignment.center
        return titleLabel
    }()
    
    //MARK: native func
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        
        self.addtitleWhithName(titleStr: self.navTitle)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.addSubview(self.navLineView)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let viewControllersArray = (self.navigationController?.viewControllers)!
        if ((viewControllersArray.index(of: self))! > 0) {
            self.setupLeftBarButton()
        }
        self.view.backgroundColor = UIColor.white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}



extension BaseViewController{
    //MARK:解决tabView被TabBar遮挡问题,OC会出现这个问题，先放这里吧，后续用到了可以直接调用
    func solveableViewOverrides(tableView:UITableView) -> Void {
        // OC代码tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        // 注意这里swift的按位或，是要放在数组中的，以下面方式调用
        tableView.autoresizingMask = [UIViewAutoresizing.flexibleHeight,.flexibleWidth]
        //   OC:self.edgesForExtendedLayout = UIRectEdgeNone;四周均不延伸
        //  下边这种方式是设置四周不延伸
        self.edgesForExtendedLayout = []
    }
    
    //MARK: 重写导航栏左侧原声按钮
    func setupLeftBarButton() -> Void {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "返回")?.withRenderingMode(.alwaysOriginal), style: UIBarButtonItemStyle.plain, target: self, action: #selector(leftBarButtonCilcked(sender:)))
    }
}


// MARK: - 基本配置
extension BaseViewController{
    
    func addtitleWhithName(titleStr:String) -> Void {
        self.titleLabel.text = titleStr
        self.navigationItem.titleView = self.titleLabel
    }
    
    /// 自定义创建左按钮
    ///
    /// - Parameters:
    ///   - buttonTitle: 按钮的标题可以传nil
    ///   - imageNamed: 按钮的图片名称可以传nil
    func createNavigationItemLeftBarButton(_ buttonTitle:String?,_ imageNamed:String?) -> Void {
        
        if buttonTitle != nil {
            let width:CGFloat = (buttonTitle?.getNormalStringMaxWidth(font: 13*SizeAdapter, maxHeight: 44))!
            self.leftButton.frame = CGRect(x: 0, y: 0, width: width, height: 44)
            self.leftButton.setTitle(buttonTitle, for: UIControlState.normal)
        }else if imageNamed != nil{
            self.leftButton.setImage(UIImage(named: imageNamed!), for: UIControlState.normal)
        }
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: self.leftButton)
    }
    
    /// 自定义创建右侧按钮
    ///
    /// - Parameters:
    ///   - buttonTitle: 右侧按钮的文字
    ///   - imageNamed: 右侧按钮的图片
    func createNavigationItemRightBarButtonWithNormalTitle(_ buttonTitle:String?,_ imageNamed:String?) -> Void {
        if buttonTitle != nil {
            let width:CGFloat = (buttonTitle?.getNormalStringMaxWidth(font: 13*SizeAdapter, maxHeight: 44))!
            self.rightButton.frame = CGRect(x: 0, y: 0, width: width, height: 44)
            self.rightButton.setTitle(buttonTitle, for: UIControlState.normal)
        }else if imageNamed != nil{
            self.rightButton.setImage(UIImage(named: imageNamed!), for: UIControlState.normal)
        }
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.rightButton)
        
    }
    
    /// 导航栏循环创建多个按钮
    ///
    /// - Parameters:
    ///   - titls: 按钮标题数组
    ///   - titleNormalColor: 按钮字体颜色（默认是黑色）
    func createNavigationItemsRightBarButtonsWithNormalTitles(_ titls:Array<String> ,titleNormalColor:UIColor?, font:CGFloat?) -> Void {
        var rightButtonArray = Array<UIBarButtonItem>()
        var width:CGFloat?
        for i in 0..<titls.count {
            let customButton = UIButton(type: .custom)
            if font != nil{
                customButton.titleLabel?.font = FONT(s: font!)
                width = titls[i].getNormalStringMaxWidth(font: font!*SizeAdapter, maxHeight: 44)
                
            }else{
                customButton.titleLabel?.font = FONT(s: 13)
                width = titls[i].getNormalStringMaxWidth(font: 13*SizeAdapter, maxHeight: 44)
                
            }
            customButton.titleLabel?.textAlignment = NSTextAlignment.center
            if titleNormalColor != nil{
                customButton.setTitleColor(titleNormalColor!, for: UIControlState.normal)
            }else{
                customButton.setTitleColor(UIColor.black, for: UIControlState.normal)
            }
            customButton.setTitleColor(UIColor.groupTableViewBackground, for: UIControlState.highlighted)
            customButton.tag = i
            customButton.addTarget(self, action: #selector(rightButtonClicked(sender:)), for: UIControlEvents.touchUpInside)
            customButton.setTitle(titls[i], for: UIControlState.normal)
            customButton.frame = CGRect(x: 0, y: 0, width: width!, height: 44)
            let rightBarButtonItem = UIBarButtonItem(customView: customButton)
            let fixedSpaceItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
            fixedSpaceItem.width = self.itemsSpace*SizeAdapter
            rightButtonArray.append(rightBarButtonItem)
            rightButtonArray.append(fixedSpaceItem)
        }
        rightButtonArray.removeLast()
        self.navigationItem.rightBarButtonItems = rightButtonArray
    }
    
    /// 图片循环创建多个按钮
    ///
    /// - Parameters:
    ///   - images: 图片名字数组
    func createNavigationItemsRightBarButtonsWithNormalImages(_ images:Array<String>) -> Void {
        var rightButtonArray = Array<UIBarButtonItem>()
        for i in 0..<images.count {
            let customButton = UIButton(type: .custom)
            customButton.tag = i
            customButton.addTarget(self, action: #selector(rightButtonClicked(sender:)), for: UIControlEvents.touchUpInside)
            customButton.setBackgroundImage(UIImage(named: images[i]), for: UIControlState.normal)
            customButton.frame = CGRect(x: 0, y: 7*SizeAdapter, width: 20*SizeAdapter, height: 20*SizeAdapter)
            let rightBarButtonItem = UIBarButtonItem(customView: customButton)
            rightButtonArray.append(rightBarButtonItem)
        }
        self.navigationItem.rightBarButtonItems = rightButtonArray
    }
}

//MARK: 按钮点击事件
extension BaseViewController{
    /// 自定义单个的右侧按钮点击事件
    ///
    /// - Parameter sender: 导航栏右侧按钮点击（单个）
    @objc func rightButtonClicked(sender:UIButton) -> Void {
        let text = sender.titleLabel?.text
        debugPrint("\(text!)")
    }
    
    /// 导航栏的返回按钮被点击
    ///
    /// - Parameter sender: 返回按钮
    @objc func leftBarButtonCilcked(sender:UIButton) -> Void{
        self.navigationController?.popViewController(animated: true)
    }
    
    /// 自定义的导航栏左侧按钮被点击
    ///
    /// - Parameter sendr: 自定义的左侧按钮
    @objc func leftButtonCilcked(sender:UIButton) -> Void {
        let text = sender.titleLabel?.text
        debugPrint("\(text!)")
    }
}
