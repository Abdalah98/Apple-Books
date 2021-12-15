//
//  ApiServiceProtocol.swift
//  Books Apple
//
//  Created by Abdallah on 12/14/21.
//

import Foundation

//protocol FetchBooks {
//    func fetchBooks(from url: URL?, complete: @escaping ((Result<TopBook , ResoneError>) -> Void))
//}


protocol ApiServiceProtocol {
    func getTopFreeBook(completion: @escaping (Result<TopBook , ResoneError>) -> Void)
    func fetchBooks(from url: URL?, complete: @escaping ((Result<TopBook , ResoneError>) -> Void))

}

protocol TopPaidBookServiceProrocol {
    func getTopPaidBooks(completion: @escaping (Result<TopBook , ResoneError>) -> Void)
}

protocol ApiServiceProtocolSearch {
    func fetchSearch(from url: URL?, complete: @escaping ((Result<SearchBook , ResoneError>) -> Void))
    func searchResultBook(searchText:String,completion: @escaping (Result<SearchBook , ResoneError>) -> Void)
}
//protocol TopPaidBookServiceProrocol {
//    func getTopPaidBooks(completion: @escaping (Result<TopBook , ResoneError>) -> Void)
//}
//
//protocol FetchSearch {
//    func fetchSearch(from url: URL?, complete: @escaping ((Result<SearchBook , ResoneError>) -> Void))
//}
//
//protocol SearchBookServiceProtocol {
//    func searchResultBook(searchText:String,completion: @escaping (Result<SearchBook , ResoneError>) -> Void)
//}
