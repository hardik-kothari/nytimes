//
//  MockServices.swift
//  NYTimesTests
//
//  Created by Hardik Kothari on 30/9/2562 BE.
//  Copyright © 2562 Hardik Kothari. All rights reserved.
//

import XCTest
import RxSwift
@testable import NYTimes

class MockTopStoriesServices: TopStoriesServices {
    var getTopStoriesResult: ApiManager.State = .error
    
    override func getTopStoriesFor(_ section: String) -> Observable<ApiManager.State> {
        return Observable.create { observer in
            observer.onNext(self.getTopStoriesResult)
            return Disposables.create()
        }
    }
}
