//
//  YelpSearchViewController.swift
//  World Restaurants
//
//  Created by Farzad on 2/1/18.
//  Copyright © 2018 Farzad Zamani. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import MapKit

class RestaurantListViewController: UIViewController{

    
    
    @IBOutlet weak var mapView: MKMapView!
    let dataSource = ResturantListDataSource()
    var coordinate:Coordinate?
    var countryGroup:CountryGroup?
    var country:Country?
    var locationManager:UserLocationManager?
    @IBOutlet weak var tableView: UITableView!
 
  
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        
       
        setupTableView()
       loadRestaurantList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(true)
       self.navigationController?.navigationBar.tintColor = UIColor.yellow
       self.navigationController?.navigationBar.isHidden = false
      
        
    }
    
 
    
    func loadRestaurantList() {
        print("load restaurant")
        if let coordinate = coordinate {
        let activityData = ActivityData()
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        
        var term:String
        if let country = country {
            term = country.country
        }else { term = countryGroup!.name}
        
        
       
          
     
        YelpClient.Shared.getRestaurants(searchTerm: term, at: self.coordinate!) {[weak self] result in
            switch result {
            case .success(let restaurants):
                self?.addRestaurantAnotaions(userLocation:(self?.coordinate)!,restaurants: restaurants)
                self?.dataSource.update(with: restaurants, countryGroup: self?.countryGroup)
                self?.tableView.reloadData()
                  NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
            case .failure(let error):
                 NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                alert(view: self!, title: "Error", message: error.localizedDescription)
              
            }
        }
        }
    }
   
    // MARK: - Table View
    func setupTableView() {
        self.tableView.separatorColor = UIColor(white:0.95,alpha:1)
        self.tableView.dataSource = dataSource
        self.tableView.delegate = self
//        self.tableView.rowHeight = UITableViewAutomaticDimension
//        self.tableView.estimatedRowHeight = 150
        
    }
    
    
    func addRestaurantAnotaions(userLocation:Coordinate,restaurants:[Restaurant]) {
        let center = CLLocationCoordinate2D(latitude: userLocation.latitude, longitude: userLocation.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
        
        mapView.setRegion(region, animated: true)
        for restaurant in restaurants {
//            let IsOpenNow = restaurant.isClosed ? "Closed" : "Open"
            let restaurantPin:Pin = Pin(coordinate: restaurant.location, title: restaurant.name, subtitle:nil, restaurantId: restaurant.id)
            
            mapView.addAnnotation(restaurantPin)
           
        }
    
        
    }
  
}
// MARK: - UIMApViewDelegate
extension RestaurantListViewController:MKMapViewDelegate {
    private func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKMarkerAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }else {
        //let pin = annotation as! Pin
            let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "restaurantPin") as! MKMarkerAnnotationView
        annotationView.subtitleVisibility = .visible
        annotationView.titleVisibility = .visible
//        annotationView.markerTintColor = UIColor.yellow
//        annotationView.glyphText = "M"
       
        return annotationView
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
       let pin = view.annotation as! Pin
        performSegue(withIdentifier: "restaurantDetailSegue", sender: pin.restaurantId)
    }
    
}


// MARK: - UITableViewDelegate
extension RestaurantListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let restaurant = dataSource.object(at: indexPath)
        performSegue(withIdentifier: "restaurantDetailSegue", sender: restaurant.id)
    }
}



// MARK: - Navigation
extension RestaurantListViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "restaurantDetailSegue" {
            let vc:RestaurantDetailViewController = (segue.destination as? RestaurantDetailViewController)!
            guard let selectedRestaurantId = sender as? String else {return}
          
             vc.countryGroup = countryGroup
             vc.selectedRestaurantId = selectedRestaurantId
             vc.IsSavedRestaurant = false
            
        }
    }
}



