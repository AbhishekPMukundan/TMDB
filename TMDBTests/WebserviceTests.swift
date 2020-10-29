//
//  WebserviceTests.swift
//  TMDBTests
//
//  Created by Abhishek on 29/10/20.
//

import XCTest
@testable import TMDB
class WebserviceTests: XCTestCase {
    var webService = WebService()
    
    override class func setUp() {
        super.setUp()
    }
    
    func test_webService() {
        webService.fetchPopularMovies(page: 1) { (result) in
            switch result {
            case .success(_):
                XCTAssertTrue(true, "List fetched")
            case .failure(_):
                XCTAssertFalse(false, "list fetch failed")
            }
        }
    }
    
    override class func tearDown() {
        super.tearDown()
    }

}
