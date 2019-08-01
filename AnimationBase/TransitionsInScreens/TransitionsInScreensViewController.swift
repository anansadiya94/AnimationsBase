//
//  TransitionsInScreensViewController.swift
//  AnimationBase
//
//  Created by Anan Sadiya on 29/05/2019.
//  Copyright © 2019 Marcos Molero. All rights reserved.
//

import UIKit

class TransitionsInScreensViewController: UIViewController {
    let transitions: [String] = ["Motion", "Mail"]
    let descriptions: [String] = ["Tap on the button", "Tap on the button"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
   }
}

extension TransitionsInScreensViewController: UITableViewDelegate, UITableViewDataSource {
    
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
            performSegue(withIdentifier: "showMotion", sender: nil)
        case 1:
            performSegue(withIdentifier: "showMail", sender: nil)
        default:
            return
        }
    }
    
}
