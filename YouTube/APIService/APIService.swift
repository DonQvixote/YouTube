//
//  APIService.swift
//  YouTube
//
//  Created by 夏语诚 on 2017/7/5.
//  Copyright © 2017年 Banana Inc. All rights reserved.
//

import UIKit

class APIService: NSObject {
    static let shared = APIService()
    
    let baseUrl = "https://s3-us-west-2.amazonaws.com/youtubeassets"
    
    func fetchVideos(_ completion: @escaping ([Video]) -> ()) {
        fetchFeedForUrlString("\(baseUrl)/home_num_likes.json", completion: completion)
    }
    
    func fetchTrendingFeed(_ completion: @escaping ([Video]) -> ()) {
        fetchFeedForUrlString("\(baseUrl)/trending.json", completion: completion)
    }
    
    func fetchSubscriptionsFeed(_ completion: @escaping ([Video]) -> ()) {
        fetchFeedForUrlString("\(baseUrl)/subscriptions.json", completion: completion)
    }
    
    func fetchFeedForUrlString(_ urlString: String, completion: @escaping ([Video]) -> ()) {
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            do {
                if let unwrappedData = data,  let jsonDictionaries = try JSONSerialization.jsonObject(with: unwrappedData, options: .mutableContainers) as? [[String: AnyObject]] {
//                    var videos = [Video]()
//                    for dictionary in jsonDictionaries {
//                        let video = Video(dictionary: dictionary)
//                        
//                        videos.append(video)
//                    }
                    let videos = jsonDictionaries.map({
                        return Video(dictionary: $0)
                    })
                    DispatchQueue.main.async {
                        completion(videos)
                    }
                }
            } catch let jsonError {
                print(jsonError)
            }
        }.resume()
    }
    
//    func fetchFeedForUrlString(_ urlString: String, completion: @escaping ([Video]) -> ()) {
//        let url = URL(string: urlString)
//        URLSession.shared.dataTask(with: url!) { (data, response, error) in
//            if let error = error {
//                print(error)
//                return
//            }
//            do {
//                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
//                var videos = [Video]()
//                for dictionary in json as! [[String: AnyObject]] {
//                    let video = Video(dictionary: dictionary)
//                    video.setValuesForKeys(dictionary)
//                    video.title = dictionary["title"] as? String
//                    video.thumbnailImageURL = dictionary["thumbnail_image_name"] as? String
//                    video.numberOfViews = dictionary["number_of_views"] as? NSNumber
//                    
//                    let channel = Channel()
//                    let channelDictionary = dictionary["channel"] as! [String: AnyObject]
//                    channel.setValuesForKeys(channelDictionary)
//                    channel.name = channelDictionary?["name"] as? String
//                    channel.profileImageURL = channelDictionary?["profile_image_name"] as? String
//                    
//                    video.channel = channel
//                    videos.append(video)
//                }
//                DispatchQueue.main.async {
//                    completion(videos)
//                }
//            } catch let jsonError {
//                print(jsonError)
//            }
//            }.resume()
//    }
}
