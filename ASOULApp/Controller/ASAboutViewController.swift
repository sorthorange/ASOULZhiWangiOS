//

//
//  ASAboutViewController.swift
//  ASOULApp
//
//  Created by 霍橙 on 2021/8/22.
//  
//
    

import UIKit

class ASAboutViewController: ASTabBarChildViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        asTabBarItem.title = "关于"
        asTabBarItem.image = UIImage(named: "about")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blue
    }

}
