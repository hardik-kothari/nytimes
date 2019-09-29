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
        case thumbUrl
        case largeUrl
    }
    
    let title: String?
    let abstract: String?
    let url: String?
    let byline: String?
    let published_date: Date?
    var thumbUrl: String?
    var largeUrl: String?
    
    init(_ json: Json) {
        title = json[Keys.title]
        abstract = json[Keys.abstract]
        url = json[Keys.url]
        byline = json[Keys.byline]
        published_date = (json[Keys.published_date] ?? "").toUTCDate(format: "yyyy-MM-dd'T'HH:mm:ss+HH:mm")
        let mediaList: [Json] = json[Keys.multimedia] ?? []
        for media in mediaList {
            guard let format = ImageFormat(rawValue: media[Keys.format] ?? "") else {
                return
            }
            switch format {
            case .thumbnail:
                thumbUrl = media[Keys.url]
            case .superJumbo:
                largeUrl = media[Keys.url]
            default:
                break
            }
        }
    }
}
