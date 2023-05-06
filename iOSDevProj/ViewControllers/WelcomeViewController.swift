//
//  WelcomeViewController.swift
//  iOSDevProj
//
//  Created by Omar Hegazy on 4/25/23.
//

import UIKit

class WelcomeViewController: UIViewController {

    private let signInbutton: UIButton =
    {
       let button = UIButton()
       button.backgroundColor = .white
       button.setTitle("Sign In With Spotify", for: .normal)
       button.setTitleColor(.blue, for: .normal)
       return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Big Up Tunes"
        view.backgroundColor = .systemGreen
        view.addSubview(signInbutton)
        signInbutton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        signInbutton.frame = CGRect(x: 20, y: view.height - 50 - view.safeAreaInsets.bottom, width: view.width - 40, height: 50)
    }
    
    @objc func didTapSignIn()
    {
        let vc = AuthViewController()
        vc.completionHandler = { [weak self] success in
            DispatchQueue.main.async {
                self?.handleSignIn(success: success)
            }
        }
        vc.navigationItem.largeTitleDisplayMode = . never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func handleSignIn(success: Bool)
    {
        // Logs user in or yells at them for error
        guard success else {
            let alert = UIAlertController(title: "Error", message: "An error has occured while signing in.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true)
            return
        }
        
        let mainPageTabVC = TabBarViewController()
        mainPageTabVC.modalPresentationStyle = .fullScreen
        present(mainPageTabVC, animated: true)
        
//        let homePageVC = HomeController()
//        homePageVC.modalPresentationStyle = .fullScreen
//        present(homePageVC, animated: true)
    }
}
