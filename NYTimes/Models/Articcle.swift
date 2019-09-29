//
//  Articcle.swift
//  NYTimes
//
//  Created by Hardik Kothari on 29/9/2562 BE.
//  Copyright © 2562 Hardik Kothari. All rights reserved.
//

import Foundation

enum ImageFormat: String {
    case thumbnail = "Standard Thumbnail"
    case thumbLarge = "thumbLarge"
    case normal = "Normal"
    case mediumThreeByTwo210 = "mediumThreeByTwo210"
    case superJumbo = "superJumbo"
}

struct Article {
    enum Keys: String, CodingKey {
        case title
        case abstract
        case url
        case byline
        case published_date
        case multimedia
        case format
    }
    
    let title: String?
    let abstract: String?
    let url: String?
    let byline: String?
    let published_date: Date?
    var thumbImage: ArticleImage?
    var largeImage: ArticleImage?
    
    init(_ json: Json) {
        title = json[Keys.title]
        abstract = json[Keys.abstract]
        url = json[Keys.url]
        byline = json[Keys.byline]
        let dateString = json[Keys.published_date] ?? ""
        published_date = dateString.toUTCDate(format: "yyyy-MM-dd'T'HH:mm:ssZ")
        let mediaList: [Json] = json[Keys.multimedia] ?? []
        for media in mediaList {
            guard let format = ImageFormat(rawValue: media[Keys.format] ?? "") else {
                return
            }
            switch format {
            case .thumbnail:
                thumbImage = ArticleImage(media)
            case .superJumbo:
                largeImage = ArticleImage(media)
            default:
                break
            }
        }
    }
}
