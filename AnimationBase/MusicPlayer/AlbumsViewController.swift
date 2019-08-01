//
//  AlbumsViewController.swift
//  AnimationBase
//
//  Created by Marcos Molero on 29/04/2019.
//  Copyright © 2019 Marcos Molero. All rights reserved.
//

import Foundation
import UIKit

class AlbumsViewController: UIViewController {
    
    private var albumsInteractor: AlbumsInteractor?
    private var selectedSong: Song?
    private var selectedFrame: CGRect?
    
    var songs: [Song] = [Song(artist: "Kendrick Lamar", title: "DNA", artwork: UIImage(named: "damn")!),
                         Song(artist: "Freddie Gibbs", title: "Alexys", artwork: UIImage(named: "twice")!),
                         Song(artist: "Brockhampton", title: "JUNKY", artwork: UIImage(named: "sat")!),
                         Song(artist: "MC Eiht", title: "Represent Like This", artwork: UIImage(named: "west")!),
                         Song(artist: "Tyler the Creator", title: "November", artwork: UIImage(named: "flower")!),
                         Song(artist: "Jay-Z", title: "4:44", artwork: UIImage(named: "four")!),
                         Song(artist: "Joey Bada$$", title: "ROCKABYE BABY", artwork: UIImage(named: "badass")!),
                         Song(artist: "Sean Price", title: "Imperious Rex", artwork: UIImage(named: "imperious")!),
                         Song(artist: "Oddisee", title: "Hold it back", artwork: UIImage(named: "iceburg")!),
                         Song(artist: "J.I.D", title: "Never", artwork: UIImage(named: "never")!)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.delegate = self
        songs.append(contentsOf: songs + songs)
    }
    
    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        if (parent == nil) {
            self.navigationController?.delegate = nil
        }
    }
}

extension AlbumsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return songs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell: ImageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as? ImageCell {
            cell.setup(image: songs[indexPath.row].artwork)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedSong = songs[indexPath.row]
        let theAttributes: UICollectionViewLayoutAttributes! = collectionView.layoutAttributesForItem(at: indexPath)
        selectedFrame = collectionView.convert(theAttributes.frame, to: collectionView.superview)
        performSegue(withIdentifier: "showPlayer", sender: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 3, height: collectionView.frame.width / 3)
    }
}

extension AlbumsViewController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        guard let ci = albumsInteractor else {
            return nil
        }
        
        return ci.transitionInProgress ? albumsInteractor : nil
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let frame = self.selectedFrame else { return nil }
        guard let song = self.selectedSong else { return nil }
        
        switch operation {
        case .push:
            self.albumsInteractor = AlbumsInteractor(attachTo: toVC)
            return CustomAnimator(duration: TimeInterval(UINavigationController.hideShowBarDuration), isPresenting: true, originFrame: frame, image: song.artwork)
        default:
            return CustomAnimator(duration: TimeInterval(UINavigationController.hideShowBarDuration), isPresenting: false, originFrame: frame, image: song.artwork)
        }
    }
}

extension AlbumsViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showPlayer") {
            let playerVc = segue.destination as! PlayerViewController
            playerVc.song = self.selectedSong
        }
    }
}
