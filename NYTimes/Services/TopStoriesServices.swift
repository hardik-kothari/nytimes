//
//  TopStoriesServices.swift
//  NYTimes
//
//  Created by Hardik Kothari on 29/9/2562 BE.
//  Copyright © 2562 Hardik Kothari. All rights reserved.
//

import Foundation
import RxSwift

class TopStoriesServices {
    func getTopStoriesFor(_ section: String) -> Observable<[Articcle]> {
        return ApiManager.shared
            .rx
            .request(Api.topStories(section))
            .mapJson()
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .map({ json in
                guard let jsonList = json["results"] as? [Json] else {
                    return []
                }
                return jsonList.map({ Articcle($0) })
            })
            .observeOn(MainScheduler.instance)
    }
}
