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

// 标签栏种类
enum ASTabBarType : Int {
    /// 小作文查重
    case checkDuplicate = 0
    /// 小作文库
    case library
    /// 关于
    case about
    
    //标签栏文字内容
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
    // 标签栏图标
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
    // 标签栏
    private lazy var tabBarView: UIStackView = UIStackView()
    // 主视图
    private lazy var contentView: UIScrollView = UIScrollView()
    
    // 小作文查重
    private lazy var checkDuplicateViewController = ASCheckDuplicateViewController()
    // 小作文库
    private lazy var libraryViewController = ASLibraryViewController()
    // 关于
    private lazy var aboutViewController = ASAboutViewController()
    // 子控制器列表
    private lazy var tabBarChildViewControllers = [ASTabBarChildViewController]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
        setupConstraints()
        setupChildControllers()
        registerAction()
        switchToTab(.checkDuplicate)
    }
    
    // 初始化子视图
    func setupSubViews() {
        contentView.showsVerticalScrollIndicator = false
        contentView.showsHorizontalScrollIndicator = false
        contentView.bounces = false
        contentView.isPagingEnabled = true
        contentView.delegate = self
        view.addSubview(contentView)
        
        tabBarView.spacing = 10
        tabBarView.axis = .horizontal
        tabBarView.distribution = .fillEqually
        view.addSubview(tabBarView)
    }
    
    // 设置约束
    func setupConstraints() {
        tabBarView.snp.makeConstraints { make in
            make.left.right.equalTo(view)
            make.bottom.equalTo(view.snp.bottomMargin)
            make.height.equalTo(tabbarHeight)
        }
        contentView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin)
            make.left.right.equalTo(view)
            make.bottom.equalTo(tabBarView.snp.top)
        }
        contentView.layoutIfNeeded()
    }

    // 设置子控制器
    func setupChildControllers() {
        checkDuplicateViewController.childType = .checkDuplicate
        addASChild(checkDuplicateViewController)
        libraryViewController.childType = .library
        addASChild(libraryViewController)
        aboutViewController.childType = .about
        addASChild(aboutViewController)
    }
    
    // 添加子控制器，设置UI
    func addASChild(_ viewController: ASTabBarChildViewController) {
        tabBarView.addArrangedSubview(viewController.asTabBarItem)
        contentView.addSubview(viewController.view)
        contentView.contentSize = CGSize(width: UIScreen.main.bounds.size.width * CGFloat((tabBarChildViewControllers.count + 1)), height: contentView.frame.size.height)
        let lastViewController = tabBarChildViewControllers.last
        viewController.view.snp.makeConstraints { make in
            make.top.size.equalTo(contentView)
            if lastViewController == nil {
                make.left.equalTo(contentView)
            } else {
                make.left.equalTo(lastViewController!.view.snp.right)
            }
        }
        tabBarChildViewControllers.append(viewController)
    }
    
    // 切换子控制器
    func switchToTab(_ type: ASTabBarType) {
        contentView.setContentOffset(CGPoint(x: contentView.frame.size.width * CGFloat(type.rawValue), y: contentView.contentOffset.y), animated: true)
    }
    
    // 刷新底部TabBar
    func refreshTabBarItems(_ type: ASTabBarType) {
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

//MARK: UIScrollViewDelegate
extension ASTabBarViewController: UIScrollViewDelegate {
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let type = ASTabBarType(rawValue: Int(scrollView.contentOffset.x / scrollView.frame.size.width)) ?? .checkDuplicate
        refreshTabBarItems(type)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let type = ASTabBarType(rawValue: Int(scrollView.contentOffset.x / scrollView.frame.size.width)) ?? .checkDuplicate
        refreshTabBarItems(type)
    }
}

