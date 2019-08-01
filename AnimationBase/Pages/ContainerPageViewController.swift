//
//  OnboardingViewController.swift
//  AnimationBase
//
//  Created by Marcos Molero on 29/04/2019.
//  Copyright © 2019 Marcos Molero. All rights reserved.
//

import Foundation
import UIKit
import Lottie

class ContainerPageViewController: UIPageViewController {
    
    @IBOutlet weak var animationView: AnimationView!
    
//    fileprivate lazy var orderedViewController: [UIViewController] = {
//        return [self.getViewController(withIdentifier: PageViews.firstPV.rawValue),
//                self.getViewController(withIdentifier: PageViews.secondPV.rawValue),
//                self.getViewController(withIdentifier: PageViews.thirdPV.rawValue),
//                self.getViewController(withIdentifier: PageViews.fourthPV.rawValue)]
//    }()
//
//    fileprivate func getViewController(withIdentifier identifier: String) -> UIViewController {
//        return (storyboard?.instantiateViewController(withIdentifier: identifier))!
//    }
    
    fileprivate lazy var orderedViewController: [UIViewController] = {
        return [self.getViewController(lottieName: "one"),
                self.getViewController(lottieName: "two"),
                self.getViewController(lottieName: "three"),
                self.getViewController(lottieName: "four")]
    }()
    
    fileprivate func getViewController(lottieName: String) -> UIViewController {
        // Crear instancia de storyboard
        let lottieViewController = LottieViewController() // TODO: In storyboard?
        lottieViewController.lottieName = lottieName
        return lottieViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        
        if let firstVC = orderedViewController.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }
}

extension ContainerPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewController.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return orderedViewController.last
        }
        
        guard orderedViewController.count > previousIndex else {
            return nil
        }
        
        return orderedViewController[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewController.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        
        guard nextIndex < orderedViewController.count else {
            return orderedViewController.first
        }
        
        guard orderedViewController.count > nextIndex else {
            return nil
        }
        
        return orderedViewController[nextIndex]
    }
    
    func presentationCount(for: UIPageViewController) -> Int {
        return orderedViewController.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
