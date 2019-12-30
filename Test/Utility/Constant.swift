//
//  Constant.swift
//  Test
//
//  Created by Suryanarayan Sahu on 30/12/19.
//  Copyright © 2019 Suryanarayan Sahu. All rights reserved.
//

import Foundation

public struct Constant {
    
    struct Domain {
         static let host = "https://api.themoviedb.org/3"
         static let apiKey = "8eac22f4c24d01c480e4d99fef2edfc3"
    }
    
    //--- API EndPoint
    struct ApiEndPoint {
        static let fetchMovies = Domain.host + "/trending/movie/week?api_key=%@&page=%@"
        static let fetchMovie = Domain.host + "/movie/%@?api_key=%@"
        static let imagURL = Domain.host + "%@?api_key=%@"
    }
    
}
