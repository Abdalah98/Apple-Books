//
//  Constant.swift
//  Breaking Bad
//
//  Created by Abdallah on 6/15/21.
//

import Foundation

enum URLS {
    
    private  static let country            = "us"
    private  static let resultsLimit       = "50"
    private  static let mediaType          = "books"
    private  static let main               = "https://rss.applemarketingtools.com"
    private  static let entity             =  main + "/api/v2/\(country)/\(mediaType)/"
    
    static let topPaidBooks       = entity + "/top-paid/\(resultsLimit)//books.json"
    static let topFreeBooks       = entity + "/top-free/\(resultsLimit)//books.json"
}



enum Constant{
    
    static let SearchCell             = "SearchCell"
    static let BookStoreCell          = "BookStoreCell"
    static let SearchDetails          = "show"
    static let TopBookDetails         = "show"

}
