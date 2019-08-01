//
//  ModalUnwindSegueViewController.swift
//  AnimationBase
//
//  Created by Marcos Molero on 26/04/2019.
//  Copyright © 2019 Marcos Molero. All rights reserved.
//

import Foundation
import UIKit

class ModalUnwindSegueViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true) {
            print("The modal view controller was dismissed")
        }
    }
}
