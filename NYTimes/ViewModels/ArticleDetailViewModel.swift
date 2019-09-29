//
//  ArticleDetailViewModel.swift
//  NYTimes
//
//  Created by Hardik Kothari on 29/9/2562 BE.
//  Copyright © 2562 Hardik Kothari. All rights reserved.
//

import Foundation

class ArticleDetailViewModel: NSObject {
    let title: String?
    let author: String?
    let abstract: String?
    let thumbImage: ArticleImage?
    let largeImage: ArticleImage?
    let publishedOn: String?
    let articleLink: String?

    init(_ title: String?, author: String?, abstract: String?, thumbnail: ArticleImage?, largeImage: ArticleImage?, publishedDate: Date?, articleLink: String?) {
        self.title = title
        self.author = author
        self.abstract = abstract
        self.thumbImage = thumbnail
        self.largeImage = largeImage
        self.publishedOn = publishedDate?.toLocalString(format: "MMM. dd, yyyy HH:mm")
        self.articleLink = articleLink
    }
}
