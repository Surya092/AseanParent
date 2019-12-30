//
//  HomeTableViewCell.swift
//  Test
//
//  Created by Suryanarayan Sahu on 30/12/19.
//  Copyright © 2019 Suryanarayan Sahu. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    //Image View
    @IBOutlet weak var cellImageView: UIImageView!
    
    //Label
    @IBOutlet weak var label: UILabel!
    
    weak var viewModel: HomeCellViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupData(model: HomeCellViewModel) {
       
        //Assign Model to ViewModel
        viewModel = model
        
        //Update UI for the View
        self.cellImageView.loadImage(fromUrl: viewModel?.imageURL ?? "")
        
        //Set Title
        label.text = model.title
        
    }
    
}
