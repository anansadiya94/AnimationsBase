//
//  FruitViewController.swift
//  AnimationBase
//
//  Created by Marcos Molero on 30/04/2019.
//  Copyright © 2019 Marcos Molero. All rights reserved.
//

import Foundation
import UIKit
import ImageTransition

class FruitViewController: UIViewController {
    
    @IBOutlet weak var fruitImageView: UIImageView!
    
    var dependency: Dependency?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let dependency = dependency else { return }
        fruitImageView.image = dependency.image
        
        fruitImageView.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageViewDidTapped))
        fruitImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func imageViewDidTapped() {
        dismiss(animated: true, completion: nil)
    }
}

extension FruitViewController: ImageTransitionable {
    var imageViewForTransition: UIImageView? {
        return fruitImageView
    }
}

struct Dependency {
    var image: UIImage
}
