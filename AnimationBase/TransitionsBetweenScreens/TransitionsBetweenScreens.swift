//
//  TransitionsBetweenScreens.swift
//  AnimationBase
//
//  Created by Marcos Molero on 02/05/2019.
//  Copyright © 2019 Marcos Molero. All rights reserved.
//

import Foundation
import UIKit

class TransitionsBetweenScreens: UIViewController {
    
    let transitions: [String] = ["Music Player","Fruits"]
    let descriptions: [String] = ["This is an example programatically", "This is an example with an external library"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension TransitionsBetweenScreens: UITableViewDelegate, UITableViewDataSource{
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
            performSegue(withIdentifier: "showAlbums", sender: nil)
        case 1:
            performSegue(withIdentifier: "showFruits", sender: nil)
        default:
            break
        }
    }
}
