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
    let thumbImageUrl: URL?
    let largeImageUrl: URL?
    let publishedOn: String?
    
    init(_ title: String?, author: String?, abstract: String?, thumbnail: String?, largeUrl: String?, publishedDate: Date?) {
        self.title = title
        self.author = author
        self.abstract = abstract
        self.thumbImageUrl = URL(string: thumbnail ?? "")
        self.largeImageUrl = URL(string: largeUrl ?? "")
        self.publishedOn = publishedDate?.toLocalString(format: "dd MMM yyyy, HH:mm")
    }
}
