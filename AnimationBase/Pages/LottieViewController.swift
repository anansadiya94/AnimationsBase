//
//  LottieOneViewController.swift
//  AnimationBase
//
//  Created by Anan Sadiya on 29/04/2019.
//  Copyright © 2019 Marcos Molero. All rights reserved.
//

import UIKit
import Lottie

class LottieViewController: UIViewController {

    //@IBOutlet weak var lottieOneAnimation: AnimationView!
    
    var lottieName: String = ""
    var lottieAnimation = AnimationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLottieAnimation(lottieName: lottieName)
    }
    
    func setLottieAnimation(lottieName: String) { // TODO: Implement on Storyboard
        lottieAnimation.animation = Animation.named(lottieName)
        lottieAnimation.translatesAutoresizingMaskIntoConstraints = false
        lottieAnimation.loopMode = .loop
        lottieAnimation.contentMode = .scaleAspectFit
        view.addSubview(lottieAnimation)
        let horizontalConstraint = lottieAnimation.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let verticalConstraint = lottieAnimation.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        let widthConstraint = lottieAnimation.widthAnchor.constraint(equalToConstant: 400)
        let heightConstraint = lottieAnimation.heightAnchor.constraint(equalToConstant: 400)
        view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
        lottieAnimation.play()
    }
}
