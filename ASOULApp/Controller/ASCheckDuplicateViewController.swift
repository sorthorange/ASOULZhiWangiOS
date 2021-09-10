//

//
//  ASCheckDuplicateViewController.swift
//  ASOULApp
//
//  Created by southorange on 2021/8/22.
//  
//
    

import UIKit
import YYText
import SVProgressHUD

class ASCheckDuplicateViewController: ASTabBarChildViewController {
    
    private lazy var contentView = UIScrollView().then { scrollView in
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
    }
    
    private lazy var inputBackView = UIView().then { view in
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        view.layer.cornerRadius = 5
    }
    private lazy var inputTextView = YYTextView().then { textView in
        textView.font = .systemFont(ofSize: 15)
        textView.placeholderText = "输入要查重的小作文，至少10个字哦 😯"
    }
    private lazy var pasteButton = UIButton().then { button in
        button.setImage(UIImage(named: "copy"), for: .normal)
    }
    private lazy var clearButton = UIButton().then { button in
        button.isHidden = true
        button.setImage(UIImage(named: "close"), for: .normal)
    }
    private lazy var checkduplicateButton = UIButton().then { button in
        button.backgroundColor = #colorLiteral(red: 0.01430185419, green: 0.7025176883, blue: 0.5647537112, alpha: 1)
        button.layer.cornerRadius = 5
        button.setTitle("立即查重捏 🤤", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
    }
    private lazy var lineView = UIView().then { view in
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    }
    private lazy var tipLabel = UILabel().then { label in
        label.numberOfLines = 0
        label.text = "数据来源于：https://asoulcnki.asia/\n目前仅收录了官方账号下面的小作文，二创下的小作文并未收录，所以查重结果仅供参考哦 🥰"
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = .systemFont(ofSize: 15)
    }
    
    private lazy var resultView = ASCheckDuplicateResultView().then { view in
        view.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
        setupConstraints()
        registerAction()
    }
    
    override func setupSubViews() {
        view.addSubview(contentView)
        contentView.addSubview(inputBackView)
        inputTextView.delegate = self
        inputBackView.addSubview(inputTextView)
        inputBackView.addSubview(pasteButton)
        inputBackView.addSubview(clearButton)
        contentView.addSubview(checkduplicateButton)
        contentView.addSubview(resultView)
        contentView.addSubview(lineView)
        contentView.addSubview(tipLabel)
    }
    
    override func setupConstraints() {
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        inputBackView.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(15)
            make.left.equalTo(contentView).offset(15)
            make.right.equalTo(contentView).offset(-15)
            make.right.equalTo(view).offset(-15)
            make.height.equalTo(150)
        }
        inputTextView.snp.makeConstraints { make in
            make.edges.equalTo(inputBackView).inset(UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        }
        
        clearButton.snp.makeConstraints { make in
            make.right.bottom.equalTo(inputBackView).offset(-10)
            make.height.width.equalTo(20)
        }
        
        pasteButton.snp.makeConstraints { make in
            make.bottom.equalTo(inputBackView).offset(-10)
            make.right.equalTo(inputBackView).offset(-10)
            make.height.width.equalTo(20)
        }
        checkduplicateButton.snp.makeConstraints { make in
            make.top.equalTo(inputBackView.snp.bottom).offset(15)
            make.left.right.equalTo(inputBackView)
            make.height.equalTo(30)
        }
        resultView.snp.makeConstraints { make in
            make.top.equalTo(checkduplicateButton.snp.bottom).offset(15)
            make.left.right.equalTo(contentView)
        }
        lineView.snp.makeConstraints { make in
            make.left.right.equalTo(contentView)
            make.top.equalTo(checkduplicateButton.snp.bottom).offset(10)
            make.height.equalTo(0.5)
        }
        tipLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(10)
            make.left.right.equalTo(inputBackView)
            make.bottom.lessThanOrEqualTo(contentView).offset(-20)
        }
    }
    
    /// 注册响应事件
    func registerAction() {
        clearButton.addTarget(self, action: #selector(buttonClick(sender:)), for: .touchUpInside)
        pasteButton.addTarget(self, action: #selector(buttonClick(sender:)), for: .touchUpInside)
        checkduplicateButton.addTarget(self, action: #selector(buttonClick(sender:)), for: .touchUpInside)
    }
    
    /// 刷新结果界面的隐藏
    func updateResultViewHidden(_ isHidden: Bool) {
        if isHidden {
            resultView.isHidden = true
            lineView.snp.remakeConstraints { make in
                make.left.right.equalTo(contentView)
                make.top.equalTo(checkduplicateButton.snp.bottom).offset(10)
                make.height.equalTo(0.5)
            }
        } else {
            resultView.isHidden = false
            lineView.snp.remakeConstraints { make in
                make.left.right.equalTo(contentView)
                make.top.equalTo(resultView.snp.bottom).offset(10)
                make.height.equalTo(0.5)
            }
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if let point = touches.first?.location(in: view), inputBackView.frame.contains(point) {
            return
        }
        inputTextView.resignFirstResponder()
    }
}

//MARK: Action
extension ASCheckDuplicateViewController {
    @objc func buttonClick(sender: UIButton) {
        switch sender {
        case clearButton:
            self.updateResultViewHidden(true)
            inputTextView.text = ""
        case pasteButton:
            if let paste = UIPasteboard.general.string {
                inputTextView.text += paste
            }
        case checkduplicateButton:
            guard let text = inputTextView.text else {
                SVProgressHUD.showError(withStatus: "小作文至少需要10个字哦 😡")
                SVProgressHUD.dismiss(withDelay: 1)
                return
            }
            if text.count >= 10 && text.count < 1000 {
                ASHttpRequestHandler.postCheckDuplicate(content: text) { [weak self] data in
                    if let data = data {
                        self?.updateResultViewHidden(false)
                        self?.resultView.model = data
                    }
                } failure: { error in
                    print(error)
                    SVProgressHUD.showError(withStatus: "获取数据失败, \(error.localizedDescription)")
                }
            } else if text.count < 10 {
                SVProgressHUD.showError(withStatus: "小作文至少需要10个字哦 😡")
                SVProgressHUD.dismiss(withDelay: 1)
            } else if text.count >= 1000 {
                SVProgressHUD.showError(withStatus: "小作文至多1000个字哦 😡")
                SVProgressHUD.dismiss(withDelay: 1)
            }
            break
        default:
            break
        }
    }
}

extension ASCheckDuplicateViewController: YYTextViewDelegate {
    func textViewDidChange(_ textView: YYTextView) {
        if textView.text.isEmpty {
            clearButton.isHidden = true
            pasteButton.snp.updateConstraints { make in
                make.right.equalTo(inputBackView).offset(-10)
            }
        } else {
            clearButton.isHidden = false
            pasteButton.snp.updateConstraints { make in
                make.right.equalTo(inputBackView).offset(-40)
            }
        }
    }
}
