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

    var childType: ASTabBarType = .checkDuplicate {
        didSet {
            asTabBarItem.type = childType
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // 初始化子视图
    func setupSubViews() {
        
    }
    
    // 设置约束
    func setupConstraints() {
        
    }

}
