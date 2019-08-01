//
//  TransitionsBetweenElementsViewController.swift
//  AnimationBase
//
//  Created by Marcos Molero on 02/05/2019.
//  Copyright © 2019 Marcos Molero. All rights reserved.
//

import Foundation
import UIKit

class TransitionsBetweenElementsViewController: UIViewController {
    
    let transitions: [String] = ["Twitter", "Download", "Accept", "Burger Menú"]
    let descriptions: [String] = ["Tap on the button", "Tap on the button", "Tap on the button", "Tap on the button"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension TransitionsBetweenElementsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transitions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: LabelCell = tableView.dequeueReusableCell(withIdentifier: "labelCell") as? LabelCell {
            cell.setup(text: transitions[indexPath.row], description: descriptions[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: "showTwitter", sender: nil)
        case 1:
            performSegue(withIdentifier: "showDownload", sender: nil)
        case 2:
            performSegue(withIdentifier: "showAccept", sender: nil)
        case 3:
            performSegue(withIdentifier: "showBurger", sender: nil)
        default:
            return
        }
    }
    
}
