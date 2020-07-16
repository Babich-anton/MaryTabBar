//
//  MaryTabBar.swift
//  MaryTabBar
//
//  Created by Anton Babich on 14.07.2020.
//  Copyright © 2020 Anton Babich. All rights reserved.
//

import UIKit

// use this protocol to detect when a tab bar item is pressed
@available(iOS 9.3, *)
protocol MaryTabBarDelegate: AnyObject {
    
    func tabBar(_ tabBar: MaryTabBar, didSelectTabAt index: Int)

    func setDefaultTabBar(index: Int)
}

@available(iOS 9.3, *)
public class MaryTabBar: UIView {
    
   internal var viewControllers = [UIViewController]() {
        didSet {
            drawTabs()
            
            guard !viewControllers.isEmpty else {
                return
            }
            
            drawConstraint()
            
            if MaryTabBarSetting.hideble {
                showTabBar()
            }
            
            layoutIfNeeded()
            
            didSelectTab(index: MaryTabBarSetting.initialPosition)
        }
    }
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [])
        stackView.axis = .horizontal
        stackView.spacing = 0
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.clipsToBounds = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isHidden = MaryTabBarSetting.hideble
        
        return stackView
    }()
    
    private let innerCircleView: UIView = {
        let view = UIView()
        view.backgroundColor = MaryTabBarSetting.backgroundColor
        
        return view
    }()
    
    private let outerCircleView: UIView = {
        let view = UIView()
        view.backgroundColor = MaryTabBarSetting.circleTintColor
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let tabSelectedImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = MaryTabBarSetting.selectedImageTintColor
        
        return imageView
    }()
    
    weak var delegate: MaryTabBarDelegate?
    
    private var selectedIndex: Int = MaryTabBarSetting.initialPosition
    private var previousSelectedIndex = MaryTabBarSetting.initialPosition
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        dropShadow()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        dropShadow()
    }
    
    private func dropShadow() {
        backgroundColor = MaryTabBarSetting.backgroundColor
        layer.shadowColor = MaryTabBarSetting.shadowColor
        layer.shadowOpacity = 0.6
        layer.shadowOffset = CGSize(width: 0, height: -2)
        layer.shadowRadius = 3
    }
    
    private func drawTabs() {
        for vc in viewControllers {
            let barView = MaryTabBarItem(tabBarItem: vc.tabBarItem)
            barView.heightAnchor.constraint(equalToConstant: MaryTabBarSetting.height).isActive = true
            barView.translatesAutoresizingMaskIntoConstraints = false
            barView.isUserInteractionEnabled = false
            self.stackView.addArrangedSubview(barView)
        }
    }
    
    private func drawConstraint() {
        addSubview(stackView)
        addSubview(innerCircleView)
        
        innerCircleView.addSubview(outerCircleView)
        outerCircleView.addSubview(tabSelectedImageView)
        
        innerCircleView.frame.size = MaryTabBarSetting.circleSize
        innerCircleView.layer.cornerRadius = MaryTabBarSetting.circleSize.width / 2
        
        outerCircleView.layer.cornerRadius = (innerCircleView.frame.size.height - 10) / 2
        
        stackView.frame = self.bounds.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        
        var constraints = [
            outerCircleView.centerYAnchor.constraint(equalTo: self.innerCircleView.centerYAnchor),
            outerCircleView.centerXAnchor.constraint(equalTo: self.innerCircleView.centerXAnchor),
            outerCircleView.heightAnchor.constraint(equalToConstant: innerCircleView.frame.size.height - 10),
            outerCircleView.widthAnchor.constraint(equalToConstant: innerCircleView.frame.size.width - 10),
            tabSelectedImageView.centerYAnchor.constraint(equalTo: outerCircleView.centerYAnchor),
            tabSelectedImageView.centerXAnchor.constraint(equalTo: outerCircleView.centerXAnchor),
            tabSelectedImageView.heightAnchor.constraint(equalToConstant: MaryTabBarSetting.sizeSelectedImage),
            tabSelectedImageView.widthAnchor.constraint(equalToConstant: MaryTabBarSetting.sizeSelectedImage),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: self.topAnchor)
        ]
        
        if #available(iOS 11.0, *) {
            constraints.append(stackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor))
        } else {
            constraints.append(stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor))
        }
        
        NSLayoutConstraint.activate(constraints)
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        guard let touchArea = touches.first?.location(in: self).x else {
            return
        }
        
        let index = Int(floor(touchArea / tabWidth))
        didSelectTab(index: index)
    }
    
    private func didSelectTab(index: Int) {
        if index + 1 == selectedIndex {
            return
        }
        
        animateTitle(index: index)
 
        previousSelectedIndex = selectedIndex
        selectedIndex = index + 1
        
        delegate?.tabBar(self, didSelectTabAt: index)
        animateCircle(with: circlePath)
        animateImage()
        
        if let image = self.viewControllers[index].tabBarItem.selectedImage {
            self.tabSelectedImageView.image = image.withRenderingMode(.alwaysTemplate)
        } else {
            self.tabSelectedImageView.image = UIImage()
            print("You should insert selected image to all View Controllers")
        }
    }
    
    func update() {
        animateTitle(index: previousSelectedIndex)
        animateCircle(with: circlePath)
    }
}

@available(iOS 9.3, *)
private extension MaryTabBar {

    var tabWidth: CGFloat {
        return UIScreen.main.bounds.width / CGFloat(viewControllers.count)
    }

    var circlePath: CGPath {
        let startPointX = CGFloat(previousSelectedIndex) * CGFloat(tabWidth) - (tabWidth * 0.5)
        let endPointX = CGFloat(selectedIndex) * CGFloat(tabWidth) - (tabWidth * 0.5)
        let y = MaryTabBarSetting.height * 0.1
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: startPointX, y: y))
        path.addLine(to: CGPoint(x: endPointX, y: y))
        
        return path.cgPath
    }
}

@available(iOS 9.3, *)
private extension MaryTabBar {
    
    private func animateTitle(index: Int) {
        self.stackView.arrangedSubviews.enumerated().forEach {
            guard let tabView = $1 as? MaryTabBarItem else {
                return
            }
            
            ($0 == index ? tabView.animateTabSelected : tabView.animateTabDeSelect)()
        }
    }
    
    private func animateImage() {
        tabSelectedImageView.alpha = 0
        
        UIView.animate(withDuration: MaryTabBarSetting.animationDurationTime) { [weak self] in
            self?.tabSelectedImageView.alpha = 1
        }
    }
    
    private func animateCircle(with path: CGPath) {
        let caframeAnimation = CAKeyframeAnimation(keyPath: #keyPath(CALayer.position))
        caframeAnimation.path = path
        caframeAnimation.duration = MaryTabBarSetting.animationDurationTime
        caframeAnimation.fillMode = .both
        caframeAnimation.isRemovedOnCompletion = false
        
        innerCircleView.layer.add(caframeAnimation, forKey: "circleLayerAnimationKey")
    }
    
    private func showTabBar() {
        stackView.alpha = 0
        stackView.isHidden = false
        
        UIView.animate(withDuration: MaryTabBarSetting.animationDurationTime) { [weak self] in
            self?.stackView.alpha = 1
        }
    }
}
