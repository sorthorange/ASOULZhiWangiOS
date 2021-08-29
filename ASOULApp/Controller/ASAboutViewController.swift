//

//
//  ASAboutViewController.swift
//  ASOULApp
//
//  Created by southorange on 2021/8/22.
//  
//
    

import UIKit

class ASAboutViewController: ASTabBarChildViewController {
    
    private lazy var contentView = UIScrollView().then { scrollView in
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
    }
    
    private lazy var asoulInfoCardView = UIView().then { view in
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.8).cgColor
        view.layer.shadowRadius = 2
        view.layer.shadowOffset = CGSize(width: 1, height: 1)
        view.layer.shadowOpacity = 1
        
        view.layer.cornerRadius = 5
    }
    private lazy var asoulTeamImgView = UIImageView().then { imageView in
        imageView.image = UIImage(named: "asoul_team")
        imageView.contentMode = .scaleAspectFill
    }
    private lazy var asoulInfoTitleLabel = UILabel().then { label in
        label.text = "ASoul简介"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .left
    }
    private lazy var asoulInfoContentLabel = UILabel().then { label in
        label.text = "A-SOUL是乐华娱乐年度最新企划中打造的虚拟偶像女团，成员由向晚(Ava)、贝拉(Bella)、珈乐(Carol)、嘉然(Diana)、乃琳(Eileen)五人组成，于2020年11月以”乐华娱乐首个虚拟偶像团体“名义出道"
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 0
    }
    
    private lazy var appInfoCardView = UIView().then { view in
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.8).cgColor
        view.layer.shadowRadius = 2
        view.layer.shadowOffset = CGSize(width: 1, height: 1)
        view.layer.shadowOpacity = 1
        
        view.layer.cornerRadius = 5
    }
    private lazy var appInfoTitleLabel = UILabel().then { label in
        label.text = "本APP地址"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .left
    }
    private lazy var appInfoContentLabel = UILabel().then { label in
        label.text = "项目地址:\nhttps://"
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 0
    }
    private lazy var thankTitleLabel = UILabel().then { label in
        label.text = "非常感谢:"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .left
    }
    private lazy var thankContentLabel = UILabel().then { label in
        label.text = "查重API:\nhttps://asoulcnki.asia/\n小作文库:\nhttps://asoul.icu"
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 0
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
        setupConstraints()
    }
    
    override func setupSubViews() {
        view.addSubview(contentView)
        contentView.addSubview(asoulInfoCardView)
        asoulInfoCardView.addSubview(asoulTeamImgView)
        asoulInfoCardView.addSubview(asoulInfoTitleLabel)
        asoulInfoCardView.addSubview(asoulInfoContentLabel)
        
        contentView.addSubview(appInfoCardView)
        appInfoCardView.addSubview(appInfoTitleLabel)
        appInfoCardView.addSubview(appInfoContentLabel)
        appInfoCardView.addSubview(thankTitleLabel)
        appInfoCardView.addSubview(thankContentLabel)
    }
    
    override func setupConstraints() {
        contentView.snp.makeConstraints { make in
            make.top.bottom.right.left.equalTo(view)
        }
        asoulInfoCardView.snp.makeConstraints { make in
            make.top.left.equalTo(contentView).offset(15)
            make.right.equalTo(contentView).offset(-15)
            make.right.equalTo(view).offset(-15)
            make.bottom.equalTo(asoulInfoContentLabel).offset(15)
        }
        asoulInfoCardView.layoutIfNeeded()
        let height = (asoulInfoCardView.frame.size.width - 30) * 310.0 / 268.0
        asoulTeamImgView.snp.makeConstraints { make in
            make.left.equalTo(asoulInfoCardView).offset(15)
            make.right.equalTo(asoulInfoCardView).offset(-15)
            make.top.equalTo(asoulInfoCardView).offset(15)
            make.height.equalTo(height)
        }
        
        asoulInfoTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(asoulTeamImgView.snp.bottom).offset(5)
            make.left.equalTo(asoulInfoCardView).offset(15)
            make.right.equalTo(asoulInfoCardView).offset(-15)
        }
        
        asoulInfoContentLabel.snp.makeConstraints { make in
            make.top.equalTo(asoulInfoTitleLabel.snp.bottom)
            make.left.equalTo(asoulInfoCardView).offset(15)
            make.right.equalTo(asoulInfoCardView).offset(-15)
        }
        
        appInfoCardView.snp.makeConstraints { make in
            make.top.equalTo(asoulInfoCardView.snp.bottom).offset(30)
            make.left.equalTo(contentView).offset(15)
            make.right.equalTo(contentView).offset(-15)
            make.bottom.equalTo(thankContentLabel).offset(15)
            make.bottom.equalTo(contentView).offset(-15)
        }
        
        appInfoTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(appInfoCardView).offset(20)
            make.left.equalTo(asoulInfoCardView).offset(15)
            make.right.equalTo(asoulInfoCardView).offset(-15)
        }
        
        appInfoContentLabel.snp.makeConstraints { make in
            make.top.equalTo(appInfoTitleLabel.snp.bottom)
            make.left.equalTo(asoulInfoCardView).offset(15)
            make.right.equalTo(asoulInfoCardView).offset(-15)
        }
        
        thankTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(appInfoContentLabel.snp.bottom)
            make.left.equalTo(asoulInfoCardView).offset(15)
            make.right.equalTo(asoulInfoCardView).offset(-15)
        }
        
        thankContentLabel.snp.makeConstraints { make in
            make.top.equalTo(thankTitleLabel.snp.bottom)
            make.left.equalTo(asoulInfoCardView).offset(15)
            make.right.equalTo(asoulInfoCardView).offset(-15)
        }
    }

}
