//
//  SettingsCell.swift
//  YouTube
//
//  Created by 夏语诚 on 2017/7/1.
//  Copyright © 2017年 Banana Inc. All rights reserved.
//

import UIKit

class SettingsCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.accessoryType = .none
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView?.frame = CGRect(x: 15, y: 10, width: 30, height: 30)
        self.imageView?.contentMode = .scaleAspectFill
        var textLabelFrame = self.textLabel?.frame
        textLabelFrame?.origin.x -= 16
        textLabelFrame?.size.width += 16
        self.textLabel?.frame = textLabelFrame!
        self.textLabel?.font = UIFont.systemFont(ofSize: 13)
    }
}
