//
//  ApiService.swift
//  Books Apple
//
//  Created by Abdallah on 12/4/21.
//

import Foundation
//https://itunes.apple.com/search?term=iPhone%20User%20Guide&entity=ebook
protocol TopFreeBookServiceProtocol {
    func getTopFreeBook(completion: @escaping (Result<TopFreeBooks , ResoneError>) -> Void)
}
//protocol SearchResultBookServiceProtocol {
//    func searchResultBook(completion: @escaping (Result<DataResult , ResoneError>) -> Void)
//}

class ApiService {
    func fetchGenericJSONData<T:Codable>(urlString:String,completion: @escaping (Result<T , ResoneError>) -> Void){
        guard let url = URL(string: urlString) else {
            completion(.failure(.invaldURL))
            return }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let _ = err {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response  = response as? HTTPURLResponse ,response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                
                return
            }
            guard let data = data else {
                completion(.failure(.invalidData))
                return }
            do {
                let objects = try JSONDecoder().decode(T.self, from: data)
                // success
                completion(.success(objects))
            } catch {
                completion(.failure(.invalidData))
            }
        }.resume()
    }
    
}

extension ApiService : TopFreeBookServiceProtocol{
    func getTopFreeBook(completion: @escaping (Result<TopFreeBooks, ResoneError>) -> Void) {
        fetchGenericJSONData(urlString:"https://rss.applemarketingtools.com/api/v2/us/books/top-free/50/books.json" , completion: completion)
        
    }
}
//extension ApiService : SearchResultBookServiceProtocol{
//    func searchResultBook(completion: @escaping (Result<DataResult, ResoneError>) -> Void) {
//        fetchGenericJSONData(urlString:"URLS.topHeadlinesCountry" , completion: completion)
//
//    }
//
//}
