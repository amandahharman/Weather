//
//  SegementedControlViewController.swift
//  Weather
//
//  Created by Amanda Harman on 6/14/16.
//  Copyright © 2016 Amanda Harman. All rights reserved.
//

import Foundation
import UIKit

class SegementedControlViewController: UIViewController {
    
    
    @IBOutlet weak var containerView: UIView!
    var containerVC: ContainerViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "container" {
                containerVC = segue.destinationViewController as? ContainerViewController
            }
    }
    
    @IBAction func segmentedControlValueChanged(sender: UISegmentedControl) {
        self.containerVC?.switchVC(toIndex: sender.selectedSegmentIndex)
    }

}
