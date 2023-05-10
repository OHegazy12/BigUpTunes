//
//  TabBarViewController.swift
//  iOSDevProj
//
//  Created by Omar Hegazy on 4/26/23.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize view controllers and set titles
        let vc1 = HomeViewController()
        let vc2 = SearchViewController()
        let vc3 = LibraryViewController()
        vc1.title = "Browse"
        vc2.title = "Search"
        vc3.title = "Library"
        
        // Set large title display mode
        vc1.navigationItem.largeTitleDisplayMode = .always
        vc2.navigationItem.largeTitleDisplayMode = .always
        vc3.navigationItem.largeTitleDisplayMode = .always
        
        // Create navigation controllers
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)
        
        // Customize navigation bar appearance
        nav1.navigationBar.tintColor = .label
        nav2.navigationBar.tintColor = .label
        nav3.navigationBar.tintColor = .label
        nav1.navigationBar.prefersLargeTitles = true
        nav2.navigationBar.prefersLargeTitles = true
        nav3.navigationBar.prefersLargeTitles = true
        
        // Create tab bar items
        nav1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "Library", image: UIImage(systemName: "music.note.list"), tag: 3)
        
        // Set view controllers
        setViewControllers([nav1, nav2, nav3], animated: false)
        
        // Assign custom delegate to handle tab bar item selection
        self.delegate = self
    }
}

// Implement UITabBarControllerDelegate to handle tab bar item selection
extension TabBarViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        // Get the current and destination view controllers
        guard let fromView = selectedViewController?.view, let toView = viewController.view else {
            return false
        }
        
        // Check if the selected view controller is different from the current one
        if fromView != toView {
            // Add the destination view controller's view as a subview
            fromView.superview?.addSubview(toView)
            
            // Set the initial position of the destination view outside the screen
            toView.frame = CGRect(x: toView.frame.origin.x, y: toView.frame.size.height, width: toView.frame.size.width, height: toView.frame.size.height)
            
            // Perform the custom animation
            UIView.animate(withDuration: 0.3, animations: {
                // Slide the current view out of the screen
                fromView.frame = CGRect(x: fromView.frame.origin.x, y: fromView.frame.size.height, width: fromView.frame.size.width, height: fromView.frame.size.height)
                
                // Slide the destination view in from the bottom
                toView.frame = CGRect(x: toView.frame.origin.x, y: 0, width: toView.frame.size.width, height: toView.frame.size.height)
            }) { (finished) in
                // Remove the current view from superview after the animation is completed
                fromView.removeFromSuperview()
            }
        }
        
        return true
    }
}
