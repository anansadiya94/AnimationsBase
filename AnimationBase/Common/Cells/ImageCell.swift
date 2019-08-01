//
//  AlbumsCell.swift
//  AnimationBase
//
//  Created by Marcos Molero on 29/04/2019.
//  Copyright © 2019 Marcos Molero. All rights reserved.
//

import Foundation
import UIKit

class ImageCell: UICollectionViewCell {
    
    @IBOutlet weak var customImageView: UIImageView!
    
    func setup(image: UIImage) {
        customImageView.image = image
    }
}
