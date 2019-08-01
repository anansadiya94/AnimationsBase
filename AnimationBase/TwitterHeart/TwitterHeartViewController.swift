//
//  TwitterHeartViewController.swift
//  AnimationBase
//
//  Created by Marcos Molero on 30/04/2019.
//  Copyright © 2019 Marcos Molero. All rights reserved.
//

import Foundation
import UIKit
import Lottie

class TwitterHeartViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
   
    @IBAction func twitterButtonTapped(_ sender: AnimatedButton) {
        print("Like!")
    }
}

extension TwitterHeartViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 14
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: TwitterCell = tableView.dequeueReusableCell(withIdentifier: "twitterCell") as? TwitterCell {
            cell.setupButtons()
            cell.setup(image: UIImage(named: "lemon")!)
            return cell
        }
        return UITableViewCell()
    }
}
