//
//  LunchScreenViewController.swift
//  World Restaurants
//
//  Created by Farzad on 3/5/18.
//  Copyright © 2018 Farzad Zamani. All rights reserved.
//

import UIKit

class LunchScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UserLocationManager.Shared.delegate = self
        // Do any additional setup after loading the view.
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
