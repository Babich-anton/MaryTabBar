//
//  MaryTabBarItem.swift
//  MaryTabBar
//
//  Created by Anton Babich on 14.07.2020.
//  Copyright © 2020 Anton Babich. All rights reserved.
//

import UIKit

@available(iOS 9.3, *)
class MaryTabBarItem: UIView {
    
    let image: UIImage
    let title: String
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = self.title
        label.font = MaryTabBarSetting.titleFont
        label.textColor = MaryTabBarSetting.titleColor
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = MaryTabBarSetting.titleHidden
        
        return label
    }()
    
    private lazy var tabImageView: UIImageView = {
        let imageView = UIImageView(image: image.withRenderingMode(.alwaysTemplate))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = MaryTabBarSetting.imageTintColor
        
        return imageView
    }()
    
    init(tabBarItem item: UITabBarItem) {
        if let selectedImage = item.image {
            self.image = selectedImage
        } else {
            self.image = UIImage()
        }
        
        self.title = item.title ?? ""
        super.init(frame: .zero)
        drawConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func drawConstraints() {
        self.addSubview(titleLabel)
        self.addSubview(tabImageView)
        
        NSLayoutConstraint.activate([
            tabImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            tabImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            tabImageView.heightAnchor.constraint(equalToConstant: MaryTabBarSetting.sizeImage),
            tabImageView.widthAnchor.constraint(equalToConstant: MaryTabBarSetting.sizeImage),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: MaryTabBarSetting.height),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 26)
        ])
    }
    
    internal func animateTabSelected() {
        tabImageView.alpha = 1
        titleLabel.alpha = 0
        
        UIView.animate(withDuration: MaryTabBarSetting.animationDurationTime) { [weak self] in
            guard let `self` = self else {
                return
            }
            
            self.titleLabel.alpha = 1
            self.titleLabel.frame.origin.y = MaryTabBarSetting.height / 1.8
            self.tabImageView.frame.origin.y = -5
            self.tabImageView.alpha = 0
        }
    }
    
    internal func animateTabDeSelect() {
        tabImageView.alpha = 1
        
        UIView.animate(withDuration: MaryTabBarSetting.animationDurationTime) { [weak self] in
            guard let `self` = self else {
                return
            }
            
            self.titleLabel.frame.origin.y = MaryTabBarSetting.height
            self.tabImageView.frame.origin.y = (MaryTabBarSetting.height / 2) - CGFloat(MaryTabBarSetting.sizeImage / 2)
            self.tabImageView.alpha = 1
        }
    }
}
