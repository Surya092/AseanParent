//
//  HomeDataModel.swift
//  Test
//
//  Created by Suryanarayan Sahu on 30/12/19.
//  Copyright © 2019 Suryanarayan Sahu. All rights reserved.
//

import Foundation
import ObjectMapper

//---DealModel Class
class HomeDataModel: Mappable {
    
    var page: Int?
    var total_pages: Int?
    var total_results: Int?
    var results: [MovieItem]?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        page      <- map["page"]
        results   <- map["results"]
        total_pages <- map["total_pages"]
        total_results <- map["total_results"]
    }
}

//Items
class MovieItem: Mappable {
    
    var poster_path: String?
    var media_type: String?
    var backdrop_path: String?
    var genre_ids: [Int]?
    var vote_count: Int?
    var overview: String?
    var original_title: String?
    var vote_average: Int?
    var popularity: Int?
    var id: Int?
    var original_language: String?
    var release_date: String?
    var video: Bool?
    var title: String?
    var adult: Bool?
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        poster_path <- map["poster_path"]
        media_type  <- map["media_type"]
        backdrop_path <- map["backdrop_path"]
        genre_ids <- map["genre_ids"]
        vote_count <- map["vote_count"]
        overview <- map["overview"]
        original_title <- map["original_title"]
        vote_average <- map["vote_average"]
        popularity <- map["popularity"]
        id <- map["id"]
        original_language <- map["original_language"]
        release_date <- map["release_date"]
        video <- map["video"]
        title <- map["title"]
        adult <- map["adult"]
    }
}
