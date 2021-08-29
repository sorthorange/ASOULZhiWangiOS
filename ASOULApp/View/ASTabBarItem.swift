//

//
//  ASTabBarItem.swift
//  ASOULApp
//
//  Created by southorange on 2021/8/22.
//  
//
    

import UIKit

class ASTabBarItem: UIButton {
    
    var type: ASTabBarType = .checkDuplicate {
        didSet {
            itemTitleLabel.text = type.title
            itemImageView.image = UIImage(named: type.imageName)
        }
    }
    
    var isItemSelected: Bool = false {
        didSet {
            self.alpha = isItemSelected ? 1.0 : 0.5
        }
    }
    
    private lazy var itemTitleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 10)
        $0.textAlignment = .center
    }
    private lazy var itemImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
        setupConstraints()
    }
    
    func setupSubViews() {
        addSubview(itemTitleLabel)
        addSubview(itemImageView)
    }
    
    func setupConstraints() {
        itemTitleLabel.snp.remakeConstraints { make in
            make.centerX.equalTo(self)
            make.bottom.equalTo(self)
        }
        
        itemImageView.snp.remakeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(self)
            make.size.equalTo(CGSize(width: 35, height: 35))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
