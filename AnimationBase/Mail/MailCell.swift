//
//  TableViewCell.swift
//  GmailSelectEmailExample
//
//  Created by Anan Sadiya on 27/05/2019.
//  Copyright © 2019 Anan Sadiya. All rights reserved.
//

import UIKit

protocol MailTableViewCellDelegate: class {
    func changeMailStatus(displayEmail: DisplayMail)
}

class MailCell: UITableViewCell {
    @IBOutlet weak var flipView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    private var spinTimeInterval = 0.5
    private let backImageView: UIImageView! = UIImageView(image: UIImage(named: "back"))
    private let frontImageView: UIImageView! = UIImageView(image: UIImage(named: "front"))
    
    weak var mailTableViewCellDelegate: MailTableViewCellDelegate?
    var displayMail : DisplayMail?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(displayMail: DisplayMail, mailTableViewCellDelegate: MailTableViewCellDelegate) {
        self.mailTableViewCellDelegate = mailTableViewCellDelegate
        self.displayMail = displayMail
        self.titleLabel.text = displayMail.title
        
        changeCellBackgroundColor(displayMail)
        configureFlipView()
    }
    
    private func changeCellBackgroundColor(_ displayMail: DisplayMail) {
        self.backgroundColor = displayMail.isItemSelected ? .red : .white // Change to more accurate color
    }
    
    private func configureFlipView() {
        backImageView.frame = CGRect(x: 0, y: 0, width: flipView.frame.width, height: flipView.frame.height)
        backImageView.layer.cornerRadius = backImageView.frame.size.width / 2
        backImageView.clipsToBounds = true
        backImageView.contentMode = .scaleToFill
        
        frontImageView.frame = CGRect(x: 0, y: 0, width: flipView.frame.width, height: flipView.frame.height)
        frontImageView.layer.cornerRadius = frontImageView.frame.size.width / 2
        frontImageView.clipsToBounds = true
        frontImageView.contentMode = .scaleToFill
        
        frontImageView.isHidden = displayMail!.isItemSelected
        backImageView.isHidden = !displayMail!.isItemSelected
        
        flipView.addSubview(backImageView)
        flipView.addSubview(frontImageView)
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(flipTapped))
        flipView.addGestureRecognizer(singleTap)
    }
    
    @objc func flipTapped() {
        flip(displayEmail: displayMail!)
        changeMailStatus(displayEmail: displayMail!)
    }
    
    func flip(displayEmail: DisplayMail) {
        guard var displayMail = displayMail else { return }
        frontImageView.isHidden = !displayMail.isItemSelected
        backImageView.isHidden = displayMail.isItemSelected
        
        UIView.transition(from: displayMail.isItemSelected ? frontImageView : backImageView,
                          to: displayMail.isItemSelected ? frontImageView : backImageView,
                          duration: spinTimeInterval,
                          options: [.transitionFlipFromLeft, .showHideTransitionViews])
        
        displayMail.isItemSelected = !displayMail.isItemSelected
        self.displayMail = displayMail
        changeCellBackgroundColor(displayMail)
    }
    
    func changeMailStatus(displayEmail: DisplayMail) {
        mailTableViewCellDelegate?.changeMailStatus(displayEmail: displayEmail)
    }
}
