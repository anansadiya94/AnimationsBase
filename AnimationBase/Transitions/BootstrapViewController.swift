//
//  BootstrapViewController.swift
//  AnimationBase
//
//  Created by Marcos Molero on 26/04/2019.
//  Copyright © 2019 Marcos Molero. All rights reserved.
//

import Foundation
import UIKit

class BootsrapViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    var message = "Hey there! I'm a bootstrap style modal view controller!"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        containerView.layer.cornerRadius = 8.0
        containerView.layer.masksToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.messageLabel.text = message
    }
    
    @IBAction func closeThisViewController(_ sender: UIButton) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
}
