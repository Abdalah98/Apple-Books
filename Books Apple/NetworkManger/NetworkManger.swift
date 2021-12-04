//
//  NetworkManger.swift
//  News
//
//  Created by Abdallah on 8/4/21.
//

import Foundation
import Alamofire
class NetworkManger {
    
      static let shared = NetworkManger()
    
    func getTopFreeBook(completion: @escaping (Result<TopFreeBooks , ResoneError>) -> Void)
    {
    fetchGenericJSONData(urlString:"https://rss.applemarketingtools.com/api/v2/us/books/top-free/50/books.json" , completion: completion)

    }
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
        func searchBooks(searchText:String,completion: @escaping (Result<SearchBook , ResoneError>) -> Void){
//            let urlString = URLS.main +  "everything?q=\(searchText)&from=2021-08-13&sortBy=popularity&apiKey=" + URLS.apiKey
            let urlString =
                "https://itunes.apple.com/search?term=\(searchText)&entity=ebook"
            fetchGenericJSONData(urlString: urlString, completion: completion)
        }
    
    //af
    
    
    //
    //    func fetchGenericJSONData<T:Codable>(urlString:String,completion:  @escaping (Result<T , ResoneError>) -> Void){
    //        guard let url = URL(string: urlString) else {
    //            completion(.failure(.invaldURL))
    //            return }
    //        AF.request(url,method: .get,encoding: URLEncoding.default).responseData { dataRespnse in
    //            guard let response  = dataRespnse as? HTTPURLResponse ,response.statusCode == 200 else {
    //                            completion(.failure(.invalidResponse))
    //
    //                            return
    //                        }
    ////            if let err      = dataRespnse.error{
    ////                print(err.localizedDescription)
    ////                return
    ////            }
    //            if let _ = dataRespnse.error {
    //                completion(.failure(.unableToComplete))
    //                return
    //            }
    //
    //         //   guard let data = dataRespnse.data else{return}
    //            guard let data = dataRespnse.data else {
    //                completion(.failure(.invalidData))
    //                return }
    ////            do{
    ////                let encoder = JSONDecoder()
    ////                let episode = try encoder.decode(T.self, from: data)
    ////                completion(episode)
    ////
    ////            }catch let error {
    ////                print(error.localizedDescription)
    ////            }
    //
    //
    //            do {
    //                let objects = try JSONDecoder().decode(T.self, from: data)
    //                // success
    //                completion(.success(objects))
    //            } catch {
    //                completion(.failure(.invalidData))
    //            }
    //
    //        }
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
    }
    
}
////https://itunes.apple.com/search?term=iPhone%20User%20Guide&entity=ebook
//protocol TopFreeBookServiceProtocol {
//    func getTopFreeBook(completion: @escaping (Result<TopFreeBooks , ResoneError>) -> Void)
//}
////protocol SearchResultBookServiceProtocol {
////    func searchResultBook(completion: @escaping (Result<DataResult , ResoneError>) -> Void)
////}
//
//class ApiService {
//    func fetchGenericJSONData<T:Codable>(urlString:String,completion: @escaping (Result<T , ResoneError>) -> Void){
//        guard let url = URL(string: urlString) else {
//            completion(.failure(.invaldURL))
//            return }
//        URLSession.shared.dataTask(with: url) { (data, response, err) in
//            if let _ = err {
//                completion(.failure(.unableToComplete))
//                return
//            }
//            
//            guard let response  = response as? HTTPURLResponse ,response.statusCode == 200 else {
//                completion(.failure(.invalidResponse))
//                
//                return
//            }
//            guard let data = data else {
//                completion(.failure(.invalidData))
//                return }
//            do {
//                let objects = try JSONDecoder().decode(T.self, from: data)
//                // success
//                completion(.success(objects))
//            } catch {
//                completion(.failure(.invalidData))
//            }
//        }.resume()
//    }
//    
//}
//
//extension ApiService : TopFreeBookServiceProtocol{
//    func getTopFreeBook(completion: @escaping (Result<TopFreeBooks, ResoneError>) -> Void) {
//        fetchGenericJSONData(urlString:"https://rss.applemarketingtools.com/api/v2/us/books/top-free/50/books.json" , completion: completion)
//        
//    }
//}
////extension ApiService : SearchResultBookServiceProtocol{
////    func searchResultBook(completion: @escaping (Result<DataResult, ResoneError>) -> Void) {
////        fetchGenericJSONData(urlString:"URLS.topHeadlinesCountry" , completion: completion)
////        
////    }
////    
////}
