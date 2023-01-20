//
//  TabBarController.swift
//  EldenRing
//
//  Created by Kirill Karpovich on 16.01.23.
//

import UIKit

class TabBarController: UITabBarController {
    
    private let roundLayer = CAShapeLayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        generateTabBar()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setTabBarApperance()
        print("viewWillLayoutSubviews")
    }
    
    private func generateTabBar() {
        let favVC = FavoriteViewController()
        let vc = ViewController()
        
        vc.favoritesDelegate = favVC
        
        viewControllers = [
            generateVC(
                viewController: UINavigationController(rootViewController: vc),
                title: "Home",
                image: UIImage(systemName: "house.fill")),
            generateVC(
                viewController: favVC,
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
        if tabBar.layer.sublayers?.contains(roundLayer) == true  {
            roundLayer.removeFromSuperlayer()
        }
        
        let positionOnX:CGFloat = 16
        let positionOnY:CGFloat = 14
        let width = tabBar.bounds.width - positionOnX * 2
        let height = (tabBar.bounds.height + positionOnY * 2) - (getBottomSafeArea())
        
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
        tabBar.itemPositioning = .centered
        
        roundLayer.fillColor = UIColor.black.withAlphaComponent(0.2).cgColor
        tabBar.tintColor = #colorLiteral(red: 0, green: 0.9119531512, blue: 1, alpha: 1)
        tabBar.unselectedItemTintColor = UIColor.gray
    }
    
    private func getBottomSafeArea() -> CGFloat {
        UIApplication
            .shared
            .connectedScenes
            .compactMap { ($0 as? UIWindowScene)?.keyWindow }
            .first?
            .safeAreaInsets
            .bottom ?? .zero
    }

}
