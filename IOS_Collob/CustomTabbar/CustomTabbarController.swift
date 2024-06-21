//
//  CustomTabbarController.swift
//  IOS_Collob
//
//  Created by Webcodegenie on 20/06/24.
//

import UIKit

class CustomTabbarController: UITabBarController {
    
    var CenterBtn : UIButton = {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        btn.addTarget(self, action: #selector(menuButtonAction), for: .touchUpInside)
        btn.setTitle("", for: .normal)
        btn.layer.cornerRadius = 30
        btn.tintColor = .white
        btn.backgroundColor = .black
        btn.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        return btn
    }()
    override func viewDidLoad() {
            super.viewDidLoad()

        setTabbarItemsController()
//        self.tabBar.addSubview(CenterBtn)
        CenterBtn.frame = CGRect(x: Int(self.tabBar.frame.width)/2 - 30, y: 5, width: 60, height: 60)
        setItemsConstraints()
        
        }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
       
    }
    override func viewWillTransition(to size: CGSize, with coordinator: any UIViewControllerTransitionCoordinator) {
        CenterBtn.frame = CGRect(x: Int(size.width)/2 - 30, y: 5, width: 60, height: 60)
        setItemsConstraints()
    }


        // MARK: - Actions

        @objc private func menuButtonAction(sender: UIButton) {
            selectedIndex = 2
        }

    func setTabbarItemsController(){
        let controller1 = UIViewController()
//        let controller1 = UIStoryboard(name: "HomeStoryboard", bundle: nibBundle).instantiateViewController(identifier: "HomeViewController") as! HomeViewController
            controller1.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "house"), tag: 1)
        controller1.tabBarItem.imageInsets = UIEdgeInsets(top: 26, left: 0, bottom: -6, right: 0)
            let nav1 = UINavigationController(rootViewController: controller1)

            let controller2 = UIViewController()
            
            let nav2 = UINavigationController(rootViewController: controller2)
            nav2.title = ""

            let controller3 = UIViewController()
//            let controller3 = UIStoryboard(name: "UserProfile", bundle: nibBundle).instantiateViewController(identifier: "UserProfileVC") as! UserProfileVC
            controller3.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "person"), tag: 3)
        controller3.tabBarItem.imageInsets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
            let nav3 = UINavigationController(rootViewController: controller3)
            viewControllers = [nav1, nav3]
    }
    func setItemsConstraints(){
        let buttons = tabBar.subviews.filter { String(describing: type(of: $0)) == "UITabBarButton" }
        buttons.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.centerYAnchor.constraint(equalTo: self.tabBar.centerYAnchor,
                                            constant: ((self.tabBar.window?.safeAreaInsets.bottom ?? 0) * 0.01) ),
                $0.heightAnchor.constraint(equalToConstant: $0.frame.height),
                $0.widthAnchor.constraint(equalToConstant: $0.frame.width),
                $0.leadingAnchor.constraint(equalTo: self.tabBar.leadingAnchor, constant: $0.frame.minX)
            ])
            
        }
    }

}
