//

//
//  ASTabBarItem.swift
//  ASOULApp
//
//  Created by 霍橙 on 2021/8/22.
//  
//
    

import UIKit

class ASTabBarItem: UIButton {

    var title: String = "" {
        didSet {
            itemTitleLabel.text = title
        }
    }
    var image: UIImage? {
        didSet {
            itemImageView.image = image
        }
    }
    
    private lazy var itemTitleLabel = UILabel()
    private lazy var itemImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
        setupConstraints()
    }
    
    func setupSubViews() {
        itemTitleLabel.font = .systemFont(ofSize: 10)
        itemTitleLabel.textAlignment = .center
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
