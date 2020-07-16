//
//  MaryTabBarSetting.swift
//  Pods-MaryTabBar_Example
//
//  Created by Asaf Baibekov on 11/01/2020.
//

import UIKit

// Here you can customize the tab bar to meet your neededs
public struct MaryTabBarSetting {
    
    public static var animationDurationTime: Double = 0.4
    
    public static var initialPosition: Int = 0
    
    public static var hideble: Bool = false
    public static var height: CGFloat = 56
    public static var shadowColor = UIColor.lightGray.cgColor
    public static var backgroundColor: UIColor = .white
    
    public static var sizeImage: CGFloat = 28
    public static var sizeSelectedImage: CGFloat = 28
    public static var imageTintColor: UIColor = .black
    public static var selectedImageTintColor: UIColor = .black
    
    public static var circleSize = CGSize(width: 56, height: 56)
    public static var circleTintColor: UIColor = .clear
    
    public static var titleColor: UIColor = .black
    public static var titleFont: UIFont = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular)
    public static var titleHidden: Bool = true
}
// todo:: tabBarIsHideble
// todo:: add animation between view controllers
// todo:: add another movement animation between tabbar items
