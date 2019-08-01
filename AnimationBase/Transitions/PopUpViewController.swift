//
//  PopUpViewController.swift
//  AnimationBase
//
//  Created by Marcos Molero on 26/04/2019.
//  Copyright © 2019 Marcos Molero. All rights reserved.
//

import Foundation
import UIKit

class PopUpViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func closePopup(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: {
            print("Popup view controller successfully dismissed")
        })
    }
}
