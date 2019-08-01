//
//  PlayerViewController.swift
//  AnimationBase
//
//  Created by Marcos Molero on 29/04/2019.
//  Copyright © 2019 Marcos Molero. All rights reserved.
//

import Foundation
import UIKit

class PlayerViewController: UIViewController {
    
    @IBOutlet weak var artworkImageView: UIImageView!
    
    public var song : Song?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let song = self.song {
            artworkImageView.image = song.artwork
        }
    }
}
