//
//  HomeController.swift
//  YouTube
//
//  Created by 夏语诚 on 2017/6/29.
//  Copyright © 2017年 Banana Inc. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var videos: [Video]?
    
    let menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    lazy var settingsLauncher: SettingsLauncher = {
        let launcher = SettingsLauncher()
        launcher.homeController = self
        return launcher
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchVideos()
        
        navigationItem.title = "Home"
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        navigationController?.navigationBar.isTranslucent = false
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "Home"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "VideoCell")
        
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        
        setupMenuBar()
        setupNavBarButtons()
    }
    
    func fetchVideos() {
        let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                self.videos = [Video]()
                for dictionary in json as! [[String: AnyObject]] {
                    let video = Video()
                    video.title = dictionary["title"] as? String
                    video.thumbnailImageURL = dictionary["thumbnail_image_name"] as? String
                    video.numberOfViews = dictionary["number_of_views"] as? NSNumber
                    
                    let channel = Channel()
                    let channelDictionary = dictionary["channel"] as? [String: AnyObject]
                    channel.name = channelDictionary?["name"] as? String
                    channel.profileImageURL = channelDictionary?["profile_image_name"] as? String
                    
                    video.channel = channel
                    self.videos?.append(video)
                }
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
            } catch let jsonError {
                print(jsonError)
            }
        }.resume()
    }
    
    func setupNavBarButtons() {
        let searchImage = UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal)
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        
        let moreImage = UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal)
        let moreBarButtonItem = UIBarButtonItem(image: moreImage, style: .plain, target: self, action: #selector(handleMore))
        
        navigationItem.rightBarButtonItems = [moreBarButtonItem, searchBarButtonItem]
    }
    
    func handleMore() {
        settingsLauncher.showSettings()
    }
    
    func handleSearch() {
        print("search")
    }
    
    func showSettingsController(_ title: String?) {
        let dummySettingsController = UIViewController()
        dummySettingsController.navigationItem.title = title
        dummySettingsController.view.backgroundColor = UIColor.white
        navigationController?.pushViewController(dummySettingsController, animated: true)
    }
    
    private func setupMenuBar() {
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: menuBar)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoCell", for: indexPath) as! VideoCell
        cell.video = videos?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width - 16 - 16) * 9 / 16 + 16 + 44 + 44 + 8
        return CGSize(width: view.frame.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

