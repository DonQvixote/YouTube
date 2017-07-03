//
//  SettingsLauncher.swift
//  YouTube
//
//  Created by 夏语诚 on 2017/7/1.
//  Copyright © 2017年 Banana Inc. All rights reserved.
//

import UIKit

class SettingsLauncher: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    let homeMaskView = UIView()
    let settingsTableView: UITableView = {
        let tv = UITableView(frame: .zero, style: UITableViewStyle.plain)
        tv.separatorStyle = .none
        tv.showsVerticalScrollIndicator = false
        return tv
    }()

    let settingsOptions = ["Settings", "Terms & privacy policy", "Send Feedback", "Help", "Switch Account", "Cancel"]
    let settingsImages = ["settings", "privacy", "feedback", "help", "switch_account", "cancel"]
    
    var homeController: HomeController?
    
    override init() {
        super.init()
        
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        settingsTableView.register(SettingsCell.self, forCellReuseIdentifier: "settingsCell")
    }
    
    func showSettings() {
        if let window = UIApplication.shared.keyWindow {
            homeMaskView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            homeMaskView.frame = window.frame
            homeMaskView.alpha = 0
            homeMaskView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissMaskView)))
            window.addSubview(homeMaskView)
            
            let settingsTableViewHeight = 50 * CGFloat(settingsOptions.count)
            settingsTableView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: settingsTableViewHeight)
            window.addSubview(settingsTableView)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.homeMaskView.alpha = 1
                self.settingsTableView.frame = CGRect(x: 0, y: window.frame.height - settingsTableViewHeight, width: self.settingsTableView.frame.width, height: self.settingsTableView.frame.height)
            }, completion: nil)
        }
    }
    
    func dismissMaskView() {
        UIView.animate(withDuration: 0.5) {
            self.homeMaskView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.settingsTableView.frame = CGRect(x: 0, y: window.frame.height, width: self.settingsTableView.frame.width, height: self.settingsTableView.frame.height)
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = settingsTableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath) as! SettingsCell
        cell.imageView?.image = UIImage(named: settingsImages[indexPath.item])
        cell.textLabel?.text = settingsOptions[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        settingsTableView.deselectRow(at: indexPath, animated: true)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.homeMaskView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.settingsTableView.frame = CGRect(x: 0, y: window.frame.height, width: self.settingsTableView.frame.width, height: self.settingsTableView.frame.height)
            }
        }) { (completed) in
            if completed {
                if indexPath.item != self.settingsOptions.count - 1 {
                    self.homeController?.showSettingsController((self.settingsTableView.cellForRow(at: indexPath)?.textLabel?.text))
                }
            }
        }
    }
}
