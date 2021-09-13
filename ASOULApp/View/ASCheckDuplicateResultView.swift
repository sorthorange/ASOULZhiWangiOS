//

//
//  ASCheckDuplicateResultView.swift
//  ASOULApp
//
//  Created by southorange on 2021/9/9.
//  
//
    

import UIKit
import SVProgressHUD
import SDWebImage

class ASCheckDuplicateResultDetailView: UIView {
    var model = ASCheckDuplicateReplyData() {
        didSet {
            refreshSubViews()
        }
    }
    
    private lazy var avatarImageView = UIImageView().then { imageView in
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
    }
    private lazy var nameLabel = UILabel().then { label in
        label.textColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 15, weight: .medium)
    }
    private lazy var likeImageView = UIImageView().then { imageView in
        imageView.image = UIImage(named: "like")
    }
    private lazy var likeLabelView = UILabel().then { label in
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 15)
    }
    private lazy var contentLabel = UILabel().then { label in
        label.font = .systemFont(ofSize: 15)
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.numberOfLines = 0
    }
    /// 底部label，包含重复度和创建时间
    private lazy var bottomLabel = UILabel().then { label in
        label.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 15)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        layer.cornerRadius = 5
        layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.8).cgColor
        layer.shadowRadius = 2
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowOpacity = 1
        isUserInteractionEnabled = true
        setupSubViews()
        setupConstraints()
        registerAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 初始化子视图
    func setupSubViews() {
        addSubview(avatarImageView)
        addSubview(nameLabel)
        addSubview(likeImageView)
        addSubview(likeLabelView)
        addSubview(contentLabel)
        addSubview(bottomLabel)
    }
    /// 初始化约束
    func setupConstraints() {
        avatarImageView.snp.makeConstraints { make in
            make.top.equalTo(self).offset(15)
            make.left.equalTo(self).offset(20)
            make.height.width.equalTo(40)
        }
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(avatarImageView)
            make.left.equalTo(avatarImageView.snp.right).offset(10)
        }
        likeLabelView.snp.makeConstraints { make in
            make.centerY.equalTo(avatarImageView)
            make.right.equalTo(self).offset(-20)
        }
        likeImageView.snp.makeConstraints { make in
            make.centerY.equalTo(avatarImageView)
            make.right.equalTo(likeLabelView.snp.left).offset(-5)
            make.width.height.equalTo(15)
        }
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.bottom).offset(5)
            make.left.equalTo(self).offset(15)
            make.right.equalTo(self).offset(-15)
        }
        bottomLabel.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom)
            make.left.right.equalTo(contentLabel)
            make.bottom.lessThanOrEqualTo(self).offset(-15)
        }
    }
    
    /// 刷新子视图
    func refreshSubViews() {
        ASHttpRequestHandler.getBilibiliUserInfo(id: model.publisherUid) { [weak self] result in
            if let result = result {
                self?.model.publisherName = result.name
                self?.nameLabel.text = result.name
                self?.avatarImageView.sd_setImage(with: URL(string: result.avatar), completed: nil)
            }
        } failure: { error in
            print(error)
            SVProgressHUD.showError(withStatus: "获取数据失败, \(error.localizedDescription)")
        }
        likeLabelView.text = "\(model.likeNum)"
        contentLabel.text = model.content
        let rate = String(format: "%.1f", model.rate * 100)
        bottomLabel.text = "重复度: \(rate)% 日期: \(DateUtil.convertIntToDateString(model.createTime)))"
    }
    
    func registerAction() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(gestureHandler(sender:)))
        addGestureRecognizer(tap)
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(gestureHandler(sender:)))
        longPress.minimumPressDuration = 1.5
        addGestureRecognizer(longPress)
    }
    
    @objc func gestureHandler(sender: UIGestureRecognizer) {
        if sender.isKind(of: UITapGestureRecognizer.self) {
            if let url = URL(string: model.replyUrl) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        } else if sender.isKind(of: UILongPressGestureRecognizer.self) {
            UIPasteboard.general.string = model.content
            SVProgressHUD.showSuccess(withStatus: "已复制到剪切板")
            SVProgressHUD.dismiss(withDelay: 1)
        }
    }
}

class ASCheckDuplicateResultView: UIView {
    var model = ASCheckDuplicateData() {
        didSet {
            refreshSubViews()
        }
    }
    
