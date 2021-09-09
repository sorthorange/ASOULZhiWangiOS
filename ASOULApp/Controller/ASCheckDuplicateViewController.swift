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
    
    var inputBackView = UIView().then { view in
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        view.layer.cornerRadius = 5
    }
    var inputTextView = YYTextView().then { textView in
        textView.font = .systemFont(ofSize: 15)
        textView.placeholderText = "输入要查重的小作文，至少10个字哦 😯"
    }
    var pasteButton = UIButton().then { button in
        button.setImage(UIImage(named: "copy"), for: .normal)
    }
    var clearButton = UIButton().then { button in
        button.isHidden = true
        button.setImage(UIImage(named: "close"), for: .normal)
    }
    var checkduplicateButton = UIButton().then { button in
        button.backgroundColor = #colorLiteral(red: 0.01430185419, green: 0.7025176883, blue: 0.5647537112, alpha: 1)
        button.layer.cornerRadius = 5
        button.setTitle("立即查重捏 🤤", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
    }
    var lineView = UIView().then { view in
        view.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    }
    var tipLabel = UILabel().then { label in
        label.numberOfLines = 0
        label.text = "数据来源于：https://asoulcnki.asia/\n目前仅收录了官方账号下面的小作文，二创下的小作文并未收录，所以查重结果仅供参考哦 🥰"
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = .systemFont(ofSize: 15)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
        setupConstraints()
        registerAction()
    }
    
    override func setupSubViews() {
        view.addSubview(inputBackView)
        inputTextView.delegate = self
        inputBackView.addSubview(inputTextView)
        inputBackView.addSubview(pasteButton)
        inputBackView.addSubview(clearButton)
        view.addSubview(checkduplicateButton)
        view.addSubview(lineView)
        view.addSubview(tipLabel)
    }
    
    override func setupConstraints() {
        inputBackView.snp.makeConstraints { make in
            make.top.equalTo(view).offset(15)
            make.left.equalTo(view).offset(15)
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
        lineView.snp.makeConstraints { make in
            make.left.right.equalTo(view)
            make.top.equalTo(checkduplicateButton.snp.bottom).offset(10)
            make.height.equalTo(0.5)
        }
        tipLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(10)
            make.left.right.equalTo(inputBackView)
        }
    }
    
    func registerAction() {
        clearButton.addTarget(self, action: #selector(buttonClick(sender:)), for: .touchUpInside)
        pasteButton.addTarget(self, action: #selector(buttonClick(sender:)), for: .touchUpInside)
        checkduplicateButton.addTarget(self, action: #selector(buttonClick(sender:)), for: .touchUpInside)
    }
    
    func hideKeyBoard() {
        inputTextView.resignFirstResponder()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if let point = touches.first?.location(in: view), inputBackView.frame.contains(point) {
            return
        }
        hideKeyBoard()
    }
}

//MARK: Action
extension ASCheckDuplicateViewController {
    @objc func buttonClick(sender: UIButton) {
        switch sender {
        case clearButton:
            inputTextView.text = ""
        case pasteButton:
            if let paste = UIPasteboard.general.string {
                inputTextView.text = paste
            }
        case checkduplicateButton:
            if let text = inputTextView.text, text.count > 10 {
                
            } else {
                SVProgressHUD.showError(withStatus: "小作文至少需要10个字哦 😡")
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
