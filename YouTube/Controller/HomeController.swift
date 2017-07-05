//
//  HomeController.swift
//  YouTube
//
//  Created by 夏语诚 on 2017/6/29.
//  Copyright © 2017年 Banana Inc. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.homeController = self
        return mb
    }()
    
    lazy var settingsLauncher: SettingsLauncher = {
        let launcher = SettingsLauncher()
        launcher.homeController = self
        return launcher
    }()
    
    let titles = ["Home", "Trending", "Subscriptions", "Account"]
    
    enum IdentifierString: String {
        case Home = "FeedCell"
        case Trending = "TrendingCell"
        case Subscriptions = "SubscriptionsCell"
        case Account = "AccountCell"
    }
    
    let identifierString: [IdentifierString] = [.Home, .Trending, .Subscriptions, .Account]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        navigationItem.title = "Home"
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.hidesBarsOnSwipe = true
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "  Home"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        
        setupColletionView()
        setupMenuBar()
        setupNavBarButtons()
    }
    
    func setupColletionView() {
        
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: "FeedCell")
        collectionView?.register(TrendingCell.self, forCellWithReuseIdentifier: "TrendingCell")
        collectionView?.register(SubscriptionsCell.self, forCellWithReuseIdentifier: "SubscriptionsCell")
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "AccountCell")
        
        collectionView?.backgroundColor = UIColor.white
//        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "VideoCell")
        
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        
        collectionView?.isPagingEnabled = true
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
    
    func scrolleToMenuIndex(_ menuIndex: Int) {
        let indexPath = IndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition(), animated: true)
    }
    
    func setTitleForIndex(_ index: Int) {
        if let titleLabel = navigationItem.titleView as? UILabel {
            titleLabel.text = "  " + titles[index]
        }
    }
    
    func showSettingsController(_ title: String?) {
        let dummySettingsController = UIViewController()
        dummySettingsController.navigationItem.title = title
        dummySettingsController.view.backgroundColor = UIColor.white
        navigationController?.pushViewController(dummySettingsController, animated: true)
    }
    
    private func setupMenuBar() {
        
        let redView = UIView()
        redView.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        view.addSubview(redView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: redView)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: redView)
        
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: menuBar)
        
        menuBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuBar.imageNames.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let identifier = identifierString[indexPath.item].rawValue
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 50)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 4
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = Int(targetContentOffset.pointee.x / view.frame.width)
        let indexPath = IndexPath(item: index, section: 0)
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionViewScrollPosition())
        
        setTitleForIndex(index)
    }
}

