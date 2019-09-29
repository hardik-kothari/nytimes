//
//  ArticleImage.swift
//  NYTimes
//
//  Created by Hardik Kothari on 30/9/2562 BE.
//  Copyright © 2562 Hardik Kothari. All rights reserved.
//

import Foundation
import UIKit

struct ArticleImage {
    enum Keys: String, CodingKey {
        case caption
        case url
        case height
        case width
    }
    
    let caption: String?
    let url: String?
    let imageSize: CGSize?
    
    init(_ json: Json) {
        caption = json[Keys.caption]
        url = json[Keys.url]
        let height = json[Keys.height] ?? 0
        let width = json[Keys.width] ?? 0
        imageSize = CGSize(width: width, height: height)
    }
}
