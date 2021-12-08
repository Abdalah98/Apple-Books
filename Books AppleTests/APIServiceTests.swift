//
//  APIServiceTests.swift
//  Books Apple
//
//  Created by Abdallah on 12/8/21.
//

import XCTest

@testable import Books_Apple

class APIServiceTests: XCTestCase {
    var sut: ApiService!

    override func setUp() {
        super.setUp()
        sut = ApiService()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
// lazm kalmt test lw m4 mowgda m4 htrun
    func test_fetch_popular_photos() {
        // Given
        let promise = XCTestExpectation(description: "Fetch Book completed")
        var responseError: Error?
        var responsePhotos: [ResultBooks]?

        // When
        guard let bundle = Bundle.unitTest.path(forResource: "stub", ofType: "json") else {
            XCTFail("Error: content not found")
            return
        }
        // hena badelo el  bundel bta3te data bta3t url
        //(url:  URL(fileURLWithPath: bundle) )
        sut.getTopFreeBook(urlString:URLS.topFreeBooks){ result in
            switch result {
            case .success(let response):
                
                responsePhotos = response.feed?.results
                promise.fulfill()

            
            case .failure(let error):
                responseError = error
                promise.fulfill()


            }

        }
        
        sut.getTopPaidBooks(urlString:URLS.topPaidBooks){ result in
            switch result {
            case .success(let response):

                responsePhotos = response.feed?.results
                promise.fulfill()


            case .failure(let error):
                responseError = error
                promise.fulfill()


            }

        }
        // hana time 1 s leh 34an m4 bta5od w2t 34an  api data m4 realy
        wait(for: [promise], timeout: .infinity)

        // Then
        XCTAssertNil(responseError)
        XCTAssertNotNil(responsePhotos)
    }
}
