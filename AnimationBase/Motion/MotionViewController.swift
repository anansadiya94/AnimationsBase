//
//  MotionViewController.swift
//  AnimationBase
//
//  Created by Marcos Molero on 06/05/2019.
//  Copyright © 2019 Marcos Molero. All rights reserved.
//

import Foundation
import UIKit

class MotionViewController: UIViewController {
    
    @IBOutlet weak var motionCollectionView: UICollectionView!
    @IBOutlet weak var cartBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var sbLabel: UILabel!
    @IBOutlet weak var sbButton: UIButton!
    
    private let margin: CGFloat = 1
    private let column: CGFloat = 3
    
    private var labelBadge = UILabel.init(frame: CGRect.init(x: 20, y: 0, width: 15, height: 15))
    private var countBadge = 0
    
    var fruits: [Fruit] = [Fruit(name: "Apple", image: UIImage(named: "apple")!),
                           Fruit(name: "Kiwi", image: UIImage(named: "kiwi")!),
                           Fruit(name: "Lemon", image: UIImage(named: "lemon")!),
                           Fruit(name: "Orange", image: UIImage(named: "orange")!),
                           Fruit(name: "Strawberry", image: UIImage(named: "strawberry")!),
                           Fruit(name: "Tomato", image: UIImage(named: "tomato")!)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fruits.append(contentsOf: fruits + fruits + fruits)
        motionCollectionView.reloadData()
        performAction()
        setBadge()
    }
    
    func setBadge() {
        labelBadge.backgroundColor = .red
        labelBadge.clipsToBounds = true
        labelBadge.layer.cornerRadius = 5
        labelBadge.textColor = UIColor.white
        labelBadge.textAlignment = .center
        labelBadge.adjustsFontSizeToFitWidth = true
    }
    
    func performAction() {
        animate(
            sbLabel.animate(
                .fadeIn(duration: 1),
                .move(byX: 0, byY: -50, duration: 1)
            )
        )
        animate(
            sbButton.animate(
                .fadeIn(duration: 1)
            )
        )
//        sbButton.translatesAutoresizingMaskIntoConstraints = true
//        sbLabel.translatesAutoresizingMaskIntoConstraints = true
    }
    
    @IBAction func sbButtonTapped(_ sender: Any) {
        animate(
            sbLabel.animate(
                .fadeOut(duration: 1),
                .move(byX: 0, byY: 50, duration: 1)
            )
        )
        
        animate(
            sbButton.animate(
                .fadeOut(duration: 1)
            )
        )
        
        animate(
            motionCollectionView.animate(
                .fadeIn(duration: 1)
            )
        )
    }
}

extension MotionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fruits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell: ImageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as? ImageCell {
            cell.setup(image: fruits[indexPath.row].image)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let barButtonItem = self.navigationItem.rightBarButtonItem!
        let buttonItemView = barButtonItem.value(forKey: "view") as! UIView
        let cell = collectionView.cellForItem(at: indexPath) as! ImageCell
        let imageViewPosition: CGPoint = cell.customImageView.convert(cell.bounds.origin, to: self.view)
        let animatedImageView = UIImageView(frame: CGRect(x: imageViewPosition.x, y: imageViewPosition.y, width: cell.customImageView.frame.size.width, height: cell.customImageView.frame.size.height))
        animatedImageView.image = cell.customImageView.image
        animatedImageView.contentMode = .scaleAspectFill
        self.view.addSubview(animatedImageView)
        performAnimation(animatedImageView: animatedImageView, barButtonView: buttonItemView)
    }
    
    func performAnimation(animatedImageView: UIImageView, barButtonView: UIView) {
        animate(
            animatedImageView.animate(inParallel: [
                .move(toX: view.frame.maxX, toY: 0, duration: 0.5),
                .resize(to: animatedImageView.frame.size / 2, duration: 0.5),
                .fadeOut(duration: 0.5)
                ])
        )
        
        animate(
            barButtonView.animate(
                .scale(x: 2, y: 2, duration: 0.1),
                .scale(x: 1, y: 1, duration: 0.1)
            )
        )
        addBadgeToCart(withValue: 1, barButtonView: barButtonView)
    }
    
    func addBadgeToCart(withValue value: Int, barButtonView: UIView) {
        countBadge += value
        labelBadge.text = String(countBadge)
        barButtonView.addSubview(labelBadge)
    }
}

extension MotionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - margin * (column + 1)) / column
        return CGSize(width: width, height: width * 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return margin
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return margin
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
    }
}


