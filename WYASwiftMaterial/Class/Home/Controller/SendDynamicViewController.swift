//
//  SendDynamicViewController.swift
//  WYASwiftMaterial
//
//  Created by 李世航 on 2019/7/26.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

import UIKit

class SendDynamicViewController: BaseViewController {
    var dataSources = [UIImage]()

    lazy var textView : WYATextView = {
        let view = WYATextView()
        view.textView.font = FONT(s: 16)
        view.textView.textColor = wya_textBlackColor
        view.textView.wya_placeHolder = "请输入文字"
        view.textView.wya_placeHolderColor = .gray
        view.textView.returnKeyType = .done
        view.showTitle = false
        view.textViewWordsCount = 500
        view.textViewMaxHeight = 150 * SizeAdapter
        view.autoChangeHeight = true
        view.textView.delegate = (self as UITextViewDelegate)
        view.textViewContentFrame = {

        }
        return view
    }()

    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.headerReferenceSize = CGSize(width: 0, height: 0)
//        layout.itemSize = CGSize(width: (ScreenWidth - 56 * SizeAdapter) / 3, height: (ScreenWidth - 56 * SizeAdapter) / 3)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.delegate = (self as UICollectionViewDelegate)
        view.dataSource = (self as UICollectionViewDataSource)
        view.backgroundColor =  wya_whiteColor
        view.register(cameraCell.self, forCellWithReuseIdentifier: "cell")
        view.register(editImageCell.self, forCellWithReuseIdentifier: "edit")
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navTitle = "发布动态"
        self.view.addView(views: [textView, collectionView])
        textView.frame = CGRect(x: 10 * SizeAdapter, y: WYATopHeight + 10 * SizeAdapter, width: self.view.cmam_width - 30 * SizeAdapter, height: 100 * SizeAdapter)
        collectionView.frame = CGRect(x: 23 * SizeAdapter, y: textView.cmam_bottom + 5 * SizeAdapter, width: self.view.cmam_width - 46 * SizeAdapter, height: (self.view.cmam_width - 46 * SizeAdapter)/3)
    }

}

extension SendDynamicViewController : UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSources.count + 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == self.dataSources.count {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! cameraCell
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "edit", for: indexPath) as! editImageCell
        cell.imageView.image = self.dataSources[indexPath.item]
        return cell

    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (ScreenWidth - 56 * SizeAdapter) / 3, height: (ScreenWidth - 56 * SizeAdapter) / 3)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5 * SizeAdapter
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5 * SizeAdapter
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let alert = WYAAlertController.wya_alertSheet(withTitle: nil, message: nil, alertSheetCornerRadius: 8)
        let photoAction = WYAAlertAction.wya_action(withTitle: "拍照", textColor: wya_blackColor) {[weak self] in
            self?.goCamera()
        }
        let ablumAction = WYAAlertAction.wya_action(withTitle: "从相册中选择", textColor: wya_blackColor) {[weak self] in
            self?.goPhotoAlbum()
        }
        alert.wya_add([photoAction!, ablumAction!])
        self.present(alert, animated: true, completion: nil)
    }

    func goCamera() {
        WYASystemPermissions.wya_checkSystemPermissionType(.camera, authorizedBlock: {[weak self] in
            let cameraVC = WYACameraViewController(type: .image, cameraOrientation: .back)
            cameraVC?.preset = NSString(utf8String: AVCaptureSession.Preset.high.rawValue)
            cameraVC?.takePhoto = {(image, path) in

            }
            self?.present(cameraVC!, animated: true, completion: nil)

        }, nowNotAllowAuthorizedBlock: {

        }, neverNotAllowAuthorizedBlock: {[weak self] in
            let alert = WYAAlertController.wya_alert(withTitle: "您未授权访问相机，请进入手机设置页面进行授权", message: nil, alertLayoutStyle: .horizontal)
            alert.backgroundButton.isEnabled = false
            alert.presentStyle = .bounce
            alert.dismissStyle = .shrink
            let defaultAction = WYAAlertAction.wya_action(withTitle: "取消", textColor: wya_blackColor, handler: {

            })
            let cancelAction = WYAAlertAction.wya_action(withTitle: "设置权限", textColor: wya_blueColor, handler: {
                UIApplication.shared.openURL(URL(string: UIApplicationOpenSettingsURLString)!)
            })
            alert.wya_add([defaultAction!, cancelAction!])
            self?.present(alert, animated: true, completion: nil)
        })
    }

    func goPhotoAlbum() {
        WYASystemPermissions.wya_checkSystemPermissionType(.album, authorizedBlock: {[weak self] in
            let album = WYAPhotoBrowser()
            album.config.maxSelectCount = 9
            album.config.sortAscending = true
            album.callBackBlock = {(images, assets) in
                self?.dataSources = self!.dataSources + (images as! Array<UIImage>)
                self?.collectionView.reloadData()
            }
            self?.present(album, animated: true, completion: nil)
        }, nowNotAllowAuthorizedBlock: {

        }) {[weak self] in
            let alert = WYAAlertController.wya_alert(withTitle: "您未授权访问相机，请进入手机设置页面进行授权", message: nil, alertLayoutStyle: .horizontal)
            alert.backgroundButton.isEnabled = false
            alert.presentStyle = .bounce
            alert.dismissStyle = .shrink
            let defaultAction = WYAAlertAction.wya_action(withTitle: "取消", textColor: wya_blackColor, handler: {

            })
            let cancelAction = WYAAlertAction.wya_action(withTitle: "设置权限", textColor: wya_blueColor, handler: {
                UIApplication.shared.openURL(URL(string: UIApplicationOpenSettingsURLString)!)
            })
            alert.wya_add([defaultAction!, cancelAction!])
            self?.present(alert, animated: true, completion: nil)
        }
    }
}

extension SendDynamicViewController : UITextViewDelegate {

}
