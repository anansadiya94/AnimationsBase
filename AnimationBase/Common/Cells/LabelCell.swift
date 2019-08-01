//
//  LabelCell.swift
//  AnimationBase
//
//  Created by Marcos Molero on 25/04/2019.
//  Copyright © 2019 Marcos Molero. All rights reserved.
//

import Foundation
import UIKit

class LabelCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    func setup(text: String, description: String) {
        nameLabel.text = text
        descriptionLabel.text = description
    }
    
}
