//
//  WYAAgentViewModel.swift
//  WYASwiftMaterial
//
//  Created by 李世航 on 2019/7/5.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

import Foundation

class WYAAgentRingViewModel {
    public var list : [WYAAgentRingModel.WYAAgentRingListModel.WYAAgentRingListItemModel] = []

    public func fetchAgentRingCoverImage(handle:@escaping (String) -> Void) {
        BaseNetWork.requestData(.get, URLString: agentRingCoverImageUrl) { (result) in
            print(result)
            let dic = try! JSONDecoder().decode(WYACoverImageModel.self, from: result as! Data)
            print(dic)
            handle(dic.data?.cover_image ?? "")
        }

    }

    public func fetchAgentRingList(params:[String:Int], isHeaderRefresh:Bool, handle: @escaping () -> Void) {
        BaseNetWork.requestData(.get, URLString: agentRingList, paramenters: params) { (result) in
            var dic : WYAAgentRingModel? = nil

            do {
                dic = try JSONDecoder().decode(WYAAgentRingModel.self, from: result as! Data)
                if isHeaderRefresh == true {
                    self.list = (dic?.data?.list!)!
                } else {
                    self.list = self.list + (dic?.data?.list)!
                }

            } catch let err {
                print(err)
            }

            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let data = try! encoder.encode(dic)
            print(String(data: data, encoding: .utf8)!)
            dic?.data?.list![0].contentShow = true

            handle()
        }
    }
}
