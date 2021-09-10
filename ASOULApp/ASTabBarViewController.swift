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
    private lazy var tabBarLineView = UIView().then { view in
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    }
    // 标签栏
    private lazy var tabBarView: UIStackView = UIStackView().then {
        $0.spacing = 10
        $0.axis = .horizontal
        $0.distribution = .fillEqually
    }
    // 主视图
    private lazy var contentView: UIScrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        $0.bounces = false
        $0.isPagingEnabled = true
        $0.delegate = self
    }
    
    // 小作文查重
    
    private lazy var checkDuplicateViewController = ASCheckDuplicateViewController().then { [weak self] controller in
        controller.childType = .checkDuplicate
        controller.asTabBarController = self
    }
    // 小作文库
    private lazy var libraryViewController = ASLibraryViewController().then { [weak self] controller in
        controller.childType = .library
        controller.asTabBarController = self
    }
    // 关于
    private lazy var aboutViewController = ASAboutViewController().then { [weak self] controller in
        controller.childType = .about
        controller.asTabBarController = self
    }
    // 子控制器列表
    private lazy var tabBarChildViewControllers: [ASTabBarChildViewController] = [checkDuplicateViewController, libraryViewController, aboutViewController]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
        setupConstraints()
        setupChildControllers()
        registerAction()
        switchToTab(.checkDuplicate)
        refreshTabBarItems(.checkDuplicate)
    }
    
    // 初始化子视图
    func setupSubViews() {
        view.insertSubview(contentView, at: 0)
        view.addSubview(tabBarView)
        tabBarView.addSubview(tabBarLineView)
    }
    
    // 初始化约束
    func setupConstraints() {
        tabBarView.snp.makeConstraints { make in
            make.left.right.equalTo(view)
            make.bottom.equalTo(view.snp.bottomMargin)
            make.height.equalTo(tabbarHeight)
        }
        tabBarLineView.snp.makeConstraints { make in
            make.left.right.top.equalTo(tabBarView)
            make.height.equalTo(0.5)
        }
        contentView.snp.makeConstraints { make in
            make.top.equalTo(view).offset(navigationController?.navigationBar.frame.maxY ?? 0)
            make.left.right.equalTo(view)
            make.bottom.equalTo(tabBarView.snp.top)
        }
        contentView.layoutIfNeeded()
    }

    // 设置子控制器
    func setupChildControllers() {
        for i in 0..<tabBarChildViewControllers.count {
            let viewController = tabBarChildViewControllers[i]
            tabBarView.addArrangedSubview(viewController.asTabBarItem)
            contentView.addSubview(viewController.view)
            viewController.view.snp.makeConstraints { make in
                make.top.bottom.equalTo(contentView)
                make.bottom.equalTo(tabBarView.snp.top)
                make.width.equalTo(view)
                if i == 0 {
                    make.left.equalTo(contentView)
                } else {
                    make.left.equalTo(tabBarChildViewControllers[i - 1].view.snp.right)
                }
                make.right.lessThanOrEqualTo(contentView)
            }
        }
    }
    
    // 切换子控制器
    func switchToTab(_ type: ASTabBarType) {
        contentView.setContentOffset(CGPoint(x: contentView.frame.size.width * CGFloat(type.rawValue), y: contentView.contentOffset.y), animated: true)
        title = type.title
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
        title = type.title
        refreshTabBarItems(type)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let type = ASTabBarType(rawValue: Int(scrollView.contentOffset.x / scrollView.frame.size.width)) ?? .checkDuplicate
        title = type.title
        refreshTabBarItems(type)
    }
}

