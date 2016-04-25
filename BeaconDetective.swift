//
//  BeaconDetective.swift
//  ClownFiesta
//
//  Created by iosdev on 18.4.2016.
//  Copyright © 2016 Oliver. All rights reserved.
//

import Foundation
import CoreLocation

let detectorSingleton = BeaconDetective()

class BeaconDetective:NSObject, CLLocationManagerDelegate {
    
    // MARK: Properties
    var observerViews = [BeaconProtocol]()
    var beaconFound: Bool = false
    let gameMode: GameController = gameSingleton
    let locationManager = CLLocationManager()
    let rangingRegion = CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "00000000-0000-0000-0000-000000000000")!, identifier: "Beacons")
    
    private override init(){
        super.init()
        if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.AuthorizedWhenInUse) {
            locationManager.requestWhenInUseAuthorization()
        }
        locationManager.delegate = self
        locationManager.startRangingBeaconsInRegion(rangingRegion)

    }
    
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        let knownBeacons = beacons.filter{ $0.proximity != CLProximity.Unknown }
       
        if (knownBeacons.count > 0) {
            let closestBeacon = knownBeacons[0] as CLBeacon
            if closestBeacon.proximity.rawValue <= 1 {
                print("Closest beacon: ", closestBeacon)
                if closestBeacon.minor.integerValue == gameMode.currentClue?.beaconMinor &&
                   closestBeacon.major.integerValue == gameMode.currentClue?.beaconMajor {
                    // confirm clue as Located & mark the clue as Found
                    print("BEACON FOUND!!!!")
                    if gameMode.currentClue?.clueFound == false {
                        gameMode.currentClue?.clueFound = true
                        notifyObserverViews()
                    } else {
                        // HELLO
                    }
                    
                }
            } else {
                // hello
            }
            
        }
    }
    
    // Go through the array of observer ViewControllers and call their notify method
    func notifyObserverViews() {
        for i in observerViews {
            i.notifyObserver()
        }
    }
    
}