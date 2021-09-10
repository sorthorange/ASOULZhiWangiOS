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

class ASLibraryViewController: ASTabBarChildViewController {
    
    var libraryList = [ASLibraryData]()
    
    private lazy var tableView = UITableView().then { view in
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
    
    /// 注册响应事件
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
            ASHttpRequestHandler.getLibrary(pageNum: 0, pageSize: 16) { [weak self] dataList in
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
            ASHttpRequestHandler.getLibrary(pageNum: pageNum, pageSize: 16) { [weak self] dataList in
                if let dataList = dataList {
                    if (dataList.first?.submissionTime ?? 0) >= (self?.libraryList.first?.submissionTime ?? 0) { // 根据submissionTime判断是否需要去重
                        ASHttpRequestHandler.getLibrary(pageNum: 0, pageSize: 16 * (self?.pageNum ?? 1)) { [weak self] dataList in
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
