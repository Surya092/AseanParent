//
//  HomeCellViewModel.swift
//  Test
//
//  Created by Suryanarayan Sahu on 30/12/19.
//  Copyright © 2019 Suryanarayan Sahu. All rights reserved.
//

import Foundation

class HomeCellViewModel: NSObject {
    
    //cellType
    var cellType = HomeCellType.Data
    
    //Image URL
    var imageURL: String?
    
    //Data
    var title: String?
    
    override init() {
        super.init()
    }
    
    convenience init(item: MovieItem) {
        self.init()
        
        //Set Data
        self.imageURL = String.init(format: Constant.ApiEndPoint.imagURL, item.backdrop_path ?? "", Constant.Domain.apiKey)
        
        //Set About
        self.title = item.original_title
    }
    
}
