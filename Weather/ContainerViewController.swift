//
//  ContainerViewController.swift
//  Weather
//
//  Created by Amanda Harman on 6/17/16.
//  Copyright © 2016 Amanda Harman. All rights reserved.
//

import UIKit

enum SwapSegueIdentifier: String {
    case toTable, toCollection
}

class ContainerViewController: UIViewController {
    
    var transitionInProgress = false
    var currentSegueIdentifier = SwapSegueIdentifier.toTable.rawValue
    var currentVC: UIViewController?
    var newVC: UIViewController?
    var availableVCSegues = [SwapSegueIdentifier.toTable.rawValue, SwapSegueIdentifier.toCollection.rawValue]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        performSegueWithIdentifier(SwapSegueIdentifier.toTable.rawValue, sender: nil)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        newVC = segue.destinationViewController
        
        if childViewControllers.count > 0 {
            if let toNewVC = newVC {
                swap(fromVC: childViewControllers[0], toVC: toNewVC)
            }
        }
        else {
            addChildViewController(segue.destinationViewController)
            let destinationView = segue.destinationViewController.view
            destinationView.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)
            destinationView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
            view.addSubview(destinationView)
            segue.destinationViewController.didMoveToParentViewController(self)
        }
        
        currentVC = newVC
        newVC = nil
    }
    
    func swap(fromVC fromVC: UIViewController, toVC: UIViewController){
        
        toVC.view.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)
        fromVC.willMoveToParentViewController(nil)
        addChildViewController(toVC)
        
        transitionFromViewController(fromVC, toViewController: toVC, duration: 0.0, options: .TransitionCrossDissolve, animations: nil){ (finished) in
            fromVC.removeFromParentViewController()
            toVC.didMoveToParentViewController(self)
            self.transitionInProgress = false
        }
    }
    
    func switchVC(toIndex index: Int){
        guard transitionInProgress == false else {
            return
        }
        transitionInProgress = true
        currentSegueIdentifier = availableVCSegues[index]
        performSegueWithIdentifier(currentSegueIdentifier, sender: nil)
    }
    
}
