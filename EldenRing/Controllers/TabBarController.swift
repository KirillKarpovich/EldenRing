//
//  TabBarController.swift
//  EldenRing
//
//  Created by Kirill Karpovich on 16.01.23.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
        setTabBarApperance()
        
    }
    
    private func generateTabBar() {
        viewControllers = [
            generateVC(
                viewController: UINavigationController(rootViewController: ViewController()),
                title: "Home",
                image: UIImage(systemName: "house.fill")),
            generateVC(
                viewController: FavoriteViewController(),
                title: "Favs",
                image: UIImage(systemName: "heart.fill")),
        ]
    }
    
    private func generateVC(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }
    private func setTabBarApperance() {
        
        let positionOnX:CGFloat = 10
        let positionOnY:CGFloat = 14
        let width = tabBar.bounds.width - positionOnX * 2
        let height = tabBar.bounds.height + positionOnY * 2
        
        let roundLayer = CAShapeLayer()
        
        let bezierPath = UIBezierPath(
            roundedRect: CGRect(
            x: positionOnX,
            y: tabBar.bounds.minY - positionOnY,
            width: width,
            height: height),
        cornerRadius: height / 2
        )
       
        roundLayer.path = bezierPath.cgPath
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        
        tabBar.itemWidth = width / 5
        tabBar.itemPositioning = .automatic
        
        roundLayer.fillColor = UIColor.black.cgColor
        tabBar.tintColor = UIColor.magenta
        tabBar.unselectedItemTintColor = UIColor.gray
    }
}
