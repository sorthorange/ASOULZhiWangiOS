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
}

class ASTabBarViewController: UIViewController {
    
    let tabbarHeight: Float = 49
    
    private lazy var tabBarView: UIStackView = UIStackView()
    
    private lazy var checkDuplicateViewController = ASCheckDuplicateViewController()
    private lazy var libraryViewController = ASLibraryViewController()
    private lazy var aboutViewController = ASAboutViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
        setupChildControllers()
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
        addASChild(checkDuplicateViewController)
        addASChild(libraryViewController)
        addASChild(aboutViewController)
    }
    
    func addASChild(_ viewController: ASTabBarChildViewController) {
        tabBarView.addArrangedSubview(viewController.asTabBarItem)
    }
    
    

}

