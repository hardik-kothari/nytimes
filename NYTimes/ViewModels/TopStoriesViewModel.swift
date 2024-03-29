//
//  TopStoriesViewModel.swift
//  NYTimes
//
//  Created by Hardik Kothari on 29/9/2562 BE.
//  Copyright © 2562 Hardik Kothari. All rights reserved.
//

import UIKit
import RxSwift

class TopStoriesViewModel {
    // MARK: - Private properties
    private var service: TopStoriesServices!
    private var articleList: [ArticleDetailViewModel] = []
    private let disposeBag = DisposeBag()
    
    // MARK: - Public properties
    let topStoriesSubject = BehaviorSubject<ApiManager.State>(value: .loading)
    
    // MARK: - Life-cycle methods
    init(service: TopStoriesServices) {
        self.service = service
    }
}

// MARK: - Api Methods
extension TopStoriesViewModel {
    @objc func getTopStoriesFor(_ section: String) {
        if ApiManager.shared.isConnectedToInternet {
            topStoriesSubject.onNext((.loading))
            service.getTopStoriesFor(section)
                .observeOn(MainScheduler.instance)
                .subscribe (
                    onNext: { [weak self] state in
                        switch state {
                        case .response(let response):
                            guard let articles = response as? [Article] else {
                                self?.topStoriesSubject.onNext(.error)
                                return
                            }
                            self?.articleList = articles.map({ article in
                                return ArticleDetailViewModel(article.title,
                                                              author: article.byline,
                                                              abstract: article.abstract,
                                                              thumbnail: article.thumbImage,
                                                              largeImage: article.largeImage,
                                                              publishedDate: article.published_date,
                                                              articleLink: article.url)
                            })
                            self?.topStoriesSubject.onNext(.response(nil))
                        default:
                            self?.topStoriesSubject.onNext(.error)
                        }
                    },
                    onError: { [weak self] error in
                        self?.topStoriesSubject.onNext((.error))
                })
                .disposed(by: disposeBag)
        } else {
            topStoriesSubject.onNext((.offline))
        }
    }
}

// MARK: - Data Source Methods for List Screen
extension TopStoriesViewModel {
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows(in section: Int) -> Int {
        return articleList.count
    }
    
    func articleViewModel(at indexPath: IndexPath) -> ArticleDetailViewModel {
        return articleList[indexPath.row]
    }
}
