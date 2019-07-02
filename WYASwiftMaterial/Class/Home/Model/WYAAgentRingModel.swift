//
//  WYAAgentRingModel.swift
//  WYASwiftMaterial
//
//  Created by 李世航 on 2019/6/20.
//  Copyright © 2019 WeiYiAn. All rights reserved.
//

import UIKit

class WYAAgentRingModel: BaseNetWork {

    public class func fetchAgentRingCoverImage() {
        WYAAgentRingModel.requestData(.get, URLString: agentRingCoverImageUrl) { (result) in
            print(result)
        }

    }
}
