//
//  AcceptViewController.swift
//  AnimationBase
//
//  Created by Marcos Molero on 02/05/2019.
//  Copyright © 2019 Marcos Molero. All rights reserved.
//

import Foundation
import UIKit
import Lottie

class AcceptViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var animationView: AnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextFields()
    }
    
    private func setTextFields() {
        usernameTextField.addTarget(self, action: #selector(AcceptViewController.textFieldTouched(_:)), for: UIControl.Event.editingDidBegin)
        passwordTextField.addTarget(self, action: #selector(AcceptViewController.textFieldTouched(_:)), for: UIControl.Event.editingDidBegin)
    }
    
    private func setAnimationView(_ animationViewName: String) {
        animationView.isHidden = false
        animationView.animation = Animation.named(animationViewName)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.loopMode = .playOnce
        animationView.contentMode = .scaleAspectFit
        animationView.play()
    }
    
    @IBAction func signInTapped(_ sender: Any) {
        signInButton.isHidden = true
        if ((usernameTextField.text?.isEmpty)! && (passwordTextField.text?.isEmpty)!) {
            setAnimationView("error")
        } else {
            setAnimationView("accept")
        }
    }
    
    @objc func textFieldTouched(_ textField: UITextField) {
        animationView.isHidden = true
        animationView.stop()
        signInButton.isHidden = false
    }    
}

extension AcceptViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}
