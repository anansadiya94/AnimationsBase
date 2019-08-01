//
//  BurgerViewController.swift
//  AnimationBase
//
//  Created by Marcos Molero on 02/05/2019.
//  Copyright © 2019 Marcos Molero. All rights reserved.
//

import Foundation
import UIKit
import Lottie

struct ExpandableNames {
    var isExpanded: Bool
    let names: [String]
}

class BurgerViewController: UIViewController {
    
    @IBOutlet weak var contactsTableView: UITableView!
    
    var isBurgerOpen: Bool = true
    let lottieButton = AnimatedButton()
    private let originProgress : CGFloat = 0.0
    private let midProgress : CGFloat = 0.5
    private let endProgress : CGFloat = 1.0
    
    var contactNames = [
        ExpandableNames(isExpanded: true, names: ["Amy", "Bill", "Zack", "Steve", "Jack", "Jill", "Mary"]),
        ExpandableNames(isExpanded: true, names: ["Carl", "Chris", "Christina", "Cameron"]),
        ExpandableNames(isExpanded: true, names: ["David", "Dan"]),
        ExpandableNames(isExpanded: true, names: ["Patrick", "Patty"]),
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Contacts"
//        navigationController?.navigationBar.prefersLargeTitles = true
        setRightTabBarButton()
    }
    
    private func setRightTabBarButton() {
        lottieButton.translatesAutoresizingMaskIntoConstraints = false
        lottieButton.animation = Animation.named("burger")
        lottieButton.addTarget(self, action: #selector(BurgerViewController.burgerTouched(_:)), for: .touchUpInside)
        lottieButton.setPlayRange(fromProgress: originProgress, toProgress: midProgress, event: .touchUpInside)

        let rightNavBarButton = UIBarButtonItem(customView: lottieButton)
        rightNavBarButton.customView?.translatesAutoresizingMaskIntoConstraints = false
        rightNavBarButton.customView?.heightAnchor.constraint(equalToConstant: 24).isActive = true
        rightNavBarButton.customView?.widthAnchor.constraint(equalToConstant: 24).isActive = true
        navigationItem.rightBarButtonItem = rightNavBarButton
    }
    
    @IBAction func backTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func burgerTouched(_ sender: AnimatedButton) {
        if isBurgerOpen {
            isBurgerOpen = false
            lottieButton.setPlayRange(fromProgress: midProgress, toProgress: endProgress, event: .touchUpInside)
        } else {
            isBurgerOpen = true
            lottieButton.setPlayRange(fromProgress: originProgress, toProgress: midProgress, event: .touchUpInside)
        }
    }
}


extension BurgerViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .yellow
        let animatedButton = AnimatedButton()
        animatedButton.translatesAutoresizingMaskIntoConstraints = false
        animatedButton.animation = Animation.named("expandedListMarkers")
        animatedButton.addTarget(self, action: #selector(handleExpandCloseAnimatedButton), for: .touchUpInside)
        animatedButton.setPlayRange(fromMarker: "zero", toMarker: "mid", event: .touchUpInside)
        animatedButton.tag = section
        
        view.addSubview(animatedButton)
        let trailingConstraint = animatedButton.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        let widthConstraint = animatedButton.widthAnchor.constraint(equalToConstant: 50)
        let heightConstraint = animatedButton.heightAnchor.constraint(equalToConstant: 50)
        view.addConstraints([trailingConstraint, widthConstraint, heightConstraint])
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return contactNames.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !contactNames[section].isExpanded {
            return 0
        }
        
        return contactNames[section].names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: LabelCell = tableView.dequeueReusableCell(withIdentifier: "labelCell") as? LabelCell {
            cell.setup(text: contactNames[indexPath.section].names[indexPath.row], description: "")
            return cell
        }
        return UITableViewCell()
    }
    
    @objc func handleExpandCloseAnimatedButton(animatedButton: AnimatedButton) {
        let section = animatedButton.tag

        var indexPaths = [IndexPath]()
        for row in contactNames[section].names.indices {
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }

        let isExpanded = contactNames[section].isExpanded
        contactNames[section].isExpanded = !isExpanded

        if isExpanded {
            animatedButton.setPlayRange(fromMarker: "mid", toMarker: "end", event: .touchUpInside)
            contactsTableView.deleteRows(at: indexPaths, with: .fade)
        } else {
            animatedButton.setPlayRange(fromMarker: "zero", toMarker: "mid", event: .touchUpInside)
            contactsTableView.insertRows(at: indexPaths, with: .fade)
        }
    }
}
