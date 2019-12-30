//
//  PublicEnum.swift
//  Test
//
//  Created by Suryanarayan Sahu on 30/12/19.
//  Copyright © 2019 Suryanarayan Sahu. All rights reserved.
//

import Foundation

enum RequestType: String {
    case Put = "PUT"
    case Post = "POST"
    case Get = "GET"
    case Delete = "DELETE"
}

enum CellIdentifier: String {
    case HomeTableViewCell = "HomeTableViewCell"
    case HomeTableLoaderCell = "HomeTableLoaderCell"
}

enum HomeCellType {
    case Data
    case Loader
}
