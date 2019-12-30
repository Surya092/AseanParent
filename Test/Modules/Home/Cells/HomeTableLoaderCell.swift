//
//  HomeTableLoaderCell.swift
//  Test
//
//  Created by Suryanarayan Sahu on 30/12/19.
//  Copyright © 2019 Suryanarayan Sahu. All rights reserved.
//

import UIKit

class HomeTableLoaderCell: UITableViewCell {

    //Activity Indicator View
    @IBOutlet weak var activityIndicatore: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    //---Start Animating
    func startAnimating() {
        self.activityIndicatore.startAnimating()
    }
    
}
