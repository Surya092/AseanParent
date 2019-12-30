//
//  HomeViewModel.swift
//  Test
//
//  Created by Suryanarayan Sahu on 30/12/19.
//  Copyright © 2019 Suryanarayan Sahu. All rights reserved.
//

import Foundation
import ObjectMapper

class HomeViewModel: NSObject {
    
    //Network Manager Instance
    var networkManager = NetworkManager()
    
    //Cell Data Models
    var items = [HomeCellViewModel]()
    
    //Semaphore
    var semaphore = DispatchSemaphore(value: 1)
    
    //Set up Default Values for Page, Result and Current Page Data
    var totalPages = 0
    var totalResults = 0
    var currentPage = 0
    
    //---Set up Data
    func setupData(data: HomeDataModel) {
        
        //Set up Values received in API
        totalPages = data.total_pages ?? totalPages
        currentPage = data.page ?? currentPage
        totalResults = data.total_results ?? totalResults
        
        //---Set up Cell Data model
        if let response = data.results {
            for movieItem in response {
                items.append(HomeCellViewModel(item: movieItem))
            }
        }
        
    }
}

extension HomeViewModel {
    
    //---Perform Login
    func fetchPageData(pageId: Int, completionHandler: ((HomeDataModel?,Error?, Int?) -> ())? = nil) {
        semaphore.wait()
        let apiEndPoint = String.init(format: Constant.ApiEndPoint.fetchMovies,Constant.Domain.apiKey,"\(pageId)")
        if currentPage == pageId {
            completionHandler?(nil,nil,nil)
        }
        self.networkManager.cancelTask()
        self.networkManager.getData(withApiEndpoint: apiEndPoint) {(data, response, error) in
            self.semaphore.signal()
            var responseStatusCode: Int?
            if let httpResponse = response as? HTTPURLResponse {
                responseStatusCode = httpResponse.statusCode
            }
            if error != nil {
                DispatchQueue.main.async {
                    completionHandler?(nil, error, responseStatusCode)
                }
            } else {
                if let responseString = String(data: data ?? Data(), encoding: .utf8) {
                    let response = Mapper<HomeDataModel>().map(JSONString: responseString)
                    DispatchQueue.main.async {
                        completionHandler?(response, nil, responseStatusCode)
                    }
                } else {
                    DispatchQueue.main.async {
                        completionHandler?(nil, error, responseStatusCode)
                    }
                }
            }
        }
    }
}
