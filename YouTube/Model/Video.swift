//
//  Video.swift
//  YouTube
//
//  Created by 夏语诚 on 2017/6/29.
//  Copyright © 2017年 Banana Inc. All rights reserved.
//

import UIKit

class Video: NSObject {
    var thumbnailImageURL: String?
    var title: String?
    var numberOfViews: NSNumber?
    var uploadDate: Date?
    
    var channel: Channel?
}
