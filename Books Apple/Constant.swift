//
//  Constant.swift
//  Breaking Bad
//
//  Created by Abdallah on 6/15/21.
//

import Foundation

enum URLS {
    
    static let country            = "us"
    static let resultsLimit       = "50"
    static let mediaType          = "books"

    static let main               = "https://rss.applemarketingtools.com"
    static let entity             =  main + "/api/v2/\(country)/\(mediaType)/"
    
    static let topPaidBooks       = entity + "/top-paid/\(resultsLimit)//books.json"
    static let topFreeBooks       = entity + "/top-free/\(resultsLimit)//books.json"
}



enum Constant{
    
    static let SearchCell             = "SearchCell"
    static let BookStoreCell          = "BookStoreCell"
    static let SearchDetails          = "show"
    static let TopBookDetails          = "show"

}
