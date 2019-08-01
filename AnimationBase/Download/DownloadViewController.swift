//
//  DownloadViewController.swift
//  AnimationBase
//
//  Created by Marcos Molero on 02/05/2019.
//  Copyright © 2019 Marcos Molero. All rights reserved.
//

import Foundation
import UIKit
import Lottie

class DownloadViewController: UIViewController {
    
    @IBOutlet weak var animationView: AnimationView!
    @IBOutlet weak var animatedButton: AnimatedButton!
    @IBOutlet weak var submitLabel: UILabel!
    
    private let downloadTime = 10.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setButton()
        setButtonMarkers()
    }
    
    func setButton() {
        animatedButton.animation = Animation.named("complete-without-text")
        animatedButton.setPlayRange(fromProgress: 0.22, toProgress: 1, event: .touchUpInside)
    }
    
    func setButtonMarkers() {
        animatedButton.animation = Animation.named("complete-without-text_markers")
        animatedButton.setPlayRange(fromMarker: "next", toMarker: "end", event: .touchUpInside)
    }
    
    func downloadStart() {
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.animation = Animation.named("download")
        
        animationView.play(fromFrame: 0, toFrame: 20, loopMode: .playOnce, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
            self.animationView.play(fromFrame: 20, toFrame: 160, loopMode: .loop, completion: nil)
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + downloadTime) {
            self.animationView.play(fromFrame: 160, toFrame: 180, loopMode: .playOnce, completion: nil)
        }
    }

    @IBAction func downloadButtonTapped(_ sender: UIButton) {
        downloadStart()
    }
    
    @IBAction func animatedButtonTapped(_ sender: AnimatedButton) {
        submitLabel.isHidden = true
    }
    
}
