//
//  TopStoriesViewModelTests.swift
//  NYTimesTests
//
//  Created by Hardik Kothari on 30/9/2562 BE.
//  Copyright © 2562 Hardik Kothari. All rights reserved.
//

import XCTest
@testable import NYTimes

class TopStoriesViewModelTests: XCTestCase {

    // MARK: - get Top Stories
    func testNormalGetTopStories() {
        let topStoriesServices = MockTopStoriesServices()
        topStoriesServices.getTopStoriesResult = .response([Article([:])])

        let viewModel = TopStoriesViewModel(service: topStoriesServices)
        viewModel.getTopStoriesFor("science")
        
        if viewModel.numberOfRows(in: 0) <= 0 {
            XCTFail()
        }
    }
    
    func testErrorGetTopStories() {
        let topStoriesServices = MockTopStoriesServices()
        topStoriesServices.getTopStoriesResult = .error

        let viewModel = TopStoriesViewModel(service: topStoriesServices)
        viewModel.getTopStoriesFor("science")
        
        if viewModel.numberOfRows(in: 0) > 0 {
            XCTFail()
        }
    }
}
