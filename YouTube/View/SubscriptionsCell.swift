//
//  SubscriptionsCell.swift
//  YouTube
//
//  Created by 夏语诚 on 2017/7/5.
//  Copyright © 2017年 Banana Inc. All rights reserved.
//

import UIKit

class SubscriptionsCell: FeedCell {

    override func fetchVideos() {
        APIService.shared.fetchSubscriptionsFeed { (videos) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }

}
