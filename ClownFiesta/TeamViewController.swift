//
//  TeamViewController.swift
//  ClownFiesta
//
//  Created by iosdev on 21.4.2016.
//  Copyright © 2016 Oliver. All rights reserved.
//

import UIKit
import CoreLocation

class TeamViewController: UIViewController, BeaconProtocol {
    
    // MARK: Properties
    let detector:BeaconDetective = detectorSingleton
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerAsObserver()
        
        //Background of View
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "BlueAppBackground")!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func registerAsObserver() {
        detector.observerViews.append(self)
    }
    
    func notifyObserver() {
        performSegueWithIdentifier("ClueFoundSegue", sender: self)
    }
}
