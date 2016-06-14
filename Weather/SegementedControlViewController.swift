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
    
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var blueContainer: UIView!
    @IBOutlet weak var redContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        blueContainer.hidden = false
        redContainer.hidden = true
    }
    
    
    @IBAction func segmentedControlValueChanged(sender: UISegmentedControl) {
        
        if segmentedControl.selectedSegmentIndex == 0{
            blueContainer.hidden = false
            redContainer.hidden = true
        }
        if segmentedControl.selectedSegmentIndex == 1 {
            blueContainer.hidden = true
            redContainer.hidden = false
        }
    }

}
