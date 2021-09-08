//

//
//  ASLibraryViewController.swift
//  ASOULApp
//
//  Created by southorange on 2021/8/22.
//  
//
    

import UIKit
import SVProgressHUD
import MJRefresh

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
        setupSubViews()
        setupConstraints()
    }
    
    func setupSubViews() {
        contentView.addSubview(bgView)
        bgView.addSubview(titleLabel)
        bgView.addSubview(authorLabel)
        bgView.addSubview(lineView1)
        bgView.addSubview(contentLabel)
        bgView.addSubview(lineView2)
        bgView.addSubview(tagLabel)
    }
    
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

class ASLibraryViewController: ASTabBarChildViewController {
    
    var libraryList = [ASLibraryData]()
    
    var tableView = UITableView().then { view in
        view.separatorStyle = .none
        view.register(ASLibraryDataCell.self, forCellReuseIdentifier: NSStringFromClass(ASLibraryDataCell.self))
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
    }
    
    private var pageNum = 0
    private var pageSize = 16

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
        setupConstraints()
        registerAction()
        requestData(completion: nil)
    }
    
    override func setupSubViews() {
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    
    override func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }
    
    func registerAction() {
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            self?.requestData(completion: {
                self?.tableView.mj_header?.endRefreshing()
            })
        })
        
        self.tableView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: { [weak self] in
            self?.requestData(false, completion: {
                self?.tableView.mj_footer?.endRefreshing()
            })
        })
    }
    
    // 请求数据，isClear字段表示是否需要清空数据重新请求
    func requestData(_ isClear:Bool = true, completion: (() -> ())?) {
        if isClear { // 请求成功后重置pageNum，刷新数据用
            ASHttpRequestHandler.requestLibrary(pageNum: 0, pageSize: 16) { [weak self] dataList in
                if let dataList = dataList {
                    self?.pageNum = 1
                    self?.libraryList = dataList
                    self?.tableView.reloadData()
                    completion?()
                }
            } failure: { error in
                print(error)
                SVProgressHUD.showError(withStatus: "获取数据失败, \(error.localizedDescription)")
                completion?()
            }
        } else { // 分页请求之后的数据
            ASHttpRequestHandler.requestLibrary(pageNum: pageNum, pageSize: 16) { [weak self] dataList in
                if let dataList = dataList {
                    if (dataList.first?.submissionTime ?? 0) >= (self?.libraryList.first?.submissionTime ?? 0) { // 根据submissionTime判断是否需要去重
                        ASHttpRequestHandler.requestLibrary(pageNum: 0, pageSize: 16 * (self?.pageNum ?? 1)) { [weak self] dataList in
                            if let dataList = dataList {
                                self?.pageNum += 1
                                self?.libraryList = dataList
                                self?.tableView.reloadData()
                                self?.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                                completion?()
                            }
                        } failure: { error in
                            print(error)
                            SVProgressHUD.showError(withStatus: "获取数据失败, \(error.localizedDescription)")
                            completion?()
                        }
                    } else {
                        self?.pageNum += 1
                        self?.libraryList += dataList
                        self?.tableView.reloadData()
                        completion?()
                    }
                }
            } failure: { error in
                print(error)
                SVProgressHUD.showError(withStatus: "获取数据失败, \(error.localizedDescription)")
                completion?()
            }
        }
    }
    
}

extension ASLibraryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let articleViewController = ASLibraryArticleViewController()
        let model = libraryList[indexPath.row]
        articleViewController.articleId = model.id
        articleViewController.articleTitle = model.title
        articleViewController.articleAuthor = model.author
        asTabBarController?.navigationController?.pushViewController(articleViewController, animated: true)
    }
}

extension ASLibraryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.libraryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(ASLibraryDataCell.self), for: indexPath)
        if let cell = cell as? ASLibraryDataCell {
            cell.model = self.libraryList[indexPath.row]
            cell.refreshSubViews()
        }
        return cell
    }
    
    
}
