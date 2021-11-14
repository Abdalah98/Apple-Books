//
//  NetworkManger.swift
//  News
//
//  Created by Abdallah on 8/4/21.
//

import Foundation

class NetworkManger {
    
    static let shared = NetworkManger()
    
//
//
//    func getTopHeadlinesCountry(completion: @escaping (Result<TopHeadlinesCountry , ResoneError>) -> Void){
//        fetchGenericJSONData(urlString:URLS.topHeadlinesCountry , completion: completion)
//    }
//
//
//    func getTopHeadlinesSources(completion: @escaping (Result<TopHeadlinesSources , ResoneError>) -> Void){
//
//        fetchGenericJSONData(urlString: URLS.topHeadlinesSources, completion: completion)
//    }
//
//
//    func searchAllEverything(searchText:String,completion: @escaping (Result<TopHeadlinesCountry , ResoneError>) -> Void){
//        let urlString = URLS.main +  "everything?q=\(searchText)&from=2021-08-13&sortBy=popularity&apiKey=" + URLS.apiKey
//        fetchGenericJSONData(urlString: urlString, completion: completion)
//    }
    
    
    
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
    }}
