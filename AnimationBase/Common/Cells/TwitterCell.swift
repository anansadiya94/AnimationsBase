//
//  TwitterCell.swift
//  AnimationBase
//
//  Created by Marcos Molero on 03/05/2019.
//  Copyright © 2019 Marcos Molero. All rights reserved.
//

import Foundation
import UIKit
import Lottie

class TwitterCell: UITableViewCell {
    
    @IBOutlet weak var likeButton: AnimatedButton!
    @IBOutlet weak var doneButton: AnimatedButton!
    @IBOutlet weak var trashButton: AnimatedButton!
    
    @IBOutlet weak var likeButtonLabel: UILabel!
    @IBOutlet weak var doneButtonLabel: UILabel!
    @IBOutlet weak var trashButtonLabel: UILabel!
    
    @IBOutlet weak var twitterImage: UIImageView!
    
    
    func setup(image: UIImage) {
        twitterImage.image = image
    }
    
    func setupButtons() {
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        /// Set an animation on the button.
        likeButton.animation = Animation.named("TwitterHeartOne")
        
        /// Turn off clips to bounds, as the animation goes outside of the bounds.
        likeButton.clipsToBounds = true
        
        /// Set animation play ranges for touch states
        likeButton.setPlayRange(fromMarker: "touchDownStart", toMarker: "touchDownEnd", event: .touchDown)
        likeButton.setPlayRange(fromMarker: "touchDownEnd", toMarker: "touchUpCancel", event: .touchUpOutside)
        likeButton.setPlayRange(fromMarker: "touchDownEnd", toMarker: "touchUpEnd", event: .touchUpInside)
        
        
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        /// Set an animation on the button.
        doneButton.animation = Animation.named("TwitterHeartTwo")
        
        /// Turn off clips to bounds, as the animation goes outside of the bounds.
        doneButton.clipsToBounds = true
        
        /// Set animation play ranges for touch states
        doneButton.setPlayRange(fromMarker: "touchDownStart", toMarker: "touchDownEnd", event: .touchDown)
        doneButton.setPlayRange(fromMarker: "touchDownEnd", toMarker: "touchUpCancel", event: .touchUpOutside)
        doneButton.setPlayRange(fromMarker: "touchDownEnd", toMarker: "touchUpEnd", event: .touchUpInside)
    
    
        trashButton.translatesAutoresizingMaskIntoConstraints = false
        /// Set an animation on the button.
        trashButton.animation = Animation.named("TwitterLike")
        
        /// Turn off clips to bounds, as the animation goes outside of the bounds.
        trashButton.clipsToBounds = true
        
        
        /// Set animation play ranges for touch states
        trashButton.setPlayRange(fromMarker: "touchDownStart", toMarker: "touchDownEnd", event: .touchDown)
        trashButton.setPlayRange(fromMarker: "touchDownEnd", toMarker: "touchUpCancel", event: .touchUpOutside)
        trashButton.setPlayRange(fromMarker: "touchDownEnd", toMarker: "touchUpEnd", event: .touchUpInside)
    
    }
}
