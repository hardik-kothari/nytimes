//
//  Api.swift
//  NYTimes
//
//  Created by Hardik Kothari on 29/9/2562 BE.
//  Copyright © 2562 Hardik Kothari. All rights reserved.
//

import Foundation
import Alamofire

// MARK: - Api target type
protocol Target {
    var baseUrl: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var parameters: Parameters? { get }
    var parameterEncoding: ParameterEncoding { get }
    var headers: HTTPHeaders? { get }
}

extension Target {
    var url: URL {
        let urlString = baseUrl + path + "?api-key=EOjvxUrKIzoAOVG7ovVA41CY3UGGC9UG"
        return URL(string: urlString)!
    }
}

enum Api {
    case topStories(_ section: String)
}

extension Api: Target {
    var baseUrl: String {
        return "https://api.nytimes.com/svc"
    }
    
    var path: String {
        switch self {
        case .topStories(let section):
            return "/topstories/v2/\(section).json"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .topStories:
            return .get
        }
    }
    
    var parameters: Parameters? {
        switch self {
        default:
            return nil
        }
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var headers: [String: String]? {
        return nil
    }
}
