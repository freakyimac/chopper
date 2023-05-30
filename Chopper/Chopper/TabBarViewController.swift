//
//  TabBarViewController.swift
//  Chopper
//
//  Created by 김동현 on 2023/05/31.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Functions
    private func setupView() {
        tabBar.backgroundColor = .systemGray6
        tabBar.tintColor = .red
        let homeVC = FeedViewController()
        homeVC.title = "Feed"
        homeVC.tabBarItem.image = UIImage.init(systemName: "music.note.house.fill")
        let homeNav = UINavigationController(rootViewController: homeVC)
        setViewControllers([homeNav], animated: false)
    }
}
