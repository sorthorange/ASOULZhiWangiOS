//
//
//  ViewController.swift
//  ASOULApp
//
//  Created by southorange on 2021/8/22.
//  
//
    

import UIKit
import SnapKit

enum ASTabBarType : Int {
    case checkDuplicate = 0
    case library
    case about
    
    var title: String {
        switch self {
        case .checkDuplicate:
            return "小作文查重"
        case .library:
            return "小作文库"
        case .about:
            return "关于"
        }
    }
    var imageName: String {
        switch self {
        case .checkDuplicate:
            return "checkDuplicate"
        case .library:
            return "library"
        case .about:
            return "about"
        }
    }
}

class ASTabBarViewController: UIViewController {
    
    let tabbarHeight: Float = 49
    
    private lazy var tabBarView: UIStackView = UIStackView()
    
    private lazy var checkDuplicateViewController = ASCheckDuplicateViewController()
    private lazy var libraryViewController = ASLibraryViewController()
    private lazy var aboutViewController = ASAboutViewController()
    private lazy var tabBarChildViewControllers = [ASTabBarChildViewController]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
        setupChildControllers()
        registerAction()
        switchToTab(.checkDuplicate)
    }
    
    func setupSubViews() {
        tabBarView.spacing = 10
        tabBarView.axis = .horizontal
        tabBarView.distribution = .fillEqually
        view.addSubview(tabBarView)
        tabBarView.snp.makeConstraints { make in
            make.left.right.equalTo(view)
            make.bottom.equalTo(view.snp.bottomMargin)
            make.height.equalTo(tabbarHeight)
        }
    }

    func setupChildControllers() {
        checkDuplicateViewController.childType = .checkDuplicate
        addASChild(checkDuplicateViewController)
        libraryViewController.childType = .library
        addASChild(libraryViewController)
        aboutViewController.childType = .about
        addASChild(aboutViewController)
    }
    
    func addASChild(_ viewController: ASTabBarChildViewController) {
        tabBarChildViewControllers.append(viewController)
        tabBarView.addArrangedSubview(viewController.asTabBarItem)
    }
    
    func switchToTab(_ type: ASTabBarType) {
        for viewController in tabBarChildViewControllers {
            if viewController.childType == type {
                viewController.asTabBarItem.isItemSelected = true
            } else {
                viewController.asTabBarItem.isItemSelected = false
            }
        }
    }

}

//MARK: action
extension ASTabBarViewController {
    func registerAction() {
        for viewController in tabBarChildViewControllers {
            viewController.asTabBarItem.addTarget(self, action: #selector(clickTabBarItem(_:)), for: .touchUpInside)
        }
    }
    
    @objc func clickTabBarItem(_ tabBarItem: ASTabBarItem) {
        switchToTab(tabBarItem.type)
    }
}

