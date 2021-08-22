//
//
//  ViewController.swift
//  ASOULApp
//
//  Created by southorange on 2021/8/22.
//  
//
    

import UIKit

enum ASTabBarType : Int {
    case checkDuplicate = 0
    case library
    case about
}

class ASTabBarViewController: UITabBarController {
    
    private lazy var checkDuplicateViewController = ASCheckDuplicateViewController()
    private lazy var libraryViewController = ASLibraryViewController()
    private lazy var aboutViewController = ASAboutViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupChildControllers()
    }

    func setupChildControllers() {
        addChild(checkDuplicateViewController)
        addChild(libraryViewController)
        addChild(aboutViewController)
    }

}

