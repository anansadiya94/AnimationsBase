//
//  FruitsViewController.swift
//  AnimationBase
//
//  Created by Marcos Molero on 30/04/2019.
//  Copyright © 2019 Marcos Molero. All rights reserved.
//

import Foundation
import UIKit
import ImageTransition

class FruitsViewController: UIViewController {
    
    @IBOutlet weak var fruitsCollectionView: UICollectionView!
    private let margin: CGFloat = 1
    private let column: CGFloat = 3
    
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
        fruitsCollectionView.reloadData()
    }
    
    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        if (parent == nil) {
            self.navigationController?.delegate = nil
        }
    }
    
    private func selectedCell() -> ImageCell? {
        guard   let selectedIndexPath = fruitsCollectionView.indexPathsForSelectedItems?.first,
                let selectedCell = fruitsCollectionView.cellForItem(at: selectedIndexPath) as? ImageCell else {
                    assertionFailure()
                    return nil
        }
        return selectedCell
    }
}

extension FruitsViewController: ImageTransitionable {
    var imageViewForTransition: UIImageView? {
        guard let selectedCell = selectedCell() else {
            return nil
        }
        return selectedCell.customImageView
    }
}

extension FruitsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
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
        ImageTransitionDelegate.shared.pushDuration = 0.2
        ImageTransitionDelegate.shared.popDuration = 0.2
        ImageTransitionDelegate.shared.pushAnimationOptions = [.curveEaseOut]
        navigationController?.delegate = ImageTransitionDelegate.shared

        performSegue(withIdentifier: "showFruit", sender: nil)
    }
}

extension FruitsViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectedCell = selectedCell(), let image = selectedCell.customImageView.image, let destination = segue.destination as? FruitViewController else {
            return
        }
        
        destination.dependency = Dependency(image : image)
    }
}

extension FruitsViewController: UICollectionViewDelegateFlowLayout {
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
