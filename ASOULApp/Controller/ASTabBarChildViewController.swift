//

//
//  ASTabBarChildViewController.swift
//  ASOULApp
//
//  Created by southorange on 2021/8/22.
//  
//
    

import UIKit

class ASTabBarChildViewController: UIViewController {
    
    var asTabBarItem = ASTabBarItem()
    
    weak var asTabBarController: UIViewController?

    var childType: ASTabBarType = .checkDuplicate {
        didSet {
            asTabBarItem.type = childType
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /// 初始化子视图
    func setupSubViews() {
        
    }
    
    /// 初始化约束
    func setupConstraints() {
        
    }

}