    private lazy var percentLabel = UILabel().then { label in
        label.text = "总文字复制比: 0.0%"
        label.textColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        label.font = .systemFont(ofSize: 18, weight: .semibold)
    }
    private lazy var percentView = ASPercentView()
    private lazy var copyResultButton = UIButton().then { button in
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1).cgColor
        button.setTitle("点击复制查重结果 🥵", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.01430185419, green: 0.7025176883, blue: 0.5647537112, alpha: 1), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
    }
    private lazy var tipLabel = UILabel().then { label in
        label.text = "请自行判断是否原创，请勿到处刷查重报告 🤖\nau们都是有素质的人捏 🤗"
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        label.font = .systemFont(ofSize: 15)
        label.numberOfLines = 0
    }
    
    private lazy var resultTitleLabel = UILabel().then { label in
        label.text = "相似小作文: 0篇"
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = .systemFont(ofSize: 15, weight: .medium)
    }
    private lazy var resultDetailViews = [ASCheckDuplicateResultDetailView]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubViews()
        setupConstraints()
        registerAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 初始化子视图
    func setupSubViews() {
        addSubview(percentLabel)
        addSubview(percentView)
        addSubview(copyResultButton)
        addSubview(tipLabel)
        addSubview(resultTitleLabel)
    }
    /// 初始化约束
    func setupConstraints() {
        percentLabel.snp.makeConstraints { make in
            make.top.equalTo(self).offset(15)
            make.left.equalTo(self).offset(25)
            make.right.lessThanOrEqualTo(self).offset(-65)
        }
        percentView.snp.makeConstraints { make in
            make.centerY.equalTo(percentLabel)
            make.left.equalTo(percentLabel.snp.right).offset(15)
            make.width.height.equalTo(25)
        }
        copyResultButton.snp.makeConstraints { make in
            make.top.equalTo(percentLabel.snp.bottom).offset(15)
            make.left.equalTo(self).offset(25)
            make.right.equalTo(self).offset(-25)
            make.height.equalTo(40)
        }
        tipLabel.snp.makeConstraints { make in
            make.top.equalTo(copyResultButton.snp.bottom)
            make.left.right.equalTo(self)
        }
        resultTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(tipLabel.snp.bottom).offset(30)
            make.left.equalTo(self).offset(5)
            make.bottom.lessThanOrEqualTo(self)
        }
    }
    /// 注册响应事件
    func registerAction() {
        copyResultButton.addTarget(self, action: #selector(buttonClick(sender:)), for: .touchUpInside)
    }
    /// 刷新子视图
    func refreshSubViews() {
        let rate = String(format: "%.1f", model.rate * 100)
        percentLabel.text = "总文字复制比: \(rate)%"
        percentView.percent = model.rate
        resultTitleLabel.text = "相似小作文: \(model.replyList.count)篇"
        
        for view in resultDetailViews {
            view.removeFromSuperview()
        }
        
        for i in 0..<model.replyList.count {
            if i <= resultDetailViews.count {
                resultDetailViews.append(ASCheckDuplicateResultDetailView())
            }
            let view = resultDetailViews[i]
            view.model = model.replyList[i]
            addSubview(view)
            view.snp.makeConstraints { make in
                if i == 0 {
                    make.top.equalTo(resultTitleLabel.snp.bottom).offset(15)
                } else {
                    make.top.equalTo(resultDetailViews[i - 1].snp.bottom).offset(15)
                }
                make.left.equalTo(self).offset(15)
                make.right.equalTo(self).offset(-15)
                make.bottom.lessThanOrEqualTo(self).offset(-5)
            }
        }
    }
    
    @objc func buttonClick(sender: UIButton) {
        if sender == copyResultButton {
            var result: String
            let rate = String(format: "%.1f", model.rate * 100)
            if let reply = model.replyList.first {
                result = "枝网文本复制检测报告(APP版)\n查重时间: \(DateUtil.convertIntToDateString())\n总文字复制比: \(rate)%\n相似小作文:  \(reply.replyUrl)\n作者: \(reply.publisherName)\n发表时间: \(DateUtil.convertIntToDateString(reply.createTime))\n\n查重结果仅作参考，请注意辨别是否为原创"
            } else {
                result = "枝网文本复制检测报告(APP版)\n查重时间: \(DateUtil.convertIntToDateString())\n总文字复制比: \(rate)%\n\n查重结果仅作参考，请注意辨别是否为原创"
            }
            UIPasteboard.general.string = result
            SVProgressHUD.showSuccess(withStatus: "已复制到剪切板")
            SVProgressHUD.dismiss(withDelay: 1)
        }
    }
}
