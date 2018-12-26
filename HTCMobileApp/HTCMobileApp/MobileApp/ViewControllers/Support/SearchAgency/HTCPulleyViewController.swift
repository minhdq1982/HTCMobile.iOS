//
//  HTCPulleyViewController.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 12/12/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit
import Pulley
import RxSwift

class HTCPulleyViewController: PulleyViewController{
    var mapVC: MapViewController?
    var drawerVC: DrawerMapViewController?
    
    func getMapVC() -> MapViewController? {
        return self.mapVC
    }
    
    func getDrawerVC() -> DrawerMapViewController? {
        return self.drawerVC
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mapView" {
            if let map = segue.destination as? MapViewController {
                mapVC = map
            }
        }else if segue.identifier == "drawerMapView" {
            if let drawer = segue.destination as? DrawerMapViewController {
                drawerVC = drawer
            }
        }
        
        if mapVC != nil && drawerVC != nil {
            mapVC?.delegate = drawerVC
            drawerVC?.delegate = mapVC
        }
    }
}
