//
//  ViewController.swift
//  MaryTabBar
//
//  Created by Anton Babich on 14.07.2020.
//  Copyright © 2020 Anton Babich. All rights reserved.
//

import UIKit

class ViewController: MaryTabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        let recentStoryboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "recent")
        let messageStoryboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "message")
        let addStoryboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "add")
        let notificationStoryboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "notification")
        let userStoryboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "user")
        
        recentStoryboard.tabBarItem = UITabBarItem(title: "Recent", image: UIImage(named: "b_recent"), selectedImage: UIImage(named: "b_recent_selected"))
        messageStoryboard.tabBarItem = UITabBarItem(title: "Message", image: UIImage(named: "b_message"), selectedImage: UIImage(named: "b_message_selected"))
        addStoryboard.tabBarItem = UITabBarItem(title: "Add", image: UIImage(named: "b_add"), selectedImage: UIImage(named: "b_add_selected"))
        notificationStoryboard.tabBarItem = UITabBarItem(title: "Notification", image: UIImage(named: "b_notification"), selectedImage: UIImage(named: "b_notification_selected"))
        userStoryboard.tabBarItem = UITabBarItem(title: "User", image: UIImage(named: "b_user"), selectedImage: UIImage(named: "b_user_selected"))
           
        viewControllers = [recentStoryboard, messageStoryboard, addStoryboard, notificationStoryboard, userStoryboard]
    }
}

extension ViewController: MaryTabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: MaryTabBarController, didSelect viewController: UIViewController) {
//        print(viewController.tabBarItem.title ?? "")
    }
}
