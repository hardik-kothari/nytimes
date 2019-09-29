//
//  HomeViewController.swift
//  NYTimes
//
//  Created by Hardik Kothari on 29/9/2562 BE.
//  Copyright © 2562 Hardik Kothari. All rights reserved.
//

import UIKit
import RxSwift

class HomeViewController: UIViewController {
    
    // MARK: - UI Controls
    private lazy var refreshControl = UIRefreshControl()
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.estimatedRowHeight = 44.0
        table.tableFooterView = nil
        
        table.dataSource = self
        table.delegate = self
        return table
    }()
    
    // MARK: - Private properties
    private let viewModel = TopStoriesViewModel(service: TopStoriesServices())
    private let disposeBag = DisposeBag()
    
    // MARK: - Life-cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationBar.largeTitleTextAttributes =
                [NSAttributedString.Key.foregroundColor: UIColor.black,
                 NSAttributedString.Key.font: UIFont(name: Font.black, size: Font.Size.extraLarge.rawValue) ??
                    UIFont.systemFont(ofSize: 28.0)]
        }
        getTopStories()
        bindWithViewModel()
    }
    
    private func configureView() {
        title = "Top stories"
        edgesForExtendedLayout = .top
        extendedLayoutIncludesOpaqueBars = true
        
        tableView.frame = view.frame
        tableView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        tableView.clipsToBounds = true
        refreshControl.addTarget(self, action: #selector(startRefreshing), for: UIControl.Event.valueChanged)
        tableView.refreshControl = refreshControl
        tableView.register(ArticleCell.self, forCellReuseIdentifier: ArticleCell.identifier)
        view.addSubview(tableView)
    }
    
    // MARK: - Data methods
    private func getTopStories() {
        viewModel.getTopStoriesFor("science")
    }
    
    private func bindWithViewModel() {
        viewModel.topStoriesSubject
            .subscribeNext({ [weak self] state in
                if state != .loading {
                    self?.refreshControl.endRefreshing()
                }
                self?.handleCategoryResponse(state)
            }).disposed(by:disposeBag)
    }
    
    private func handleCategoryResponse(_ response: ApiManager.State) {
        switch response {
        case .loading:
            if !refreshControl.isRefreshing {
                view.show(.loading)
            }
        case .error:
            view.show(.error(message: "Something went wrong. Please try again after sometime.", tryAgain: { [weak self] in
                self?.getTopStories()
            }))
        case .offline:
            view.show(.error(message: "Please check your internet connection and try again later.", tryAgain: { [weak self] in
                self?.getTopStories()
            }))
        case .response:
            tableView.reloadData()
            view.show(.none)
        }
    }
    
    // MARK: - UI Actions
    @objc private func startRefreshing() {
        if !tableView.isDragging {
            getTopStories()
        }
    }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let articleCell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell") as? ArticleCell else {
            return UITableViewCell()
        }
        let articleViewModel = viewModel.articleViewModel(at: indexPath)
        articleCell.configure(articleViewModel)
        return articleCell
    }
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

// MARK: - UIScrollViewDelegate
extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if refreshControl.isRefreshing {
            getTopStories()
        }
    }
}
