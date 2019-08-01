//
//  ShowedAsDetailViewController.swift
//  AnimationBase
//
//  Created by Anan Sadiya on 29/04/2019.
//  Copyright © 2019 Marcos Molero. All rights reserved.
//

import UIKit

class ShowedAsDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func goBack(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: {
            print("Modal view controller was dismissed!")
        })
    }
    
    @IBAction func unwindToMainScreen(segue: UIStoryboardSegue) {
        print("Unwind segue to main screen activated!")
    }
}
