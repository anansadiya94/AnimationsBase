//
//  PagesViewController.swift
//  AnimationBase
//
//  Created by Marcos Molero on 29/04/2019.
//  Copyright © 2019 Marcos Molero. All rights reserved.
//

import Foundation
import UIKit

class PagesViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func skipButtonTapped(_ sender: UIButton) {
        sender.removeFromSuperview()
        containerView.removeFromSuperview()
    }
}
