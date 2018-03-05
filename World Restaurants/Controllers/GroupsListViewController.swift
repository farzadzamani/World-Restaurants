//
//  GroupsListViewController.swift
//  World Restaurants
//
//  Created by Farzad on 2/6/18.
//  Copyright © 2018 Farzad Zamani. All rights reserved.
//

import UIKit

class GroupsListViewController: UITableViewController,UserLocationManagerDelegate {
   
    var selectedCountryGroup:CountryGroup?
    var estimatedRowHeight:CGFloat?
    override func viewDidLoad() {
        super.viewDidLoad()
       UserLocationManager.Shared.delegate = self
        let tableviewsize = tableView.frame.height - (self.tabBarController?.tabBar.frame.size.height)! - UIApplication.shared.statusBarFrame.height
        let heightPerRow = Float(tableviewsize) / Float(CountryGroup.allGroup.count)
        estimatedRowHeight = CGFloat(heightPerRow)
         requestLocationPermission()
        
      
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
       
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = false
       
        
    }
    
    func requestLocationPermission() {
        do {
            
            try UserLocationManager.Shared.requestLocationAuthorization()
        } catch let error {
            alert(view: self, title: "Error", message: "Location Authorization Error: \(error.localizedDescription)")
        }
    }
    
    func locationUpdated(coordinate: Coordinate) {
         self.performSegue(withIdentifier: "restaurantListSeque", sender: nil)
        
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
    }

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CountryGroup.allGroup.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

      return estimatedRowHeight!

    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableGroupViewCell", for: indexPath) as! CountryGroupViewCell
         cell.groupImageView.image = CountryGroup.allGroup[indexPath.row].image
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCountryGroup = CountryGroup.allGroup[indexPath.row]
        UserLocationManager.Shared.requestLocation()
   
       
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "restaurantListSeque" {
            
            
            if let vc:RestaurantListViewController = segue.destination as? RestaurantListViewController {
                vc.countryGroup = self.selectedCountryGroup
                vc.coordinate = UserLocationManager.Shared.userLocationCoordinate
            }
            
        }
    }

  
}
