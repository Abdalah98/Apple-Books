//
//  APIServiceMock.swift
//  Books AppleTests
//
//  Created by Abdallah on 12/15/21.
//

import Foundation
import Foundation
@testable import Books_Apple
// The mock APIService(APIServiceMock) object doesn’t connect to the real server,
// it’s an object designed only for the test.
// Both APIServiceand APIServiceMock conform to APIServiceProtocol,
// so that we are able to inject different dependency in different situation.
class APIServiceMock: ApiServiceProtocol{
    var fetchTopBooksIsCalled = false
    var fetchBookIsCalled = false

    var books :TopBook?
    
    var completeClosure: ((Result<TopBook , ResoneError>) -> ())!
    
    func getTopFreeBook(completion: @escaping (Result<TopBook, ResoneError>) -> Void) {
        fetchTopBooksIsCalled = true
        completeClosure = completion
    }
    
    func fetchBooks(from url: URL?, complete: @escaping ((Result<TopBook, ResoneError>) -> Void)) {
        fetchBookIsCalled = true

    }
    
  
//
//    func fetchSuccess() {
//        completeClosure(.success(books ))
//    }
//
    func fetchFail(error: ResoneError?) {
        completeClosure(.failure(error! )!)
    }
}
