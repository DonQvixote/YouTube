//
//  TrendingCell.swift
//  YouTube
//
//  Created by 夏语诚 on 2017/7/5.
//  Copyright © 2017年 Banana Inc. All rights reserved.
//

import UIKit

class TrendingCell: FeedCell {

    override func fetchVideos() {
        APIService.shared.fetchTrendingFeed { (videos) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }

}
