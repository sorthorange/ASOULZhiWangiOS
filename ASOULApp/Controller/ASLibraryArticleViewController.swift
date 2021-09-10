//

//
//  ASLibraryArticleViewController.swift
//  ASOULApp
//
//  Created by southorange on 2021/8/29.
//  
//
    

import UIKit
import SVProgressHUD

class ASLibraryArticleViewController: UIViewController {
    
    var articleId = ""
    var articleTitle = ""
    var articleAuthor = ""
    var articleContent = ""
        
    private lazy var titleLabel = UILabel().then { label in
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .left
    }
    
    private lazy var authorLabel = UILabel().then { label in
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .left
    }
    
    private lazy var lineView = UIView().then { view in
        view.backgroundColor = #colorLiteral(red: 0.8147139886, green: 0.8147139886, blue: 0.8147139886, alpha: 1)
    }
    
    private lazy var contentTextView = UITextView().then { textView in
        textView.font = .systemFont(ofSize: 15, weight: .regular)
        textView.textAlignment = .left
        textView.isEditable = false
        textView.isSelectable = true
        textView.showsVerticalScrollIndicator = false
        textView.showsHorizontalScrollIndicator = false
    }
    
    private lazy var pasteBoardButton = UIButton().then { button in
        button.setImage(UIImage(named: "copy"), for: .normal)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "阅读小作文"
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        setupSubViews()
        setupConstraints()
        registerAction()
        refreshData()
    }

    func setupSubViews() {
        view.addSubview(titleLabel)
        view.addSubview(authorLabel)
        view.addSubview(lineView)
        view.addSubview(contentTextView)
        
        let pasteBoardItem = UIBarButtonItem(customView: pasteBoardButton)
        self.navigationItem.rightBarButtonItem = pasteBoardItem
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin).offset(15)
            make.left.equalTo(view).offset(15)
            make.right.equalTo(view).offset(-15)
        }
        authorLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.left.equalTo(titleLabel)
        }
        lineView.snp.makeConstraints { make in
            make.top.equalTo(authorLabel.snp.bottom).offset(15)
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
            make.height.equalTo(0.5)
        }
        contentTextView.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(10)
            make.left.equalTo(view).offset(15)
            make.right.equalTo(view).offset(-15)
            make.bottom.equalTo(view.snp.bottomMargin).offset(-15)
        }
        
        pasteBoardButton.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
    }
    
    /// 注册响应事件
    func registerAction() {
        pasteBoardButton.addTarget(self, action: #selector(buttonClick(sender:)), for: .touchUpInside)
    }
    
    /// 刷新数据
    func refreshData() {
        titleLabel.text = articleTitle
        authorLabel.text = articleAuthor
        ASHttpRequestHandler.getLibraryArticle(id: articleId) { [weak self] html in
            if let html = html {
                guard let content = html.removingPercentEncoding, let data = content.data(using: .unicode) else {return}
                guard let attStr = try? NSMutableAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) else {return}
                self?.contentTextView.attributedText = attStr
            }
        } failure: { error in
            print(error)
            SVProgressHUD.showError(withStatus: "获取数据失败, \(error.localizedDescription)")
        }

    }
}

//MARK: Action
extension ASLibraryArticleViewController {
    @objc func buttonClick(sender: UIButton) {
        if sender == pasteBoardButton {
            UIPasteboard.general.string = contentTextView.text
            SVProgressHUD.showSuccess(withStatus: "已复制到剪切板")
            SVProgressHUD.dismiss(withDelay: 1)
        }
    }
}


