//
//  ApiService.swift
//  Books Apple
//
//  Created by Abdallah on 12/4/21.
//

import Foundation


class ApiService {
// Dependency Injection
     let topFreeBookURL: URL? = {
        URL(string: URLS.topFreeBooks)
    }()
    let topPaidBookURL: URL? = {
       URL(string: URLS.topPaidBooks)
   }()
    
    func fetchBooks(from url: URL?,  complete completion: @escaping ((Result<TopBook, ResoneError>) -> Void)) {
                guard let url = url else {
                    completion(.failure(.invaldURL))
                    
                    return
                }
                URLSession.shared.dataTask(with: url) { (data, response, err) in
                    if let _ = err {
                        completion(.failure(.unableToComplete))
                        return
                    }
        
                    guard response != nil  else {
                        completion(.failure(.invalidResponse))
        
                        return
                    }
                    guard let data = data else {
                        completion(.failure(.invalidData))
                        return }
                    do {
                        let objects = try JSONDecoder().decode(TopBook.self, from: data)
                        // success
                        completion(.success(objects))
                    } catch {
                        completion(.failure(.invalidData))
                    }
                }.resume()
    }

    // search
    func fetchSearch(from url: URL?, complete completion: @escaping ((Result<SearchBook, ResoneError>) -> Void)) {
                   guard let url = url else {
                       completion(.failure(.invaldURL))
                       
                       return
                   }
                   URLSession.shared.dataTask(with: url) { (data, response, err) in
                       if let _ = err {
                           completion(.failure(.unableToComplete))
                           return
                       }
           
                       guard response != nil  else {
                           completion(.failure(.invalidResponse))
           
                           return
                       }
                       guard let data = data else {
                           completion(.failure(.invalidData))
                           return }
                       do {
                           let objects = try JSONDecoder().decode(SearchBook.self, from: data)
                           // success
                           completion(.success(objects))
                       } catch {
                           completion(.failure(.invalidData))
                       }
                   }.resume()
    }
    
}

extension ApiService : ApiServiceProtocol{
    
    func getTopFreeBook(completion: @escaping (Result<TopBook, ResoneError>) -> Void) {
        fetchBooks(from: topFreeBookURL, complete: completion)
    }
  
}

extension ApiService : TopPaidBookServiceProrocol{
    
    func getTopPaidBooks(completion: @escaping (Result<TopBook, ResoneError>) -> Void) {
        fetchBooks(from: topPaidBookURL, complete: completion)
    }
    
}

extension ApiService :ApiServiceProtocolSearch{
  
    func searchResultBook(searchText: String, completion: @escaping (Result<SearchBook, ResoneError>) -> Void) {
        let searchResult: URL? = URL(string: "https://itunes.apple.com/search?term=\(searchText)Guide&entity=ebook")
         fetchSearch(from: searchResult, complete: completion)
    }

}
