//
//  BaseCell.swift
//  YouTube
//
//  Created by 夏语诚 on 2017/6/29.
//  Copyright © 2017年 Banana Inc. All rights reserved.
//

import UIKit

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
    }
}
