//
//  RestaurantDetailTableViewController.swift
//  World Restaurants
//
//  Created by Farzad on 2/2/18.
//  Copyright © 2018 Farzad Zamani. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import MapKit
import CoreData

class RestaurantDetailViewController: UIViewController,UICollectionViewDelegate,NSFetchedResultsControllerDelegate{

   
    @IBOutlet var starReview: [UIImageView]!
    
    var datasource = RestaurantPicturesDataSource()
    var restaurantDidSaved = false
    var selectedRestaurantId:String?
    var selectedRestaurant:Restaurant?
    var fetchedRestaurant:SavedRestaurant?
    var countryGroup:CountryGroup?
    var IsSavedRestaurant:Bool?
    
    @IBOutlet weak var picturesCollectionView: UICollectionView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var ratingsCountLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var directionButton: UIButton!
    
    @IBOutlet weak var parentStackView: UIStackView!
    
    lazy var fetchResultController: NSFetchedResultsController<SavedRestaurant> = {
        
        let fr = NSFetchRequest<SavedRestaurant>(entityName: "SavedRestaurant")
      
        fr.sortDescriptors = []
        
        fr.predicate = NSPredicate(format: "restaurantId == %@", self.selectedRestaurantId!)
        let frc = NSFetchedResultsController(fetchRequest: fr, managedObjectContext: CoreDataStack.Shared.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        return frc
    }()
    
    lazy var deleteRestaurant = {(fetchedRestaurant:SavedRestaurant) -> Error? in
        CoreDataStack.Shared.managedObjectContext.delete(fetchedRestaurant)
        self.navigationController?.popViewController(animated: true)
        return CoreDataStack.Shared.managedObjectContext.saveChanges()
    }
    
    lazy var saveRestaurant = {(newRestaurant:Restaurant) -> Error? in
        _ = SavedRestaurant(restaurant: newRestaurant, countryGroup: self.countryGroup!, context: CoreDataStack.Shared.managedObjectContext)
        self.navigationController?.popViewController(animated: true)
        return CoreDataStack.Shared.managedObjectContext.saveChanges()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.tintColor = UIColor.yellow
        self.navigationController?.navigationBar.isHidden = false
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picturesCollectionView.delegate = self
        mapView.delegate = self
        
        mapView.RoundedView(borderColor: UIColor.yellow)
        saveButton.CornerRadius()
        directionButton.CornerRadius()
        
        let activityData = ActivityData()
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        parentStackView.isHidden = true
        
        if IsSavedRestaurant! {
            
            saveButton.titleLabel?.textColor = UIColor.white
            saveButton.setTitle("Remove Restaurant", for: .normal)
            
        }else {
            
            saveButton.titleLabel?.textColor = UIColor.white
           saveButton.setTitle("Save Restaurant", for: .normal)
        }
        YelpClient.Shared.getRestaurantDetail(restaurantId: selectedRestaurantId! , compilition: { [weak self] result in
            switch result {
            case .success(let restaurant):
                
                if let viewModel = RestaurantDetailViewModel(restaurant:restaurant){
                    self?.selectedRestaurant = restaurant
                    self?.ratingStars(with: restaurant.rating)
                    self?.configure(with: viewModel)
                    self?.addRestaurantPin(with: restaurant)
                    NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                    self?.parentStackView.isHidden = false
                    self?.datasource.update(with: restaurant.photos)
                    self?.picturesCollectionView.dataSource = self?.datasource
                    self?.selectedRestaurant = restaurant
                }
                
            case .failure(let error):
                  NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                alert(view: self!, title: "Error", message: error.localizedDescription)
                
            }            })
        
        
       
    }
    
    func addRestaurantPin(with restaurant:Restaurant) {
        let center = CLLocationCoordinate2D(latitude: restaurant.location.latitude, longitude: restaurant.location.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        
        mapView.setRegion(region, animated: true)
      
        mapView.addAnnotation(Pin(coordinate: restaurant.location, title: restaurant.name, subtitle: nil, restaurantId: nil))
    
    }
 
    func configure(with viewModel: RestaurantDetailViewModel) {
        restaurantNameLabel.text = viewModel.restaurantName
        priceLabel.text = viewModel.price
        ratingsCountLabel.text = viewModel.ratingsCount
        categoriesLabel.text = viewModel.categories
        hoursLabel.text = viewModel.hours
        currentHoursStatusLabel.text = viewModel.currentStatus
        
    }
    
    @IBOutlet weak var currentHoursStatusLabel: UILabel! {
        didSet {
            if currentHoursStatusLabel.text == "Open" {
                currentHoursStatusLabel.textColor = UIColor(displayP3Red: 2/255.0, green: 192/255.0, blue: 97/255.0, alpha:  1.0)
                
            } else {
                currentHoursStatusLabel.textColor = UIColor(displayP3Red: 209/255.0, green: 47/255.0, blue: 27/255.0, alpha: 1.0)
                
            }
        }
    }
    
    @IBAction func saveRestaurant(_ sender: Any) {
       // MARK - Delete Restaurant
        if IsSavedRestaurant! {
            confirmAlert(view: self, title: "Confirm", message: "Are You Sure To Remove \(fetchedRestaurant!.name)", action: { (action) in
                if let error = self.deleteRestaurant(self.fetchedRestaurant!) {
                    alert(view: self, title: "Process Failed", message: "\(error.localizedDescription)")
                }else {
                    alert(view: self, title: "Info", message: "Successfully Removed From Saved List.")
                }
            })
          
        }else {
             // MARK - Save Restaurant
             if IsRestaurantSavedBefor() {
             if let error = saveRestaurant(selectedRestaurant!){
                alert(view: self, title: "Process Failed", message: "\(error.localizedDescription)")
            }else {
                alert(view: self, title: "Info", message: "\(selectedRestaurant!.name) Saved to List.")
            }
            }else {
                 alertWithViewDismiss(view: self, title: "Info", message: "\(fetchResultController.fetchedObjects?[0].name) already saved on your List.")
            }
        }
    }
    
    
    private func IsRestaurantSavedBefor() -> Bool {
        do {
            try fetchResultController.performFetch()
        }catch{alert(view: self, title: "Process Failed", message: "\(error.localizedDescription)")}
        
        if fetchResultController.fetchedObjects?.count == 0 {
            return true
        }
        return false
    }
    
    @IBAction func getDirection(_ sender: Any) {
        let placemark = MKPlacemark(coordinate: mapView.annotations[0].coordinate)
        let mapItem = MKMapItem(placemark:placemark)
        mapItem.name = selectedRestaurant?.name
        mapItem.openInMaps(launchOptions: nil)
        
    }
    
    func ratingStars(with reviewRate: Double) {
      
        let rating = Int(reviewRate)
        var half = Double(rating).remainder(dividingBy: reviewRate)
        
        for star in starReview {
            if star.tag <= rating {
               
               star.image = #imageLiteral(resourceName: "fullstar")
            }else if half != 0.0 {
                 star.image = #imageLiteral(resourceName: "halfstar")
                 half = 0.0
               
            }else {
                 star.image = #imageLiteral(resourceName: "emptystar")
            }
            
        }
        
        
    }
   
}
// MARK: - UIMApViewDelegate
extension RestaurantDetailViewController:MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let pin = annotation as! Pin
        let annotationView = MKAnnotationView(annotation: pin, reuseIdentifier: "pin")
        annotationView.image = #imageLiteral(resourceName: "foodPin")
       
        let transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        annotationView.transform = transform
        
        return annotationView
    }
    
    
}
