//
//  IconCell.swift
//  AnimationBase
//
//  Created by Marcos Molero on 26/04/2019.
//  Copyright © 2019 Marcos Molero. All rights reserved.
//

import Foundation
import UIKit

class IconCell: UITableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    func setup(title: String, icon: String) {
        titleLabel.text = title
        iconImageView.image = UIImage(named: icon)
    }
    
}
