//
//  SafeJsonObject.swift
//  YouTube
//
//  Created by 夏语诚 on 2017/7/5.
//  Copyright © 2017年 Banana Inc. All rights reserved.
//

import Foundation

class SafeJsonObject: NSObject {
    
    override func setValue(_ value: Any?, forKey key: String) {
        let uppercaseFirstCharacter = String(describing: key.characters.first!).uppercased()
        let range = NSRange(location: 0, length: 1)
        let selectorString = NSString(string: key).replacingCharacters(in: range, with: uppercaseFirstCharacter)
        
        let selector = NSSelectorFromString("set\(selectorString):")
        let responds = self.responds(to: selector)
        
        if !responds {
            return
        }
        
        super.setValue(value, forKey: key)
    }
}
