//

//
//  ASLibraryDataCell.swift
//  ASOULApp
//
//  Created by southorange on 2021/9/9.
//  
//
    

import UIKit
import SnapKit

class ASLibraryDataCell: UITableViewCell {
    var model = ASLibraryData()
    
    private lazy var bgView = UIView().then { view in
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        view.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.8).cgColor
        view.layer.shadowRadius = 2
        view.layer.shadowOffset = CGSize(width: 1, height: 1)
        view.layer.shadowOpacity = 1
        
        view.layer.cornerRadius = 5
    }
    
    private lazy var titleLabel = UILabel().then { label in
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .left
    }
    private lazy var authorLabel = UILabel().then { label in
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0.3365823765, green: 0.3365823765, blue: 0.3365823765, alpha: 1)
    }
    private lazy var lineView1 = UIView().then { view in
        view.backgroundColor = #colorLiteral(red: 0.8147139886, green: 0.8147139886, blue: 0.8147139886, alpha: 1)
    }
    private lazy var contentLabel = UILabel().then { label in
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 4
    }
    private lazy var lineView2 = UIView().then { view in
        view.backgroundColor = #colorLiteral(red: 0.8147139886, green: 0.8147139886, blue: 0.8147139886, alpha: 1)
    }
    private lazy var tagLabel = UILabel().then { label in
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
        label.numberOfLines = 0
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupSubViews()
        setupConstraints()
    }
    
    /// 初始化子视图
    func setupSubViews() {
        contentView.addSubview(bgView)
        bgView.addSubview(titleLabel)
        bgView.addSubview(authorLabel)
        bgView.addSubview(lineView1)
        bgView.addSubview(contentLabel)
        bgView.addSubview(lineView2)
        bgView.addSubview(tagLabel)
    }
    
    /// 初始化约束
    func setupConstraints() {
        bgView.snp.makeConstraints { make in
            make.edges.equalTo(contentView).inset(UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15))
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(bgView).offset(15)
            make.left.equalTo(bgView).offset(15)
            make.right.equalTo(bgView).offset(-15)
            make.bottom.lessThanOrEqualToSuperview().offset(-15)
        }
        
        authorLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.left.equalTo(bgView).offset(15)
            make.right.equalTo(bgView).offset(-15)
            make.bottom.lessThanOrEqualToSuperview().offset(-15)
        }
        
        lineView1.snp.makeConstraints { make in
            make.top.equalTo(authorLabel.snp.bottom).offset(5)
            make.left.equalTo(bgView).offset(15)
            make.right.equalTo(bgView).offset(-15)
            make.height.equalTo(0.5)
            make.bottom.lessThanOrEqualToSuperview().offset(-15)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView1.snp.bottom).offset(5)
            make.left.equalTo(bgView).offset(15)
            make.right.equalTo(bgView).offset(-15)
            make.bottom.lessThanOrEqualToSuperview().offset(-15)
        }
        
        lineView2.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(5)
            make.left.equalTo(bgView).offset(15)
            make.right.equalTo(bgView).offset(-15)
            make.height.equalTo(0.5)
            make.bottom.lessThanOrEqualToSuperview().offset(-15)
        }
        
        tagLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView2.snp.bottom).offset(5)
            make.left.equalTo(bgView).offset(15)
            make.right.equalTo(bgView).offset(-15)
            make.bottom.lessThanOrEqualToSuperview().offset(-15)
        }
    }
    
    /// 刷新子视图
    func refreshSubViews() {
        titleLabel.text = model.title
        authorLabel.text = model.author
        contentLabel.text = model.plainContent
        
        var tagText = ""
        for i in 0..<model.tags.count {
            if i != 0 {
                tagText += " "
            }
            tagText += model.tags[i]
        }
        tagLabel.text = tagText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
