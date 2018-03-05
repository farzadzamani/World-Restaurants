//
//  LaunchScreenViewController.swift
//  World Restaurants
//
//  Created by Farzad on 3/5/18.
//  Copyright © 2018 Farzad Zamani. All rights reserved.
//

import UIKit

class LaunchScreenViewController: UIViewController,UserLocationManagerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        requestLocationPermission()
        UserLocationManager.Shared.requestLocation()
        // Do any additional setup after loading the view.
    }
   
    func requestLocationPermission() {
        do {
            
            try UserLocationManager.Shared.requestLocationAuthorization()
        } catch let error {
            alert(view: self, title: "Error", message: "Location Authorization Error: \(error.localizedDescription)")
        }
    }
    
    func locationUpdated(coordinate: Coordinate) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
