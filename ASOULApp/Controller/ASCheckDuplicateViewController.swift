//

//
//  ASCheckDuplicateViewController.swift
//  ASOULApp
//
//  Created by 霍橙 on 2021/8/22.
//  
//
    

import UIKit

class ASCheckDuplicateViewController: ASTabBarChildViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        asTabBarItem.title = "小作文查重"
        asTabBarItem.image = UIImage(named: "checkDuplicate")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.red
    }

}
