//
//  TransitionsViewController.swift
//  AnimationBase
//
//  Created by Marcos Molero on 26/04/2019.
//  Copyright © 2019 Marcos Molero. All rights reserved.
//

import Foundation
import UIKit

class TransitionsViewController: UIViewController {
    
    let transitions: [String] = ["Show segue", "Show Detail Segue", "Modal Segue", "Popup Segue", "Split View Controller", "Tab Bar View Controller", "Boostrap Modal", "Custom Navigation Bar"]
    let icons: [String] = ["push","replace","modal","popup","splitvc","tabbarvc","bootstrap","push"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
}

extension TransitionsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transitions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: IconCell = tableView.dequeueReusableCell(withIdentifier: "iconCell") as? IconCell {
            cell.setup(title: transitions[indexPath.row], icon: icons[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: "showPush", sender: nil)
        case 1:
            performSegue(withIdentifier: "showDetail", sender: nil)
        case 2:
            performSegue(withIdentifier: "showModally", sender: nil)
        case 3:
             performSegue(withIdentifier: "showPopUp", sender: nil)
        case 4:
            performSegue(withIdentifier: "showSplitVC", sender: nil)
        case 5:
            performSegue(withIdentifier: "showTabBar", sender: nil)
        case 6:
            if let bootsrapViewController = UIStoryboard(name: "Transitions", bundle: nil).instantiateViewController(withIdentifier: "bootsrapViewController") as? BootsrapViewController {
                bootsrapViewController.modalPresentationStyle = .overCurrentContext
                bootsrapViewController.modalTransitionStyle = .crossDissolve
                bootsrapViewController.providesPresentationContextTransitionStyle = true
                bootsrapViewController.definesPresentationContext = true
                bootsrapViewController.message = "Congratulations! You just learned how to trigger a bootstrap-style modal."
                self.present(bootsrapViewController, animated: true, completion: nil)
            }
        default:
            return
        }
    }
    
    @IBAction func unwindToMainScreen(segue: UIStoryboardSegue) {
        print("Unwind segue to main screen activated!")
    }
}
