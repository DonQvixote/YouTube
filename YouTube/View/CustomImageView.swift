//
//  CustomImageView.swift
//  YouTube
//
//  Created by 夏语诚 on 2017/7/1.
//  Copyright © 2017年 Banana Inc. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

class CustomImageView: UIImageView {
    
    var imageUrlString: String?
    
    func loadImageUsingUrlString(_ urlString: String) {
        imageUrlString = urlString
        let url = URL(string: urlString)
        self.image = nil
        if let imageFromCache = imageCache.object(forKey: (urlString as AnyObject) as! NSString) {
            self.image = imageFromCache
            return
        }
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            DispatchQueue.main.async {
                let imageToCache = UIImage(data: data!)
                if self.imageUrlString == urlString {
                    self.image = imageToCache
                }
                imageCache.setObject(imageToCache!, forKey: (urlString as AnyObject) as! NSString)
            }
        }).resume()
    }
}
